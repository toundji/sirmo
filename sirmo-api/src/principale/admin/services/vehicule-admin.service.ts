import { BadRequestException, forwardRef, Inject, Injectable, InternalServerErrorException, UploadedFile } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Vehicule } from '../../entities/vehicule.entity';
import { User } from '../../entities/user.entity';
import { Conducteur } from '../../entities/conducteur.entity';
import { UserService } from '../../services/user.service';
import { ProprietaireVehicule } from '../../entities/proprietaire-vehicule.entity';
import { ConducteurVehicule } from '../../entities/conducteur-vehicule.entity';
import { NotFoundException } from '@nestjs/common';
import { FichierService } from '../../services/fichier.service';
import { Fichier } from '../../entities/fichier.entity';
import { ConducteurService } from '../../services/conducteur.service';
import { ProprietaireVehiculesService } from '../../services/proprietaire-vehicule.service';
import { ConducteurVehiculeService } from '../../services/conducteur-vehicule.service';
import { CreateVehiculeDto } from '../../createDto/vehicule.dto';

@Injectable()
export class VehiculeAdminService {
  constructor(
    @InjectRepository(Vehicule) private vehiculeRepository: Repository<Vehicule>,
    private readonly userService:UserService,
    @Inject(forwardRef(() => ConducteurService))
    private readonly conducteurService:ConducteurService,
    @Inject(forwardRef(() => ProprietaireVehiculesService))
    private readonly proprietaireVehiculesService: ProprietaireVehiculesService,
    @Inject(forwardRef(() => ConducteurVehiculeService))
    private readonly conducteurVehiculeService:ConducteurVehiculeService,
    private readonly fichierService: FichierService,

  ) {}

  async create(createVehiculeDto: CreateVehiculeDto): Promise<Vehicule> {
    let vehicule: Vehicule = new Vehicule();
    Object.keys(createVehiculeDto).forEach((cle) => {
      vehicule[cle] = createVehiculeDto[cle];
    });
    const owner: User = await this.userService.findOne(createVehiculeDto.proprietaire.proprietaireId)
    vehicule.proprietaire = owner;

    const conducteur: Conducteur = await this.conducteurService.findOne(createVehiculeDto.conducteur.conducteur_id)
    vehicule.conducteur = conducteur;

      vehicule =await  this.vehiculeRepository.save(vehicule).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      });

     //update ConducteurVehicule if conducteur.vehicule is not null
    conducteur.vehicule = vehicule;
    
    this.conducteurService.update(conducteur.id,conducteur);
    let proprietaireVehicule:ProprietaireVehicule =  ProprietaireVehicule.fromMap({proprietaire: owner, vehicule:vehicule, date_debut:createVehiculeDto.proprietaire.date_debut, date_fin:createVehiculeDto.proprietaire.date_fin})
     proprietaireVehicule = await this.proprietaireVehiculesService.createValidProprietaireVehicule(proprietaireVehicule);
     proprietaireVehicule.vehicule = null;

    const conducteurVehicule: ConducteurVehicule = ConducteurVehicule.create({
        conducteur: conducteur,
        vehicule:vehicule, 
        date_debut:createVehiculeDto.conducteur.date_debut,
        date_fin:createVehiculeDto.conducteur.date_fin
      })
    
      await this.conducteurVehiculeService.createValidConducteurVehicule(conducteurVehicule);
    conducteurVehicule.vehicule = null;
    vehicule.conducteur.vehicule = null;
    return vehicule;

  }


  findByCi_er(ci_er: string) :Promise<Vehicule> {
    return this.vehiculeRepository.find({where:{ci_er: ci_er}}).then((list:Vehicule[])=>{
      if(list.length>0){ return list[0]; }
    }).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le payement spécifié n'existe pas");
    });
  }
  update(id: number, vehicule: Vehicule) {
    
      return this.vehiculeRepository.update(id, vehicule ).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le payement spécifié n'existe pas");
      });

    
  }

  remove(id: number) {
   
      return this.vehiculeRepository.delete(id).catch((error) =>{
        console.log(error);
        throw new NotFoundException("Le payement spécifié n'existe pas");
      
      });

    }
}
