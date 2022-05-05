/* eslint-disable prettier/prettier */
import { BadRequestException, HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateArrondissementDto } from '../createDto/create-arrondissement.dto';
import { UpdateArrondissementDto } from '../updateDto/update-arrondissement.dto';
import { Arrondissement } from '../entities/arrondissement.entity';
import { NotFoundException } from '@nestjs/common';

@Injectable()
export class ArrondissementService {
  constructor(
    @InjectRepository(Arrondissement) private arrondissementRepository: Repository<Arrondissement>,
  ) {}

  create(createArrondissementDto: CreateArrondissementDto) {
    return this.arrondissementRepository.save(createArrondissementDto);
  }

  createAll(createArrondissementDtos: CreateArrondissementDto[]) {
    try {
      return this.arrondissementRepository.save(createArrondissementDtos);

    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");

    }
  }

  findAll() {
    return this.arrondissementRepository.find({loadEagerRelations:false});
  }

  findOne(id: number) {
try{    return this.arrondissementRepository.findOne(id, {relations:["commune"], loadEagerRelations:false});
}catch(e)  {
   throw new HttpException(
    "Impossible de trouver l'arrondissement démandé",
    HttpStatus.UNAUTHORIZED,
  );
}
}

  update(id: number, updateArrondissementDto: UpdateArrondissementDto) {
    try{    return this.arrondissementRepository.update(id,updateArrondissementDto);
    } catch(e)  {
      throw new HttpException(
      "Impossible de trouver l'arrondissement concerné",
      HttpStatus.NOT_FOUND,
    );
    }
 }

  patch(id: number, updateArrondissementDto: UpdateArrondissementDto) {
    try {
      return this.arrondissementRepository.update(id,updateArrondissementDto);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("L'arrondissement spécifiée n'existe pas");

    }
  }

  remove(id: number) {
    try {
      return this.arrondissementRepository.delete(id);

    } catch (error) {
      console.log(error);

      throw new NotFoundException("L'arrondissement spécifié n'existe pas ou depend d'autres données");

    }
  }
}
