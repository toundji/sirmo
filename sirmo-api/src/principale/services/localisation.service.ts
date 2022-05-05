/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm/repository/Repository';
import { CreateLocalisationDto } from '../createDto/create-localisation.dto';
import { Localisation } from '../entities/localisation.entity';

@Injectable()
export class LocalisationService {
  constructor(
    @InjectRepository(Localisation) private localisationRepository: Repository<Localisation>,
  ) {}

  create(createLocalisationDto: CreateLocalisationDto) {
    try {
      return this.localisationRepository.save(createLocalisationDto);

    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    
    }
  }

  findAll() {
    return this.localisationRepository.find({
      relations: ['departement', 'arrondissements'],
    });
  }

  findOne(id: number) {
    try {
      return this.localisationRepository.findOne(id, {
        relations: ['departement', 'arrondissements'],
      });
    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le localisation spécifié n'existe pas");
    
    }
    
  }

  update(id: number, localisation: Localisation) {
    try {
      return this.localisationRepository.update(id, localisation);
    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le localisation spécifié n'existe pas");
    
    }
  }

  patch(id: number, localisation: Localisation) {
    try {
      return this.localisationRepository.update(id, localisation);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le localisation spécifié n'existe pas");
    
    }
  }

  remove(id: number) {
    try {
      return this.localisationRepository.delete(id);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le localisation spécifié n'existe pas");
    }
  }
}
