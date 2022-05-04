/* eslint-disable prettier/prettier */
import { Injectable, UploadedFile } from '@nestjs/common';
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

  ) {}
  async create(createMairieDto: CreateMairieDto, user:User) {
    let mairie: Mairie = new Mairie();
    Object.keys(createMairieDto).forEach(cle=>{mairie[cle] = createMairieDto[cle]});

    mairie.createur_id = user?.id;

   try{ const arrondissement: Arrondissement = await this.arrondissementService.findOne(createMairieDto.arrondissementId)
    mairie.arrondissement = arrondissement;
    mairie.commune = arrondissement.commune;
  }catch(e){
      return new NotFoundException("Impossible de trouver l'arrondisement précicser ");
    }

    if(createMairieDto.localisation){
      const localisation: Localisation = await this.localisationService.create(mairie.localisation);
      mairie.localisation = localisation;
      mairie = await this.mairieRepository.save(createMairieDto);
      localisation.entity = Mairie.entityName;
      localisation.entityId = mairie.id;
      return mairie;
    }
    else{
        return await  this.mairieRepository.save(mairie);
    }

  }

  createAll(createMairieDto: Mairie[]) {
    return this.mairieRepository.save(createMairieDto);
  }

  findAll() {
    return this.mairieRepository.find();
  }

  findOne(id: number) {
    try {
      return this.mairieRepository.findOne(id, {relations: ["image"]});
    } catch (error) {
      throw new NotFoundException("Mairie non trouvé")
    }
  }

  findOneWithImage(id: number) {
    return this.mairieRepository.findOne(id, {relations:["image"]});
  }

  findFirst(option:any) {
    try {
      return this.mairieRepository.findOne(option);
    } catch (error) {
      throw new NotFoundException("Mairie non trouvé")
    }
  }

  update(id: number, mairie: Mairie) {
    return this.mairieRepository.update(id, mairie);
  }

  async updateProfile(id: number, @UploadedFile() profile, user:User) {
    const mairie: Mairie = await this.findOne(id);
    const name = profile.originalname.split(".")[0];
    const file: Fichier = Fichier.fromMap({
      nom: name,
      path: profile.path,
      mimetype: profile.mimetype,
      size: profile.size,
      entity: Mairie.entityName,
    });
    file.entityId = id;
    const profil: Fichier = await this.fichierService.create(file);
    mairie.image = profil;
    const image: Fichier = await this.fichierService.createOneWith(
      profile,
      Mairie.entityName,
      id,
      user
    );
    mairie.image = image;
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
    return this.mairieRepository.delete(id);
  }
}
