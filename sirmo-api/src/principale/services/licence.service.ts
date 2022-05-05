/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateLicenceDto } from '../createDto/create-licence.dto';
import { Licence } from '../entities/licence.entity';
import { Mairie } from '../entities/mairie.entity';
import { User } from '../entities/user.entity';
import { Zem } from '../entities/zem.entity';
import { UpdateLicenceDto } from '../updateDto/update-licence.dto';
import { ZemService } from './zem.service';
import { MairieService } from './mairie.service';
import { PayementService } from './payement.service';
import { Payement } from './../entities/payement.entity';
import { error } from 'console';

@Injectable()
export class LicenceService {
  constructor(
    @InjectRepository(Licence) private licenceRepository: Repository<Licence>,
    private readonly zemService: ZemService,
    private readonly mairieService: MairieService,
    private readonly payementService: PayementService,
  ) {}
  async create(createLicenceDto: CreateLicenceDto,  createur:User) {
   const licence:Licence = new Licence();

    Object.keys(createLicenceDto).forEach((cle) => {
      licence[cle] = createLicenceDto[cle];
    });

    const zem: Zem = await this.zemService.findOne(createLicenceDto.zem_id);
    licence.zem = zem;

    const mairie: Mairie = await this.mairieService.findOne(createLicenceDto.mairie_id);
    licence.mairie = mairie;

    mairie.solde += licence.montant;
    await this.mairieService.update(mairie.id, mairie);

    licence.createur_id = createur?.id;

    const payement: Payement = await this.payementService.payLicence(licence.montant, zem, createur);
    licence.payement = payement;

    return this.licenceRepository.save(licence);
  }

  createAll(createLicenceDto: CreateLicenceDto[],  createur: User) {
    const licences: Licence[] = [];

    createLicenceDto.forEach(async body=>{
      const licence:Licence = new Licence();

      Object.keys(createLicenceDto).forEach((cle) => {
        licence[cle] = body[cle];
      });

      const zem: Zem = await this.zemService.findOne(body.zem_id);
      licence.zem = zem;

      const mairie: Mairie = await this.mairieService.findOne(body.mairie_id);
      licence.mairie = mairie;

      mairie.solde += licence.montant;
      await this.mairieService.update(mairie.id, mairie);

      licence.createur_id = createur?.id;

      const payement: Payement = await this.payementService.payLicence(licence.montant, zem, createur);
      licence.payement = payement;
      
      licences.push(licence);

      return licence;

    });
    try {
      return this.licenceRepository.save(licences);

    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    }
  }

  findAll() {
    return this.licenceRepository.find();
  }

  findOne(id: number) {
    try {
      return this.licenceRepository.findOne(id);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le localisation spécifié n'existe pas");
    
    }
  }

  update(id: number, updateLicenceDto: UpdateLicenceDto) {
    try {
      return this.licenceRepository.update(id, updateLicenceDto);

     
    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le localisation spécifié n'existe pas");
    }
  }

  remove(id: number) {
    try {
      return this.licenceRepository.delete(id);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le localisation spécifié n'existe pas");
    }
  }
}
