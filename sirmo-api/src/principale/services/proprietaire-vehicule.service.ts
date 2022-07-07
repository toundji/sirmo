/* eslint-disable prettier/prettier */
import { BadRequestException, Inject, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Vehicule } from '../entities/vehicule.entity';
import { ProprietaireVehicule } from '../entities/proprietaire-vehicule.entity';
import { User } from '../entities/user.entity';
import { VehiculeService } from './vehicule.service';
import { UserService } from './user.service';
import { forwardRef } from '@nestjs/common';
import { UpdateProprietaireVehiculeDto } from '../updateDto/update-proprietaire-vehicule.dto';
import { CreateProprietaireVehiculeDto } from '../createDto/proprietaire-vehicule.dto';

@Injectable()
export class ProprietaireVehiculesService {
  constructor(
    @InjectRepository(ProprietaireVehicule)
    private proprietaireVehiculeRepository: Repository<ProprietaireVehicule>,
    @Inject(forwardRef(() => VehiculeService))
    private readonly vehiculeService: VehiculeService,
    private readonly userService: UserService,
  ) {}

  async create(
    createProprietaireVehiculeDto: CreateProprietaireVehiculeDto,
  ): Promise<ProprietaireVehicule> {
    const proprietaireVehicule: ProprietaireVehicule = new ProprietaireVehicule();
    Object.keys(createProprietaireVehiculeDto).forEach((cle) => {
      proprietaireVehicule[cle] = createProprietaireVehiculeDto[cle];
    });
    const user: User = await this.userService.findOne(createProprietaireVehiculeDto.proprietaireId)
    proprietaireVehicule.proprietaire = user;

    const vehicule: Vehicule = await this.vehiculeService.findOne(createProprietaireVehiculeDto.vehiculeId);
    
    if(vehicule.proprietaire){}
    proprietaireVehicule.vehicule = vehicule;

    vehicule.proprietaire = user;
    await this.vehiculeService.edit(vehicule.id, vehicule);

   
      return this.proprietaireVehiculeRepository.save(proprietaireVehicule).catch((error)=>{ console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      });
  

  }
  createValidProprietaireVehicule(
    vehicule: ProprietaireVehicule,
  ): Promise<ProprietaireVehicule> {
      return this.proprietaireVehiculeRepository.save(vehicule).catch((error)=>{
        console.log(error);
      throw new BadRequestException("Sauegarde de propiétaire de la vehicule. Données invalides");
    
      });
  }

  findOneByProprietaireAndVehicule(proprietaire_id: number, vehicule_id: number): Promise<ProprietaireVehicule> {
    const vehicule:Vehicule =new Vehicule(); vehicule.id = vehicule_id;
    const proprietaire:User = new User(); proprietaire.id = proprietaire_id;
      return this.proprietaireVehiculeRepository.findOne( {
        where:{
          vehicule: vehicule,
          proprietaire: proprietaire
        }
      }).catch((error)=>{
        console.log(error);
      throw new NotFoundException(
            "La réssource démander est introuvable est introuvable",
          );
      });
   
    
  }

  findAll(): Promise<ProprietaireVehicule[]> {
      return this.proprietaireVehiculeRepository.find({
        relations: ['vehicule', 'propprietaire'],
      }).catch((error)=>{console.log(error);
        throw new NotFoundException(
              "La réssource démander est introuvable est introuvable",
            );});
 
   
  }

  findOne(id: number): Promise<ProprietaireVehicule> {
      return this.proprietaireVehiculeRepository.findOne(id, {
        relations:['vehicule', 'propprietaire'],
      }).catch((error)=>{
        console.log(error);
        throw new NotFoundException(
              "La réssource démander est introuvable est introuvable",
            );
      });
  
    
  }

  update(id: number, updateProprietaireVehiculeDto: UpdateProprietaireVehiculeDto) {
      return this.proprietaireVehiculeRepository.update(
        id,
        updateProprietaireVehiculeDto,
      ).catch((error)=>{ console.log(error);
        throw new NotFoundException(
              "La réssource démander est introuvable est introuvable",
            );});
  
   
  }

  patch(id: number, updateProprietaireVehiculeDto: UpdateProprietaireVehiculeDto) {
      return this.proprietaireVehiculeRepository.update(
        id,
        updateProprietaireVehiculeDto,
      ).catch((error)=>{
        console.log(error);
      throw new NotFoundException(
            "La réssource démander est introuvable est introuvable",
          );
      });
  
  }

  remove(id: number) {
      return this.proprietaireVehiculeRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException(
              "La réssource démander est introuvable est introuvable",
            );
      });

  
  }
}
