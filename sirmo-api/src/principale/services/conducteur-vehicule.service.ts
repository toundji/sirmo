/* eslint-disable prettier/prettier */
import { BadRequestException, forwardRef, Inject, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Vehicule } from '../entities/vehicule.entity';
import { User } from '../entities/user.entity';
import { ConducteurVehicule } from '../entities/conducteur-vehicule.entity';
import { Conducteur } from '../entities/conducteur.entity';
import { VehiculeService } from './vehicule.service';
import { NotFoundException } from '@nestjs/common';
import { ConducteurService } from './conducteur.service';
import { CreateConducteurVehiculeDto } from '../createDto/create-conducteur-vehicule.dto';

@Injectable()
export class ConducteurVehiculeService {
  constructor(
    @InjectRepository(ConducteurVehicule)
    private conducteurVehiculeRepository: Repository<ConducteurVehicule>,
    @Inject(forwardRef(() => ConducteurService))
    private readonly conducteurService: ConducteurService,
    @Inject(forwardRef(() => VehiculeService))
    private readonly vehiculeService: VehiculeService,

  ) {}

  async create(
    createConducteurVehiculeDto: CreateConducteurVehiculeDto,
  ): Promise<ConducteurVehicule> {
    const conducteurVehicule: ConducteurVehicule = new ConducteurVehicule();
    Object.keys(createConducteurVehiculeDto).forEach((cle) => {
      conducteurVehicule[cle] = createConducteurVehiculeDto[cle];
    });
    let conducteur: Conducteur ;
    try {
      conducteur = await this.conducteurService.findOne(createConducteurVehiculeDto.conducteur_id)
      conducteurVehicule.conducteur = conducteur;
      if(conducteur.vehicule){}
    } catch (error) {
      throw new NotFoundException("Le conducteur spécifier n'existe pas");
    }
 

    let vehicule: Vehicule;
    try {
      vehicule = await this.vehiculeService.findOne(createConducteurVehiculeDto.vehicule_id);
      if(vehicule.conducteur){}
      conducteurVehicule.vehicule = vehicule;
    } catch (error) {
      throw new NotFoundException("La vehicule spécifiée n'existe pas");
    }
    

    vehicule.conducteur = conducteur;
    await this.vehiculeService.edit(vehicule.id, vehicule);

    conducteur.vehicule = vehicule;
    await this.conducteurService.changed(conducteur.id, conducteur);

    return this.conducteurVehiculeRepository.save(conducteurVehicule);
  }

  createValidConducteurVehicule(
    conducteurVehicule: ConducteurVehicule,
  ): Promise<ConducteurVehicule> {
    
      return this.conducteurVehiculeRepository.save(conducteurVehicule).catch((error)=>{
        console.log(error);

        throw new BadRequestException("Erreur de lors de la liason du conducteur au vehicule." + error.message)
     
      });

  
  }

  findAll(): Promise<ConducteurVehicule[]> {
    return this.conducteurVehiculeRepository.find({
      relations: ['vehicule', 'propprietaire'],
    });
  }

  findOne(id: number): Promise<ConducteurVehicule> {
   
      return this.conducteurVehiculeRepository.findOne(id, {
        relations:['vehicule', 'propprietaire'],
      }).catch((error)=>{
        console.log(error);
  
        throw new NotFoundException(
              "La réssource démander est introuvable est introuvable",
            );
      });
    
  }

  findOneByConducteurAndVehicule(conducteur_id: number, vehicule_id: number): Promise<ConducteurVehicule> {
 
      const vehicule:Vehicule =new Vehicule(); vehicule.id = vehicule_id;
      const conducteur:Conducteur = new Conducteur(); conducteur.id = conducteur_id;
      return this.conducteurVehiculeRepository.findOne( {
        where:{
          vehicule:vehicule,
          conducteur:conducteur
        }
      }).catch((error)=>{
        console.log(error);
  
        throw new NotFoundException(
              "La réssource démander est introuvable est introuvable"
            );
      });
   
  }

  update(id: number, updateConducteurVehiculeDto: ConducteurVehicule) {
    
      return this.conducteurVehiculeRepository.update(
        id,
        updateConducteurVehiculeDto,
      ).catch((error)=>{
        console.log(error);
  
        throw new NotFoundException(
              "La réssource démander est introuvable est introuvable",
            );
      });
    
    
  }

  patch(id: number, updateConducteurVehiculeDto: ConducteurVehicule) {
   
      return this.conducteurVehiculeRepository.update(
        id,
        updateConducteurVehiculeDto,
      ).catch((error)=>{
        console.log(error);
        throw new NotFoundException(
              "La réssource démander est introuvable est introuvable",
            );
      });
   
  }

  remove(id: number) {
    
      return this.conducteurVehiculeRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("La réssource démander est introuvable est introuvable");
      });
  }
}
