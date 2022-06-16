/* eslint-disable prettier/prettier */
import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateTypeAmandeDto } from '../createDto/create-type-amande.dto';
import { TypeAmande } from '../entities/type-amande.entity';
import { UpdateTypeAmandeDto } from '../updateDto/update-type-amande.dto';
import { BadRequestException } from '@nestjs/common';

@Injectable()
export class TypeAmandeService {
  constructor(
    @InjectRepository(TypeAmande) private typeAmandeRepository: Repository<TypeAmande>,
  ) {}

  create(createTypeAmandeDto: CreateTypeAmandeDto) {
   
      return this.typeAmandeRepository.save(createTypeAmandeDto).catch((error)=>{
        console.log(error);
  
        throw new BadRequestException(
              "Les données que nous avons réçues ne sont celles que  nous espérons",
            );
      });

   
     
    
  }

  createAll(createTypeAmandeDto: CreateTypeAmandeDto[]) {
   
      return this.typeAmandeRepository.save(createTypeAmandeDto).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      
      });

    
  }

  findAll() {
    return this.typeAmandeRepository.find();
  }

  findOne(id: number) {
   
      return this.typeAmandeRepository.findOne(id).catch((error)=>{console.log(error);
        throw new NotFoundException("Le type d'amande spécifié n'existe pas");
      });

  
  }

  findBysIds(ids: number[]) {
    return this.typeAmandeRepository.findByIds(ids);
  }
  findOneOrFail(option: any) {
   
      return this.typeAmandeRepository.findOneOrFail(option).catch((error)=>{  console.log(error);

        throw new NotFoundException("Le type d'amande spécifié n'existe pas");
     });

  
  }

  edit(id: number, typeAmande: TypeAmande) {
   
      return this.typeAmandeRepository.save(typeAmande).catch((error)=>{ console.log(error);

        throw new NotFoundException("Le type d'amande spécifié n'existe pas");
      });

   
  }

  update(id: number, updateTypeAmandeDto: UpdateTypeAmandeDto) {
  
      return this.typeAmandeRepository.update(id,updateTypeAmandeDto).catch((error)=>{
        console.log(error);

      throw new NotFoundException("Le type d'amande spécifié n'existe pas");
    
      });

   
  }

  remove(id: number) {
   
      return this.typeAmandeRepository.delete(id).catch((error)=>{
        console.log(error);

        throw new NotFoundException("Le type d'amande spécifié n'existe pas");
      
      });

  
  }

  async init(){
    const typeAmandes : TypeAmande[] = await this.findAll();
    if(typeAmandes && typeAmandes.length >0){
        return typeAmandes;
    }
    const amandes = [
      {
        "nom":"Licence",
        "montant": 5000,
        "description": "Cette amande à appliquer à un zem non inscrire ou n'ayant pas rénouveler sa licence"
      },{
        "nom":"Casque",
        "montant": 5000,
        "description": "Conduire san casque"
      },
      {
        "nom":"Couloire de Circularion",
        "montant": 5000,
        "description": "Non repect du couloir de circulaire"
      },
      {
        "nom":"Feu",
        "montant": 5000,
        "description": "Non respect du feu de circulation"
      },
      {
        "nom":"Rétroviseur",
        "montant": 5000,
        "description": "Conduire sans rétroviseur"
      },
      {
        "nom":"Plaque",
        "montant": 5000,
        "description": "Conduire sans plaque"
      },
    ];
    return this.typeAmandeRepository.save(amandes);
  }
}
