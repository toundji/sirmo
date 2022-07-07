/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Constante } from '../entities/constante.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { CreateConstanteDto } from '../createDto/constante.dto';

@Injectable()
export class ConstanteService {
  constructor(  @InjectRepository(Constante)  private constanteRepository: Repository<Constante>){}
  create(createConstanteDto: CreateConstanteDto) {
    return this.constanteRepository.save(createConstanteDto);
  }

  createAll(createConstanteDto: CreateConstanteDto[]) {
      return this.constanteRepository.save(createConstanteDto).catch((error)=>{  console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      });

  
  }

  findAll() {
    return this.constanteRepository.find();
  }

  findAllByIds(ids:number[]) {
    return this.constanteRepository.findByIds(ids);
  }

  findOne(id: number) {
    return this.constanteRepository.findOneOrFail(id).catch((e)=>{
      throw new NotFoundException("Le constante spécifié n'existe pas");
    });
  }

//   update(id: number, updateConstanteDto: UpdateConstanteDto) {
//     return this.constanteRepository.update(id, updateConstanteDto).catch((error)=>{
//       console.log(error);
//       throw new BadRequestException(
//         "Les données que nous avons réçues ne sont celles que  nous espérons",
//       );
//     });
//   }

  remove(id: number) {
    return this.constanteRepository.delete(id).catch((error)=>{
      throw new BadRequestException(
        "Les constante indiqué n'existe pas",
      );
    });
  }

  async init(){
    // const constantes: Constante[] = await this.findAll();
    // if(!constantes || constantes.length === 0){
    //   Object.values(ConstanteName).forEach(value=>{
    //     constantes.push({"nom" : value} as Constante);
    //   })
    //   return this.constanteRepository.save(constantes);
    // }
  }
}
