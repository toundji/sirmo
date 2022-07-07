/* eslint-disable prettier/prettier */
import { BadRequestException, forwardRef, Inject, Injectable, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, UpdateResult } from 'typeorm';
import { User } from '../entities/user.entity';
import { Conducteur } from '../entities/conducteur.entity';
import { UserService } from './user.service';
import { RoleService } from './roles.service';
import { Role } from '../entities/role.entity';
import { Compte } from '../entities/compte.entity';
import { CompteService } from './compte.service';
import { RoleName } from 'src/enums/role-name';
import { CreateUserConducteurDto } from '../createDto/user-conducteur.dto';
import { CreateConducteurDto } from '../createDto/conducteur.dto';
import { StatutConducteur } from 'src/enums/statut-zem copy';
import { UserConducteurDG_Dto } from './../createDto/user-conducteur-dg.dto';
import { VehiculeService } from './vehicule.service';
import { ArrondissementService } from 'src/principale/services/arrondissement.service';
import { Licence } from '../entities/licence.entity';
import { PreLicenceDto } from './../createDto/pre-licence.dto';
import { CreateLicenceDto } from './../createDto/create-licence.dto';

@Injectable()
export class ConducteurService {
  constructor(@InjectRepository(Conducteur) private conducteurRepository: Repository<Conducteur>,
    private readonly userService:UserService,
    private readonly roleService:RoleService,
    private readonly compteService:CompteService,
    @Inject(forwardRef(() => VehiculeService))
    private readonly vehiculeService:VehiculeService,
    private readonly arrondissmentService:ArrondissementService,

    
  ) {}
  async create(createConducteurDto: CreateUserConducteurDto) {
    const conducteur:Conducteur = new Conducteur();

    Object.keys(createConducteurDto).forEach(cle=>{conducteur[cle] = createConducteurDto[cle]});
    const role:Role = await this.roleService.findOneByName(RoleName.ZEM);
    const user: User = await this.userService.createWithRole(createConducteurDto.user, [role]);
    conducteur.user = user;
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

    Object.keys(body).forEach(cle=>{conducteur[cle] = body[cle]});
    const role:Role = await this.roleService.findOneByName(RoleName.ZEM);
    const user: User = await this.userService.createWithRole(body.user, [role]);
    conducteur.user = user;
    const conducteurSaved : Conducteur= await this.conducteurRepository.save(conducteur);
    // const compte: Compte = 
   
      await this.compteService.create( Compte.create({user:user, montant:0})).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");  
      });
      let owner: User = user
      if(body.proprietaire!=null){
        const role:Role = await this.roleService.findOneByName(RoleName.PROPRIETAIRE);
        const owner: User = await this.userService.createWithRole(body.user, [role]);
      }

      const vehicule = this.vehiculeService.createWith(body.vehicule, owner, conducteurSaved);

      // const current: new Date();
      // const licenDto:CreateLicenceDto = {
      //   montant:20200,
      //   dateDebut:new Date(),
      //   dateFin:new Date()
      // }

      return conducteurSaved;
  }

  async createForUser(createConducteurDto: CreateConducteurDto) {
    const conducteur:Conducteur = new Conducteur();
    Object.keys(createConducteurDto).forEach(cle=>{conducteur[cle] = createConducteurDto[cle]});

      const user: User =  await this.userService.findOne(createConducteurDto.userId);
      const role:Role = await this.roleService.findOneByName(RoleName.ZEM);
      const index:number = user.roles.indexOf(role);
      if( index == -1){
        user.roles.push(role);
        this.userService.changeWithoutControle(user);
      }
      conducteur.user = user;
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

  findOne(id: number) {
    return this.conducteurRepository.findOneOrFail(id).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });
  }

  findOneByCip(nic: number):Promise<Conducteur> {
    return this.conducteurRepository.find({where:{ nic: nic }, relations: ["vehicule"]})    .then((list)=>{
      if(list.length>1)return list[0];
      console.log("Le conducteur spécifié n'existe pas");
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    })
    .catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });
  }

  findForUser(user_id: number):Promise<Conducteur[]> {
    return this.conducteurRepository.find({where:{ user: User.create({id: user_id}) }}).catch((error)=>{
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
    return this.conducteurRepository.find({where:{ user: user}})
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
