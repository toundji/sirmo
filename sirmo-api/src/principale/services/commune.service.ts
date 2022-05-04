/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm/repository/Repository';
import { CreateCommuneDto } from '../createDto/create-commune.dto';
import { Commune } from '../entities/commune.entity';
import { UpdateCommuneDto } from '../updateDto/update-commune.dto';

@Injectable()
export class CommuneService {
  constructor(
    @InjectRepository(Commune) private communeRepository: Repository<Commune>,
  ) {}

  create(createCommuneDto: CreateCommuneDto) {
    return this.communeRepository.save(createCommuneDto);
  }

  findAll() {
    return this.communeRepository.find({
      relations: ['departement', 'arrondissements'], loadEagerRelations:false
    });
  }

  findOne(id: number) {
    return this.communeRepository.findOne(id, {
      relations: ['departement', 'arrondissements'],
      loadEagerRelations:false
    });
  }

  update(id: number, updateCommuneDto: UpdateCommuneDto) {
    return this.communeRepository.update(id, updateCommuneDto);
  }

  patch(id: number, updateCommuneDto: UpdateCommuneDto) {
    return this.communeRepository.update(id, updateCommuneDto);
  }

  remove(id: number) {
    return this.communeRepository.delete(id);
  }
}
