/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { ArrondissementService } from 'src/principale/services/arrondissement.service';
import { Arrondissement } from 'src/principale/entities/arrondissement.entity';
import { CommuneService } from 'src/principale/services/commune.service';
import { Commune } from 'src/principale/entities/commune.entity';
import arrondisByComByDep from 'src/config/arrondissement-data';
import { Repository } from 'typeorm';
import { CreateDepartementDto } from '../createDto/create-departement.dto';
import { Departement } from '../entities/departement.entity';
import { UpdateDepartementDto } from '../updateDto/update-departement.dto';

@Injectable()
export class DepartementService {

  constructor(
    @InjectRepository(Departement) private departementRepository: Repository<Departement>,
    private readonly communeService:CommuneService,
    private readonly arrondissementService:ArrondissementService

  ) {}

  create(createDepartementDto: CreateDepartementDto) {
   
      return this.departementRepository.save(createDepartementDto).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
  
      });

 
  }

  findAll() {
    return this.departementRepository.find({
      relations: ['communes', "communes.arrondissements"],
    });
  }

  findOne(id: number) {
   
      return this.departementRepository.findOne(id, {
        relations: ['communes', "communes.arrondissements"],
      }).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le département spécifié n'existe pas");
  
      });
  
    
  }

  update(id: number, updateDepartementDto: UpdateDepartementDto) {
    
      return this.departementRepository.update(id,updateDepartementDto).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le département spécifié n'existe pas");
  
      });

  }

  patch(id: number, updateDepartementDto: UpdateDepartementDto) {
   
      return this.departementRepository.update(id,updateDepartementDto).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le département spécifié n'existe pas");
  
      });
  }

  remove(id: number) {
   
      return this.departementRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le département spécifié n'existe pas");
  
      });;

  }

  async initDepComAr(){
   
    const depList:Departement[] = await this.findAll();
    if(depList && depList.length)return depList;
    const comList:Commune[] = [];
    let arrondisList:Arrondissement[] = [];

    await arrondisByComByDep.forEach(async (dep)=>{
      const departement:Departement = await this.departementRepository.save({"nom":dep.nom});
      depList.push(departement);

      await dep.communes.forEach(async (com)=>{
        const commune:Commune = await this.communeService.create({"nom":com.nom, "departement":departement})
        comList.push(commune);
        const arrondis = com.arrondissements.map((element)=>{return {"nom":element, commune:commune}});
        const arrondissements: Arrondissement[]= await this.arrondissementService.createAll(arrondis);
        arrondisList= arrondisList.concat(arrondissements);
      });
    });
      return {
        "departements": depList,
        "communes": comList,
        "arrondissements": arrondisList
       };
  }
}
