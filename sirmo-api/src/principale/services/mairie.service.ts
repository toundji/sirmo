/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, UploadedFile } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateMairieDto } from '../createDto/create-mairie.dto';
import { Arrondissement } from '../entities/arrondissement.entity';
import { Localisation } from '../entities/localisation.entity';
import { Mairie } from '../entities/mairie.entity';
import { User } from '../entities/user.entity';
import { LocalisationService } from './localisation.service';
import { ArrondissementService } from './arrondissement.service';
import { NotFoundException } from '@nestjs/common';
import { Fichier } from '../entities/fichier.entity';
import { FichierService } from './fichier.service';
import { CreateLocalisationDto } from '../createDto/create-localisation.dto';

@Injectable()
export class MairieService {
  constructor(
    @InjectRepository(Mairie) private mairieRepository: Repository<Mairie>,
    private localisationService:LocalisationService,
    private arrondissementService:ArrondissementService,
    private readonly fichierService: FichierService,

  ) {
  }
  async create(createMairieDto: CreateMairieDto, user:User) {
    let mairie: Mairie = new Mairie();
    Object.keys(createMairieDto).forEach(cle=>{mairie[cle] = createMairieDto[cle]});

    mairie.createur_id = user?.id;

  
     const arrondissement: Arrondissement = await this.arrondissementService.findOne(createMairieDto.arrondissementId).catch((error)=>{
      throw new NotFoundException("Impossible de trouver l'arrondisement précicser ");

     })
    mairie.arrondissement = arrondissement;
    mairie.commune = arrondissement.commune;
 

    if(createMairieDto.localisation){
      const localisation: Localisation = await this.localisationService.create(mairie.localisation);
      mairie.localisation = localisation;
      mairie = await this.mairieRepository.save(createMairieDto);
      localisation.entity = Mairie.entityName;
      localisation.entityId = mairie.id;
      return mairie;
    }
    else{
        return await  this.mairieRepository.save(mairie).catch((error)=>{
          throw new NotFoundException("Problème lor de la création de la mairie. Donnée invalide")
        });
    }

  }

  createAll(createMairieDto: Mairie[]) {
    return this.mairieRepository.save(createMairieDto);
  }

  findAll() {
    return this.mairieRepository.find();
  }

  findOne(id: number) {
      return this.mairieRepository.findOneOrFail(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Mairie non trouvé")
      });
  
  }

  findFirst(option:any) {
    
      return this.mairieRepository.findOne(option).catch((error)=>{
        throw new NotFoundException("Mairie non trouvé")
      });
  
  }

  update(id: number, mairie: Mairie) {
    this.findOne(id);
    mairie.id = id;
  
      return this.mairieRepository.save( mairie).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      
      });
   
    
  }

  async updateProfile(id: number, @UploadedFile() profile, user:User) {
    const mairie: Mairie = await this.findOne(id);
    const name = profile.originalname.split(".")[0];
    const file: Fichier = Fichier.fromMap({
      nom: name,
      path: profile.destination + profile.filename,
      mimetype: profile.mimetype,
      size: profile.size,
      entity: Mairie.entityName,
    });
    file.entityId = id;
    const image: Fichier = await this.fichierService.create(file);

    mairie.image_path = image.path;
    mairie.images ??= [];
    mairie.images.push(image)
    return this.mairieRepository.save(mairie);
  }

  async updateLocalisation(id: number, location: CreateLocalisationDto) {
    const mairie: Mairie = await this.findOne(id);
    location.entity = Mairie.entityName;
    location.entityId = id;
    const localisation: Localisation = await this.localisationService.create(location);
      mairie.localisation = localisation;
      return await this.mairieRepository.save(mairie);
  }

  remove(id: number) {
   
      return this.mairieRepository.softRemove({id:id}).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le mairie spécifiée n'existe pas");
      
      });

  
  }
}
