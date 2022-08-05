/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { Constante } from '../entities/constante.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { CreateConstanteDto } from '../createDto/constante.dto';
import { Licence } from './../entities/licence.entity';
import { ConstanteDto } from './../createDto/constante-search.dto';
import { LicenceProperty } from 'src/enums/licence-property';

@Injectable()
export class ConstanteService {
  constructor(  @InjectRepository(Constante)  private constanteRepository: Repository<Constante>){}
  create(createConstanteDto: ConstanteDto) {
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

  searchFirst(search:ConstanteDto):Promise<Constante>{
    return this.constanteRepository.find({where:search}).then((list)=>{
      if(list && list.length >0){
        return list[0];
      }
      throw new NotFoundException("Aucun enrégistrement ne correspond à votre recherche")
    }).catch((error)=>{
      throw new BadRequestException("Une erreur s'est produit pendant la recherche")
    });
  }
  search(search:ConstanteDto):Promise<Constante[]>{
    return this.constanteRepository.find({where:search}).catch((error)=>{
      throw new BadRequestException("Une erreur s'est produit pendant la recherche")
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

  async init():Promise<Constante[]>{
    let constantes: Constante[] = await this.findAll();
    if(!constantes || constantes.length == 0){
      const list=[
        {
          nom: LicenceProperty.PRIX_LICENCE,
          valeur:"24000"
        },{
          nom:LicenceProperty.DUREE_LICENCE,
          valeur:"12"
        },
        {
          nom:LicenceProperty.DUREE_AMNADE,
          valeur:"30"
        }
      ];
      constantes = Constante.create(list);
      return await this.constanteRepository.save(constantes);
    }
    return constantes;
  }
}
