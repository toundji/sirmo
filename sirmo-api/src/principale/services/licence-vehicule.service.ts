/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Mairie } from '../entities/mairie.entity';
import { User } from '../entities/user.entity';
import { Conducteur } from '../entities/conducteur.entity';
import { ConducteurService } from './conducteur.service';
import { MairieService } from './mairie.service';
import { PayementService } from './payement.service';
import { Payement } from '../entities/payement.entity';
import { InternalServerErrorException } from '@nestjs/common';
import { LicenceVehicule } from '../entities/licence-vehicule.entity';
import { CreateLicenceDto } from './../createDto/create-licence.dto';
import { UpdateLicenceDto } from '../updateDto/update-licence.dto';
import { VehiculeService } from './vehicule.service';
import { Vehicule } from './../entities/vehicule.entity';

@Injectable()
export class LicenceVehiculeService {
  constructor(
    @InjectRepository(LicenceVehicule) private licenceRepository: Repository<LicenceVehicule>,
    private readonly conducteurService: ConducteurService,
    private readonly mairieService: MairieService,
    private readonly payementService: PayementService,
    private readonly vehiculeService: VehiculeService,

  ) {}
  async create(body: CreateLicenceDto,  createur:User) {
   const licence:LicenceVehicule = new LicenceVehicule();

    Object.keys(body).forEach((cle) => {
      licence[cle] = body[cle];
    });

    const vehicule: Vehicule = await this.vehiculeService.findOne(body.vehicule_id);

    const conducteur: Conducteur = await this.conducteurService.findOne(vehicule.conducteur.id);
    licence.conducteur = conducteur;
    licence.vehicule = vehicule;

    if(body.mairie_id){
      const mairie: Mairie = await this.mairieService.findOne(body.mairie_id);
      licence.mairie = mairie;
      mairie.solde += licence.montant;
      await this.mairieService.update(mairie.id, mairie);
    }else{
      licence.mairie = conducteur.mairie;
      licence.mairie.solde += licence.montant;
      await this.mairieService.update(licence.mairie.id, licence.mairie);
    }
    licence.createur_id = createur?.id;

    ///creer un payement

    return this.licenceRepository.save(licence).catch((error)=>{
      console.log(error);
      throw new InternalServerErrorException("Erreur pendant la sauvergarde de la licence. Veillez reprendre ou contacter un administrateur si cela persiste");
    });
  }

  async createByAdmin(body: CreateLicenceDto,  createur:User) {
    const licence:LicenceVehicule = new LicenceVehicule();

     Object.keys(body).forEach((cle) => {
       licence[cle] = body[cle];
     });

     const vehicule: Vehicule = await this.vehiculeService.findOne(body.vehicule_id);

    const conducteur: Conducteur = await this.conducteurService.findOne(vehicule.conducteur.id);
    licence.conducteur = conducteur;
    licence.vehicule = vehicule;

     if(body.mairie_id){
       const mairie: Mairie = await this.mairieService.findOne(body.mairie_id);
       licence.mairie = mairie;
       mairie.solde += licence.montant;
       await this.mairieService.update(mairie.id, mairie);
     }else{
       licence.mairie = conducteur.mairie;
       licence.mairie.solde += licence.montant;
       await this.mairieService.update(licence.mairie.id, licence.mairie);
     }

     licence.createur_id = createur?.id;

     return this.licenceRepository.save(licence).catch((error)=>{
       console.log(error);
       throw new InternalServerErrorException("Erreur pendant la sauvergarde de la licence. Veillez reprendre ou contacter un administrateur si cela persiste");
     });
  }

  async createByFedapay(body: CreateLicenceDto,  createur:User) {

    if(!body.transaction_id){
      throw new BadRequestException("L'id de la transaction est obligatoire");
    }

    const licence:LicenceVehicule = new LicenceVehicule();

    const vehicule: Vehicule = await this.vehiculeService.findOne(body.vehicule_id);

    const conducteur: Conducteur = await this.conducteurService.findOne(vehicule.conducteur.id);
    licence.conducteur = conducteur;
    licence.vehicule = vehicule;

    licence.transaction_id = body.transaction_id;

     if(body.mairie_id){
       const mairie: Mairie = await this.mairieService.findOne(body.mairie_id);
       licence.mairie = mairie;
       licence.mairie.solde = licence.mairie.solde+ licence.montant;
     }else{
       licence.mairie = conducteur.mairie;
       licence.mairie.solde = licence.mairie.solde + licence.montant;
     }
     await Mairie.save( licence.mairie ).catch((error)=>{
       console.log(error);
       throw new InternalServerErrorException("Mise à jour de compte de la mairie. Une erreur s'est produit");
     });
     
     licence.createur_id = createur?.id;

     return this.licenceRepository.save(licence).catch((error)=>{
       console.log(error);
       throw new InternalServerErrorException("Erreur pendant la sauvergarde de la licence. Veillez reprendre ou contacter un administrateur si cela persiste");
     });
  }

  findAll() {
    return this.licenceRepository.find();
  }

  findOne(id: number) {

      return this.licenceRepository.findOne(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le licence spécifiée n'existe pas");
      });
  }

  update(id: number, updateLicenceVehiculeDto: UpdateLicenceDto) {
      return this.licenceRepository.update(id, updateLicenceVehiculeDto).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le licence spécifiée n'existe pas");
     
      });


  }

  remove(id: number) {
  
      return this.licenceRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le licence spécifiée n'existe pas");
      
      });
  }
}
