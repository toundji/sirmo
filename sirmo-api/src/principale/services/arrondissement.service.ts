/* eslint-disable prettier/prettier */
import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
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
    return this.arrondissementRepository.save(createArrondissementDtos);
  }

  findAll() {
    return this.arrondissementRepository.find({loadEagerRelations:false});
  }

  findOne(id: number) {
try{    return this.arrondissementRepository.findOneOrFail(id, {relations:["commune"], loadEagerRelations:false});
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
      HttpStatus.UNAUTHORIZED,
    );
    }
 }

  patch(id: number, updateArrondissementDto: UpdateArrondissementDto) {
     return this.arrondissementRepository.update(id,updateArrondissementDto);
  }

  remove(id: number) {
    return this.arrondissementRepository.delete(id);
  }
}
