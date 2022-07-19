/* eslint-disable prettier/prettier */
import { BadRequestException, forwardRef, Inject, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, UpdateResult } from 'typeorm';
import { User } from '../../entities/user.entity';
import { UserService } from './../../services/user.service';
import { Role } from '../../entities/role.entity';
import { Compte } from '../../entities/compte.entity';
import { CompteService } from './../../services/compte.service';
import { RoleName } from 'src/enums/role-name';
import { CreateUserConducteurDto } from '../../createDto/user-conducteur.dto';
import { StatutConducteur } from 'src/enums/statut-zem copy';
import { VehiculeService } from './../../services/vehicule.service';
import { Mairie } from './../../entities/mairie.entity';
import { MairieService } from '../../services/mairie.service';
import { Conducteur } from './../../entities/conducteur.entity';
import { CreateUserConducteurCptDto } from '../dto/user-conducteur-cpt.dto';
import * as fs from 'fs';
import { UserConducteurDG_Dto } from '../dto/user-conducteur-dg.dto';
import { Express } from 'multer';
import { Fichier } from './../../entities/fichier.entity';
import { profile } from 'console';
import { ApiConstante } from './../../utilis/api-constantes';
import { ConducteurService } from './../../services/conducteur.service';
import { Arrondissement } from 'src/principale/entities/arrondissement.entity';
import { ArrondissementService } from 'src/principale/services/arrondissement.service';



@Injectable()
export class ConducteurAdminService {
  constructor(@InjectRepository(Conducteur) private conducteurRepository: Repository<Conducteur>,
    private readonly userService:UserService,
    private readonly mairieService:MairieService,
    private readonly compteService:CompteService,
    @Inject(forwardRef(() => VehiculeService))
    private readonly vehiculeService:VehiculeService,
    private readonly conducteurService:ConducteurService,
    private readonly arrondissementService: ArrondissementService,

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
    const mairie:Mairie = await this.mairieService.findOne(body.mairie_id);

    const user: User = await this.userService.createWithRole(data, [RoleName.CONDUCTEUR]);
    conducteur.user = user;

    conducteur.mairie = mairie;
    const conducteurSaved : Conducteur= await this.conducteurRepository.save(conducteur);

    const id:number=  Date.now();
    if(body.profile_image){
      let bitmap: Buffer =  Buffer.from(body.profile_image, 'base64');
      if(!fs.existsSync(ApiConstante.profile_path)){
        fs.promises.mkdir(ApiConstante.profile_path, { recursive: true }).catch(console.error);
      }
      const filename:string = '/conducteur_profile'+ id + Date.now() + '.png';

      fs.writeFileSync(ApiConstante.profile_path + filename,   bitmap);

      let profile:Fichier = Fichier.create({
        nom: "profile",
        path: ApiConstante.profile_path + filename,
        entity: Conducteur.entityName,
        entityId: conducteur.id
      });
      profile = await Fichier.save(profile);
      user.profile_image = profile.path;
      await user.save();
    }
    
    if(body.idCarde_image){
     
      let bitmap: Buffer =  Buffer.from(body.idCarde_image, 'base64');
      const filename:string = '/carte_identite'+ id + Date.now() + '.png';

      if(!fs.existsSync(ApiConstante.id_carde_path)){
        fs.promises.mkdir(ApiConstante.id_carde_path, { recursive: true }).catch(console.error);
      }
      fs.writeFileSync(ApiConstante.id_carde_path + filename, bitmap);

      let id_carde_Image:Fichier = Fichier.create({
        nom:"cate d'identié",
        path: ApiConstante.id_carde_path + filename,
        entity: Conducteur.entityName,
        entityId: conducteur.id
      });

     id_carde_Image = await Fichier.save(id_carde_Image)
     conducteur.idCarde_image =  id_carde_Image.path;
     await conducteurSaved.save();

    }

    // const compte: Compte = 
   
      await this.compteService.create( Compte.create({user:user, montant:0})).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");  
      });
      conducteurSaved.profile_image = body.profile_image;
      conducteurSaved.idCarde_image = body.idCarde_image;
      return body;
  }

  async updateConducteur(body: CreateUserConducteurCptDto):Promise<CreateUserConducteurCptDto> {
    const conducteur:Conducteur = await this.conducteurService.findOneByCipOrNip(body.nip);

    conducteur.ifu=body.ifu ?? conducteur.ifu;
    conducteur.nip=body.nip ?? conducteur.nip;
    conducteur.cip=body.cip ?? conducteur.cip;
    conducteur.permis=body.permis ?? conducteur.permis;
    conducteur.date_optention_permis=body.date_optention_permis ?? conducteur.date_optention_permis;
    conducteur.date_delivrance_ifu=body.date_delivrance_ifu ?? conducteur.date_delivrance_ifu;
    conducteur.idCarde=body.idCarde ?? conducteur.idCarde;
    conducteur. ancienIdentifiant=body.ancienIdentifiant??conducteur. ancienIdentifiant;
    // conducteur.idCarde_image = body.profile_image;
    // conducteur.idCarde_image = body.idCarde_image;

    if(body.mairie_id){
      const mairie:Mairie = await this.mairieService.findOne(body.mairie_id);
      conducteur.mairie = mairie;
    }

    if(body.idCarde_image){
     
      let bitmap: Buffer =  Buffer.from(body.idCarde_image, 'base64');
      const filename:string = '/carte_identite'+ conducteur.id + Date.now() + '.png';

      if(!fs.existsSync(ApiConstante.id_carde_path)){
        fs.promises.mkdir(ApiConstante.id_carde_path, { recursive: true }).catch(console.error);
      }
      fs.writeFileSync(ApiConstante.id_carde_path + filename, bitmap);

      let id_carde_Image:Fichier = Fichier.create({
        nom:"cate d'identié",
        path: ApiConstante.id_carde_path + filename,
        entity: Conducteur.entityName,
        entityId: conducteur.id
      });

     id_carde_Image = await Fichier.save(id_carde_Image)
     conducteur.idCarde_image =  id_carde_Image.path;
     await conducteur.save();

    }

      conducteur.user.nom= body.nom;
      conducteur.user.prenom= body.prenom;
      conducteur.user. genre=body.genre;
      conducteur.user.password= body.password;
      conducteur.user.date_naiss= body.date_naiss;
      conducteur.user. phone=body.phone;

      if(body.arrondissement){
        const arrondisement: Arrondissement =
        await this.arrondissementService.findFirstByName(body.arrondissement);
        conducteur.user.arrondissement = arrondisement;
      }

    if(body.profile_image){
      let bitmap: Buffer =  Buffer.from(body.profile_image, 'base64');
      if(!fs.existsSync(ApiConstante.profile_path)){
        fs.promises.mkdir(ApiConstante.profile_path, { recursive: true }).catch(console.error);
      }
      const filename:string = '/conducteur_profile'+ Date.now() + '.png';

      fs.writeFileSync(ApiConstante.profile_path + filename,   bitmap);

      let profile:Fichier = Fichier.create({
        nom: "profile",
        path: ApiConstante.profile_path + filename,
        entity: Conducteur.entityName,
        entityId: conducteur.id
      });
      profile = await Fichier.save(profile);
      conducteur.user.profile_image = profile.path;
    }
    await User.save(conducteur.user);
    await Conducteur.save(conducteur);
    return body;
  }

  async createByDG(body: UserConducteurDG_Dto) {
    const conducteur:Conducteur = new Conducteur();

    const {mairie_id, ...res} = body;

    Object.keys(res).forEach(cle=>{conducteur[cle] = res[cle]});

    const user: User = await this.userService.createWithRole(body.user, [RoleName.CONDUCTEUR]);
    conducteur.user = user;

   
    

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
         owner= await this.userService.createWithRole(body.user, [RoleName.CONDUCTEUR]);
      }

      
    if(body.profile_image){
      let bitmap: Buffer =  Buffer.from(body.profile_image, 'base64');
      const filename:string = '/conducteur_profile' + Date.now() + '.png';
      if(!fs.existsSync(ApiConstante.profile_path)){
        fs.promises.mkdir(ApiConstante.profile_path, { recursive: true }).catch(console.error);
      }
      fs.writeFileSync(ApiConstante.profile_path + filename,   bitmap);

      let profile:Fichier = Fichier.create({
        nom: "profile",
        path: ApiConstante.profile_path + filename,
        entity: Conducteur.entityName,
        entityId: conducteur.id
      });
      profile = await Fichier.save(profile);
      user.profile_image = profile.path;
      await user.save();
    }
    

      const vehicule = await this.vehiculeService.createWith(body.vehicule, owner, conducteurSaved, mairie);
      vehicule.conducteur = null;
      conducteurSaved.vehicule = vehicule;

     conducteurSaved = await Conducteur.save(conducteurSaved).catch((error)=>{
      console.log(conducteurSaved);
        throw new BadRequestException("Nous ne parvenons pas à mettre à jour le véhicule");
      });
      if(body.idCarde_image){
     
        let bitmap: Buffer =  Buffer.from(body.idCarde_image, 'base64');
        const filename:string = '/carte_identite' + Date.now() + '.png';
        
        if(!fs.existsSync(ApiConstante.id_carde_path)){
          fs.promises.mkdir(ApiConstante.id_carde_path, { recursive: true }).catch(console.error);
        }
        fs.writeFileSync(ApiConstante.id_carde_path + filename, bitmap);
  
        let id_carde_Image:Fichier = Fichier.create({
          nom:"cate d'identié",
          path: ApiConstante.id_carde_path + filename,
          entity: Conducteur.entityName,
          entityId: conducteur.id
        });
        id_carde_Image = await Fichier.save(id_carde_Image)
       conducteur.idCarde_image = id_carde_Image.path;
       await conducteurSaved.save();
      }
      return conducteurSaved;
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
    return this.conducteurRepository.findOneOrFail(id, {relations:["mairie", "vehicule"]}).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });
  }

  async findOneByCipOrNip(nic: string):Promise<CreateUserConducteurCptDto> {
    const conducteur:Conducteur = await this.conducteurRepository.find({where:[{ nic: nic }, { nip: nic }], relations: ["vehicule"]})    .then((list)=>{
      if(list.length>0)return list[0];
      console.log("Le conducteur spécifié n'existe pas");
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    }).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le conducteur spécifié n'existe pas");
    });

    let id_card:string='';

    if(conducteur.idCarde_image){
      const fichier:Fichier = await Fichier.findOne(+conducteur.idCarde_image);
      id_card = fs.readFileSync(fichier.path).toString('base64');
    }


    const driver: CreateUserConducteurCptDto = {
    ifu: conducteur.ifu ,
    cip: conducteur.cip,
    nip: conducteur.nip,
    permis: conducteur.permis,
    date_optention_permis: conducteur.date_optention_permis,
    date_delivrance_ifu: conducteur.date_delivrance_ifu,
    idCarde: conducteur.idCarde,
    ancienIdentifiant:conducteur.ancienIdentifiant ,
    mairie_id: conducteur.mairie?.id,
    nom: conducteur.user?.nom ,
    prenom: conducteur.user?.prenom,
    genre: conducteur.user?.genre,
    password: conducteur.user?.password,
    date_naiss: conducteur.user?.date_naiss,
    phone: conducteur.user?.phone,
    profile_image:  fs.readFileSync(conducteur.user.profile_image).toString('base64'),
    idCarde_image: id_card ,
    }
    return driver ;
  }
 

  async remove(id: number) {
    const  conducteur:Conducteur = await this.findOne(id);
    const index:number = conducteur.user.roles.indexOf(RoleName.CONDUCTEUR);
    conducteur.user.roles.splice(index, 1);
    await User.save(conducteur.user);
      return this.conducteurRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le conducteur spécifié n'existe pas ou dépend d'autre données");
      });

  }

}
