/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateTypeAmandeDto } from '../createDto/create-type-amande.dto';
import { TypeAmande } from '../entities/type-amande.entity';
import { UpdateTypeAmandeDto } from '../updateDto/update-type-amande.dto';

@Injectable()
export class TypeAmandeService {
  constructor(
    @InjectRepository(TypeAmande) private typeAmandeRepository: Repository<TypeAmande>,
  ) {}

  create(createTypeAmandeDto: CreateTypeAmandeDto) {
    return this.typeAmandeRepository.save(createTypeAmandeDto);
  }

  createAll(createTypeAmandeDto: CreateTypeAmandeDto[]) {
    return this.typeAmandeRepository.save(createTypeAmandeDto);
  }

  findAll() {
    return this.typeAmandeRepository.find();
  }

  findOne(id: number) {
    return this.typeAmandeRepository.findOne(id);
  }

  findBysIds(ids: number[]) {
    return this.typeAmandeRepository.findByIds(ids);
  }
  findOneOrFail(option: any) {
    return this.typeAmandeRepository.findOneOrFail(option);
  }

  edit(id: number, typeAmande: TypeAmande) {
    
    return this.typeAmandeRepository.save(typeAmande);
  }

  update(id: number, updateTypeAmandeDto: UpdateTypeAmandeDto) {
     return this.typeAmandeRepository.update(id,updateTypeAmandeDto);
  }

  remove(id: number) {
    return this.typeAmandeRepository.delete(id);
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
