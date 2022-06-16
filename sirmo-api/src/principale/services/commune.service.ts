/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
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
    
      return this.communeRepository.save(createCommuneDto).catch((error)=>{
        console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");

      });

  
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
      }).catch((error)=>{
        console.log(error);
      throw new NotFoundException("Le commune spécifiée n'existe pas");

      });;
    
   
  }

  update(id: number, updateCommuneDto: UpdateCommuneDto) {
   
      return this.communeRepository.update(id, updateCommuneDto).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le commune spécifiée n'existe pas");
  
      });;

    
  }

  patch(id: number, updateCommuneDto: UpdateCommuneDto) {
    
      return this.communeRepository.update(id, updateCommuneDto).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le commune spécifiée n'existe pas");
  
      });;

  
  }

  remove(id: number) {
  
      return this.communeRepository.delete(id).catch((error)=>{
        console.log(error);
      throw new NotFoundException("Le commune spécifiée n'existe pas ou comportes des arrondissements");

      });;

  }
}
