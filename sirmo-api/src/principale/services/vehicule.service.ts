/* eslint-disable prettier/prettier */
import { BadRequestException, forwardRef, Inject, Injectable, InternalServerErrorException, UploadedFile } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Vehicule } from '../entities/vehicule.entity';
import { User } from '../entities/user.entity';
import { Conducteur } from '../entities/conducteur.entity';
import { UserService } from './user.service';
import { ProprietaireVehicule } from '../entities/proprietaire-vehicule.entity';
import { ConducteurVehicule } from '../entities/conducteur-vehicule.entity';
import { NotFoundException } from '@nestjs/common';
import { FichierService } from './fichier.service';
import { Fichier } from '../entities/fichier.entity';
import { ConducteurService } from './conducteur.service';
import { ProprietaireVehiculesService } from './proprietaire-vehicule.service';
import { ConducteurVehiculeService } from './conducteur-vehicule.service';
import { CreateVehiculeDto } from '../createDto/vehicule.dto';
import { CreateVehiculeByConducteurDto } from '../createDto/vehicule-by-conducteur.dto';
import { VehiculeSubDto } from '../createDto/vehicule-sub.dto';
import { LicenceVehicule } from '../entities/licence-vehicule.entity';
import {  TypePayementLicence } from 'src/enums/type-payement';
import { Mairie } from './../entities/mairie.entity';

@Injectable()
export class VehiculeService {
  constructor(
    @InjectRepository(Vehicule) private vehiculeRepository: Repository<Vehicule>,
    private readonly userService:UserService,
    @Inject(forwardRef(() => ConducteurService))
    private readonly conducteurService:ConducteurService,
    @Inject(forwardRef(() => ProprietaireVehiculesService))
    private readonly proprietaireVehiculesService: ProprietaireVehiculesService,
    @Inject(forwardRef(() => ConducteurVehiculeService))
    private readonly conducteurVehiculeService:ConducteurVehiculeService,
    private readonly fichierService: FichierService,

  ) {}

  async create(createVehiculeDto: CreateVehiculeDto): Promise<Vehicule> {
    let vehicule: Vehicule = new Vehicule();
    Object.keys(createVehiculeDto).forEach((cle) => {
      vehicule[cle] = createVehiculeDto[cle];
    });
    const owner: User = await this.userService.findOne(createVehiculeDto.proprietaire.proprietaireId)
    vehicule.proprietaire = owner;

    const conducteur: Conducteur = await this.conducteurService.findOne(createVehiculeDto.conducteur.conducteur_id)
    vehicule.conducteur = conducteur;

      vehicule =await  this.vehiculeRepository.save(vehicule).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      
      });

    
     

     //update ConducteurVehicule if conducteur.vehicule is not null
    conducteur.vehicule = vehicule;
    
    this.conducteurService.update(conducteur.id,conducteur);
    let proprietaireVehicule:ProprietaireVehicule =  ProprietaireVehicule.fromMap({proprietaire: owner, vehicule:vehicule, date_debut:createVehiculeDto.proprietaire.date_debut, date_fin:createVehiculeDto.proprietaire.date_fin})
     proprietaireVehicule = await this.proprietaireVehiculesService.createValidProprietaireVehicule(proprietaireVehicule);
     proprietaireVehicule.vehicule = null;

    const conducteurVehicule: ConducteurVehicule = ConducteurVehicule.create({
        conducteur: conducteur,
        vehicule:vehicule, 
        date_debut:createVehiculeDto.conducteur.date_debut,
        date_fin:createVehiculeDto.conducteur.date_fin
      })
    
      await this.conducteurVehiculeService.createValidConducteurVehicule(conducteurVehicule);
    conducteurVehicule.vehicule = null;
    vehicule.conducteur.vehicule = null;
    return vehicule;
    

    

  }


  async createByConducteur(motDto: CreateVehiculeByConducteurDto): Promise<Vehicule> {
    let vehicule: Vehicule = new Vehicule();
    Object.keys(motDto).forEach((cle) => {
      vehicule[cle] = motDto[cle];
    });
   

    const conducteur: Conducteur = await this.conducteurService.findOne(+motDto.conducteur_id)
    vehicule.conducteur = conducteur;
      vehicule =await  this.vehiculeRepository.save(vehicule).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Mise à jour de la vehicule. Données invalides");
      });

     //update ConducteurVehicule if conducteur.vehicule is not null
    conducteur.vehicule = vehicule;
    this.conducteurService.update(conducteur.id,conducteur);

    let owner: User;
    if(motDto.proprietaire_id)
    {
      owner = await this.userService.findOne(motDto.proprietaire_id)
      vehicule.proprietaire = owner;
    }else{
      owner = conducteur.user;
      vehicule.proprietaire = owner;
    } 

    let proprietaireVehicule:ProprietaireVehicule =  ProprietaireVehicule.create({
      proprietaire: {id:owner.id},
      vehicule:{id:vehicule.id},
      date_debut: new Date(),
    });
     proprietaireVehicule = await ProprietaireVehicule.save(proprietaireVehicule).catch((error)=>{
      console.log(error);
      throw new InternalServerErrorException("Erreur pendant la sauvegarde du propriétaire de la vehicule");
     });let conducteurVehicule: ConducteurVehicule = ConducteurVehicule.create({
      conducteur: {id:conducteur.id},
      vehicule:{id:vehicule.id},
      date_debut: new Date(),
    });
    conducteurVehicule =   await ConducteurVehicule.save(conducteurVehicule).catch((error)=>{
        throw new InternalServerErrorException("Erreur pendant la sauvegarde de l'association (conducteur et vehicule)");

      })

    proprietaireVehicule.vehicule = null;
    conducteurVehicule.vehicule = null;

    vehicule.proprietaireVehicules = [proprietaireVehicule]
    vehicule.conducteurVehicules = [conducteurVehicule];

    vehicule.conducteur.vehicule = null;

    const now = new Date();



    const licenceTmp:LicenceVehicule = LicenceVehicule.create({
      montant: 20200,
      solde_mairie: conducteur.mairie.solde,
      date_fin: new Date(now.getFullYear()+1, now.getMonth(), now.getDate(), now.getHours(), now.getMinutes(), now.getSeconds(), now.getMilliseconds()),
      conducteur: conducteur,
      vehicule: vehicule,
      mairie: conducteur.mairie,
      type_payement: TypePayementLicence.MANUEL
    });

    const licence: LicenceVehicule =   await LicenceVehicule.save(licenceTmp).catch((error)=>{
      console.log(error);
      throw "Erreur de création de la licence";
    });
    licence.vehicule = null;
    licence.mairie = null;
    licence.conducteur =null;
    
    vehicule.licence = licence;
    vehicule = await Vehicule.save(vehicule);
   

    return vehicule;

  }



  async createWith(motDto: VehiculeSubDto, owner : User, conducteur: Conducteur, mairie:Mairie): Promise<Vehicule> {
    let vehicule: Vehicule = new Vehicule();
    Object.keys(motDto).forEach((cle) => {
      vehicule[cle] = motDto[cle];
    });
    vehicule.proprietaire = owner;

    vehicule.conducteur = conducteur;
      vehicule =await  this.vehiculeRepository.save(vehicule).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Mise à jour de la vehicule. Données invalides");
      });

     //update ConducteurVehicule if conducteur.vehicule is not null
    conducteur.vehicule = vehicule;
    this.conducteurService.update(conducteur.id,conducteur);

    let proprietaireVehicule:ProprietaireVehicule =  ProprietaireVehicule.create({
      proprietaire: {id:owner.id},
      vehicule:{id:vehicule.id},
      date_debut: new Date(),
    });
     proprietaireVehicule = await ProprietaireVehicule.save(proprietaireVehicule).catch((error)=>{
      console.log(error);
      throw new InternalServerErrorException("Erreur pendant la sauvegarde du propriétaire de la vehicule");
     });
     
     let conducteurVehicule: ConducteurVehicule = ConducteurVehicule.create({
      conducteur: {id:conducteur.id},
      vehicule:{id:vehicule.id},
      date_debut: new Date(),
    });
    conducteurVehicule =   await ConducteurVehicule.save(conducteurVehicule).catch((error)=>{
        throw new InternalServerErrorException("Erreur pendant la sauvegarde de l'association (conducteur et vehicule)");

      })

    proprietaireVehicule.vehicule = null;
    conducteurVehicule.vehicule = null;

    vehicule.proprietaireVehicules = [proprietaireVehicule]
    vehicule.conducteurVehicules = [conducteurVehicule];

    vehicule.conducteur.vehicule = null;
    const now = new Date();

    const licenceTmp:LicenceVehicule = LicenceVehicule.create({
      montant: 20200,
      solde_mairie: mairie.solde,
      date_fin: new Date(now.getFullYear()+1, now.getMonth(), now.getDate(), now.getHours(), now.getMinutes(), now.getSeconds(), now.getMilliseconds()),
      conducteur: conducteur,
      vehicule: vehicule,
      mairie: mairie,
      type_payement: TypePayementLicence.MANUEL
    });

    const licence: LicenceVehicule =   await LicenceVehicule.save(licenceTmp).catch((error)=>{
      console.log(error);
      throw "Erreur de création de la licence";
    });
    licence.vehicule = null;
    licence.mairie = null;
    licence.conducteur =null;
    
    vehicule.licence = licence;
    vehicule = await Vehicule.save(vehicule);
   
    return vehicule;

  }




  findAll(): Promise<Vehicule[]> {
    return this.vehiculeRepository.find();
  }

  findOne(id: number): Promise<Vehicule> {
    return this.vehiculeRepository.findOneOrFail(id).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le payement spécifié n'existe pas");
        });
      }

      findByCi_er(ci_er: string) :Promise<Vehicule> {
        return this.vehiculeRepository.find({where:{ci_er: ci_er}}).then((list:Vehicule[])=>{
          if(list.length>0){
            return list[0];
          }
        })
        .catch((error)=>{
          console.log(error);
          throw new NotFoundException("Le payement spécifié n'existe pas");
            });
          }

  edit(id: number, vehicule: Vehicule) {
    this.findOne(id);
    vehicule.id = id;
    return this.vehiculeRepository.save(vehicule);
  }

  async updateImage(id: number, @UploadedFile() profile, user:User){
    const vehicule: Vehicule = await this.findOne(id);
    const image: Fichier = await this.fichierService.createOneWith(
      profile,
      Vehicule.entityName,
      id,
      user
    );
    vehicule.image_path = image.path;
    vehicule.images ??= [];
    vehicule.images.push(image)
    
      return await this.vehiculeRepository.save(vehicule).catch((error)=>{
        console.log(error);
      throw new NotFoundException("Le payement spécifié n'existe pas");
      });
  }

  update(id: number, vehicule: Vehicule) {
    
      return this.vehiculeRepository.update(id, vehicule ).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le payement spécifié n'existe pas");
      });

    
  }

  remove(id: number) {
   
      return this.vehiculeRepository.delete(id).catch((error) =>{
        console.log(error);
        throw new NotFoundException("Le payement spécifié n'existe pas");
      
      });

    }
}
