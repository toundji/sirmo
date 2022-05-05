/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
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
    return this.licenceRepository.save(licences);
  }

  findAll() {
    return this.licenceRepository.find();
  }

  findOne(id: number) {
    return this.licenceRepository.findOne(id);
  }

  update(id: number, updateLicenceDto: UpdateLicenceDto) {
    return this.licenceRepository.update(id, updateLicenceDto);
  }

  remove(id: number) {
    return this.licenceRepository.delete(id);
  }
}
