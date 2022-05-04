/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
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
    return this.localisationRepository.save(createLocalisationDto);
  }

  findAll() {
    return this.localisationRepository.find({
      relations: ['departement', 'arrondissements'],
    });
  }

  findOne(id: number) {
    return this.localisationRepository.findOne(id, {
      relations: ['departement', 'arrondissements'],
    });
  }

  update(id: number, localisation: Localisation) {
    return this.localisationRepository.update(id, localisation);
  }

  patch(id: number, localisation: Localisation) {
    return this.localisationRepository.update(id, localisation);
  }

  remove(id: number) {
    return this.localisationRepository.delete(id);
  }
}
