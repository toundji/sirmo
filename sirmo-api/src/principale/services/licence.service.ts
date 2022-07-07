/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateLicenceDto } from '../createDto/create-licence.dto';
import { Licence } from '../entities/licence.entity';
import { Mairie } from '../entities/mairie.entity';
import { User } from '../entities/user.entity';
import { Conducteur } from '../entities/conducteur.entity';
import { UpdateLicenceDto } from '../updateDto/update-licence.dto';
import { ConducteurService } from './conducteur.service';
import { MairieService } from './mairie.service';
import { PayementService } from './payement.service';
import { Payement } from './../entities/payement.entity';
import { error } from 'console';
import { InternalServerErrorException } from '@nestjs/common';

@Injectable()
export class LicenceService {
  constructor(
    @InjectRepository(Licence) private licenceRepository: Repository<Licence>,
    private readonly conducteurService: ConducteurService,
    private readonly mairieService: MairieService,
    private readonly payementService: PayementService,
  ) {}
  async create(createLicenceDto: CreateLicenceDto,  createur:User) {
   const licence:Licence = new Licence();

    Object.keys(createLicenceDto).forEach((cle) => {
      licence[cle] = createLicenceDto[cle];
    });

    const conducteur: Conducteur = await this.conducteurService.findOne(createLicenceDto.conducteur_id);
    licence.conducteur = conducteur;

    const mairie: Mairie = await this.mairieService.findOne(createLicenceDto.mairie_id);
    licence.mairie = mairie;

    mairie.solde += licence.montant;
    await this.mairieService.update(mairie.id, mairie);

    licence.createur_id = createur?.id;

    const payement: Payement = await this.payementService.payLicence(licence.montant, conducteur, createur);
    licence.payement = payement;

    return this.licenceRepository.save(licence).catch((error)=>{
      console.log(error);
      throw new InternalServerErrorException("Erreur pendant la sauvergarde de la licence. Veillez reprendre ou contacter un administrateur si cela persiste");
    });
  }

  createAll(createLicenceDto: CreateLicenceDto[],  createur: User) {
    const licences: Licence[] = [];

    createLicenceDto.forEach(async body=>{
      const licence:Licence = new Licence();

      Object.keys(createLicenceDto).forEach((cle) => {
        licence[cle] = body[cle];
      });

      const conducteur: Conducteur = await this.conducteurService.findOne(body.conducteur_id);
      licence.conducteur = conducteur;

      const mairie: Mairie = await this.mairieService.findOne(body.mairie_id);
      licence.mairie = mairie;

      mairie.solde += licence.montant;
      await this.mairieService.update(mairie.id, mairie);

      licence.createur_id = createur?.id;

      const payement: Payement = await this.payementService.payLicence(licence.montant, conducteur, createur);
      licence.payement = payement;
      
      licences.push(licence);

      return licence;

    });
    
      return this.licenceRepository.save(licences).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
     
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

  update(id: number, updateLicenceDto: UpdateLicenceDto) {
      return this.licenceRepository.update(id, updateLicenceDto).catch((error)=>{
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
