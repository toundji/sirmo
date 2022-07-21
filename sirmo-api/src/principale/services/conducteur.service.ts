/* eslint-disable prettier/prettier */
import { BadRequestException, forwardRef, Inject, Injectable, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, UpdateResult } from 'typeorm';
import { User } from '../entities/user.entity';
import { UserService } from './user.service';
import { RoleService } from './roles.service';
import { Role } from '../entities/role.entity';
import { Compte } from '../entities/compte.entity';
import { CompteService } from './compte.service';
import { RoleName } from 'src/enums/role-name';
import { CreateUserConducteurDto } from '../createDto/user-conducteur.dto';
import { CreateConducteurDto } from '../createDto/conducteur.dto';
import { StatutConducteur } from 'src/enums/statut-zem copy';
import { VehiculeService } from './vehicule.service';
import { ArrondissementService } from 'src/principale/services/arrondissement.service';
import { Mairie } from './../entities/mairie.entity';
import { MairieService } from './mairie.service';
import { Conducteur } from './../entities/conducteur.entity';
import { CreateUserConducteurCptDto } from '../admin/dto/user-conducteur-cpt.dto';
import { writeFileSync } from 'fs';
import { UserConducteurDG_Dto } from '../admin/dto/user-conducteur-dg.dto';
import { Vehicule } from '../entities/vehicule.entity';

@Injectable()
export class ConducteurService {
  constructor(@InjectRepository(Conducteur) private conducteurRepository: Repository<Conducteur>,
    private readonly userService:UserService,
    private readonly mairieService:MairieService,
    private readonly compteService:CompteService,
    @Inject(forwardRef(() => VehiculeService))
    private readonly vehiculeService:VehiculeService,

    
  ) {}
  async create(body: CreateUserConducteurDto) {
    const conducteur:Conducteur = new Conducteur();

    Object.keys(body).forEach(cle=>{conducteur[cle] = body[cle]});
    const user: User = await this.userService.createWithRole(body.user, [RoleName.CONDUCTEUR]);
    conducteur.user = user;
    const mairie:Mairie = await this.mairieService.findOne(body.mairie_id);
    conducteur.mairie = mairie;
    const conducteurSaved : Conducteur= await this.conducteurRepository.save(conducteur);

    // const compte: Compte = 
   
      await this.compteService.create( Compte.create({user:user, montant:0})).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");  
      });
      return conducteurSaved;
  }

  async createConducteur(body: CreateUserConducteurCptDto) {
    const conducteur:Conducteur = new Conducteur();

    conducteur.ifu=body.ifu;
    conducteur.nip=body.nip; 
    conducteur.cip=body.cip;
    conducteur. permis=body.permis;
    conducteur.date_optention_permis=body.date_optention_permis;
    conducteur.date_delivrance_ifu=body.date_delivrance_ifu; 
    conducteur.idCarde=body.idCarde;
    conducteur. ancienIdentifiant=body.ancienIdentifiant;
    // conducteur.idCarde_image = body.profile_image;
    // conducteur.idCarde_image = body.idCarde_image;


    const data:any = {
      nom: body.nom,
      prenom: body.prenom,
      genre:body.genre, 
      password: body.password,
      date_naiss: body.date_naiss, 
      phone:body.phone,
      arrondissement: body.arrondissement
    };

    const user: User = await this.userService.createWithRole(data, [RoleName.CONDUCTEUR]);
    conducteur.user = user;

    const mairie:Mairie = await this.mairieService.findOne(body.mairie_id);
    conducteur.mairie = mairie;
    const conducteurSaved : Conducteur= await this.conducteurRepository.save(conducteur);

    // const compte: Compte = 

      await this.compteService.create( Compte.create({user:user, montant:0})).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");  
      });
      return conducteurSaved;
  }

  async createByDG(body: UserConducteurDG_Dto) {
    const conducteur:Conducteur = new Conducteur();

    const {mairie_id, ...res} = body;

    Object.keys(res).forEach(cle=>{conducteur[cle] = res[cle]});

    const user: User = await this.userService.createWithRole(body.user, [RoleName.CONDUCTEUR]);
    conducteur.user = user;

    writeFileSync('./files/profiles/profile_zem'+user.id + '.png', conducteur.profile_image);

    const mairie:Mairie = await this.mairieService.findOne(body.mairie_id);
    conducteur.mairie = mairie;

    let conducteurSaved : Conducteur = await this.conducteurRepository.save(conducteur);

    // const compte: Compte = 
   
      await this.compteService.create( Compte.create({user:user, montant:0})).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");  
      });

      let owner: User = user
      if(body.proprietaire!=null){
         owner= await this.userService.createWithRole(body.user, [RoleName.PROPRIETAIRE]);
      }

      const vehicule = await this.vehiculeService.createWith(body.vehicule, owner, conducteurSaved, mairie);
      vehicule.conducteur = null;
      conducteurSaved.vehicule = vehicule;

     conducteurSaved = await Conducteur.save(conducteurSaved).catch((error)=>{
      console.log(conducteurSaved);
        throw new BadRequestException("Nous ne parvenons pas à mettre à jour le véhicule");
      });
      return conducteurSaved;
  }

  async createForUser(createConducteurDto: CreateConducteurDto) {
    const {mairie_id, ...res} = createConducteurDto;

    const conducteur:Conducteur = new Conducteur();
    Object.keys(res).forEach(cle=>{conducteur[cle] = createConducteurDto[cle]});

      const user: User =  await this.userService.findOne(createConducteurDto.userId);
      const index:number = user.roles.indexOf(RoleName.CONDUCTEUR);
      if( index == -1){
        user.roles.push(RoleName.CONDUCTEUR);
        this.userService.changeWithoutControle(user);
      }
      conducteur.user = user;

      // const file:File = fs.writeFileSync();

      const mairie:Mairie = await this.mairieService.findOne(createConducteurDto.mairie_id);
      conducteur.mairie = mairie;

      const conducteurSaved: Conducteur= await this.conducteurRepository.save(conducteur);
      // const compte: Compte = 
      await this.compteService.create(Compte.create({user:user, montant:0, id:user?.id})).catch((error)=>{

      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      });
      return conducteurSaved;
  }

  async requestByUser(createConducteurDto: CreateConducteurDto, user?:User) {
     await this.findForUser(user.id).then((conducteurs:Conducteur[])=>{
      if(conducteurs.length>0) throw new BadRequestException("Vous êtes déjà un conducteur");
      return [];
    })
    const conducteur:Conducteur = new Conducteur();
    Object.keys(createConducteurDto).forEach(cle=>{conducteur[cle] = createConducteurDto[cle]});

      conducteur.user = user;
      conducteur.statut = StatutConducteur.DEMANDE;
      const conducteurSaved: Conducteur= await this.conducteurRepository.save(conducteur);

      await this.compteService.create(Compte.create({user:user, montant:0, id:user?.id})).catch((error)=>{

      console.log(error);
      throw new BadRequestException("Création de conducteur: Données invalides");
      });
      return conducteurSaved;
  }

  createAll(createConducteurDto: CreateConducteurDto[]) {
      return this.conducteurRepository.save(createConducteurDto).catch((error)=>{
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      });
  }

  findAll() : Promise<Conducteur[]>{
    return this.conducteurRepository.find();
  }

  findByStatus(status: StatutConducteur) : Promise<Conducteur[]>{
    return this.conducteurRepository.find({where:{statut: status}}).catch((error)=>{
      console.log(error);
      throw new BadRequestException("Erreur pendant la récupération des conducteurs. Veillez reprendre ou contacter un administrateur si cela persiste");
    });
  }

  findOne(id: number):Promise<Conducteur> {
    return this.conducteurRepository.findOneOrFail(id, {relations:["mairie", "vehicule"]}).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });
  }

  getVehicule(id: number) :Promise<Vehicule>{
    return this.conducteurRepository.findOneOrFail(id, {relations:["vehicule"]}).then((driver)=>{
      return driver.vehicule;
    })
    .catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });
  }

  findOneByCipOrNip(nicOrNip: string):Promise<Conducteur> {
    return this.conducteurRepository.find({where:[{ nic: nicOrNip }, {nip: nicOrNip}], relations: ["vehicule"]})    .then((list)=>{
      if(list.length>0)return list[0];
      console.log("Le conducteur spécifié n'existe pas");
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    })
    .catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });
  }

  findForUser(user_id: number):Promise<Conducteur[]> {
    return this.conducteurRepository.find({where:{ user: User.create({id: user_id}) ,relations: ["vehicule"]}}).catch((error)=>{
      console.log(error);

      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });
  }

  findActifForUser(user_id: number):Promise<Conducteur> {
    const user:User = User.create({id: user_id});
    return this.conducteurRepository.find({where:{ user: user, statut: StatutConducteur.ACTIF}})
    .then((conducteurs:Conducteur[])=>{
      if(conducteurs.length>0)return conducteurs[0];
      throw new NotFoundException();
    })

    .catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });
  }

  findOfUser(user_id: number): Promise<Conducteur[]> {
    const user:User = User.create({id: user_id});
    return this.conducteurRepository.find({where:{ user: user},relations: ["vehicule"]})
    .catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });
  }

  update(id: number, updateConducteurDto: Conducteur): Promise<Conducteur> {
   
      return this.conducteurRepository.update(id, updateConducteurDto). then((conducteur: UpdateResult) => conducteur.raw).catch((error)=>{
        console.log(error);
       throw new NotFoundException("Le conducteur spécifié n'existe pas");
      });
  }

  changed(id:number, updateConducteurDto: Conducteur){
    
      this.findOne(id);
      updateConducteurDto.id = id;
     return this.conducteurRepository.save(updateConducteurDto).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    
     });

  }

  remove(id: number) {
   
      return this.conducteurRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le conducteur spécifié n'existe pas ou dépend d'autre données");
      
      });

   
  }

}
