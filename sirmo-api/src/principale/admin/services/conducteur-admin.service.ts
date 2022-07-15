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



@Injectable()
export class ConducteurAdminService {
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

    const id:number=  Date.now();
    if(body.profile_image){
      const parties:string[] =  body.profile_image.split(";");
      const mimetype:string = parties[0].split(":")[1];
      const extension:string = mimetype.split("/")[1];
      const base64 = parties[1];
      fs.writeFileSync('./files/profiles/profile_zem_'+ id + '.'+ extension, base64);
      let profile:Fichier = Fichier.create({
        nom: "profile",
        path: './files/profiles/profile_zem_'+ id + '.'+ extension,
        mimetype: mimetype,
        entity: Conducteur.entityName,
        entityId: conducteur.id
      });
      profile = await Fichier.save(profile);
      user.profile = profile;
      await user.save();
    }
    
    if(body.idCarde_image){
      const parties:string[] =  body.idCarde_image.split(";");
      const mimetype:string = parties[0].split(":")[1];
      const extension:string = mimetype.split("/")[1];
      const base64 = parties[1];
      fs.writeFileSync('./files/carteIdentite/idCarte_'+ id + '.' + extension, base64);

      let id_carde_Image:Fichier = Fichier.create({
        nom:"cate d'identié",
        path: './files/carteIdentite/idCarte_' + id + '.' + extension,
        mimetype: mimetype,
        entity: Conducteur.entityName,
        entityId: conducteur.id
      });

     id_carde_Image = await Fichier.save(id_carde_Image)
     conducteur.idCarde_image = ""+id_carde_Image.id;
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

  async createByDG(body: UserConducteurDG_Dto) {
    const conducteur:Conducteur = new Conducteur();

    const {mairie_id, ...res} = body;

    Object.keys(res).forEach(cle=>{conducteur[cle] = res[cle]});

    const user: User = await this.userService.createWithRole(body.user, [RoleName.CONDUCTEUR]);
    conducteur.user = user;

    fs.writeFileSync('./files/profiles/profile_zem'+user.id + '.png', conducteur.profile_image);

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

      const vehicule = await this.vehiculeService.createWith(body.vehicule, owner, conducteurSaved, mairie);
      vehicule.conducteur = null;
      conducteurSaved.vehicule = vehicule;

     conducteurSaved = await Conducteur.save(conducteurSaved).catch((error)=>{
      console.log(conducteurSaved);
        throw new BadRequestException("Nous ne parvenons pas à mettre à jour le véhicule");
      });
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
 
  update(id: number, updateConducteurDto: Conducteur): Promise<Conducteur> {
      return this.conducteurRepository.update(id, updateConducteurDto). then((conducteur: UpdateResult) => conducteur.raw).catch((error)=>{
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
