/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreatePayementDto } from '../createDto/create-payement.dto';
import { Compte } from '../entities/compte.entity';
import { Payement } from '../entities/payement.entity';
import { User } from '../entities/user.entity';
import { CompteService } from './compte.service';
import { Logger } from '@nestjs/common';
import { UserService } from './user.service';
import { TypeOperation } from 'src/enums/type-operation';
import { TypePayement } from 'src/enums/type-payement';
import { Zem } from './../entities/zem.entity';

@Injectable()
export class PayementService {
  constructor(
    @InjectRepository(Payement) private payementRepository: Repository<Payement>,
    private readonly compteService:CompteService,
    private readonly userService:UserService,


  ) {}

  async create(createPayementDto: CreatePayementDto): Promise<Payement> {
    const payement: Payement = new Payement();
    Object.keys(createPayementDto).forEach((cle) => {
      payement[cle] = createPayementDto[cle];
    });
    payement.solde = payement.montant;

    try{
      const user: User = await this.userService.findOne(createPayementDto.payerParId);
      const compte: Compte = await this.compteService.credit(createPayementDto.compteId, createPayementDto.montant);
      payement.compte = compte;
      payement.solde = compte.montant;
      return this.payementRepository.save(payement);
    }catch(e){
      Logger.error(e);
      throw e;
    }
  }

  async payLicence(montant:number,  zem: Zem, user?: User,){
    const payement: Payement = new Payement();
    payement.type = TypePayement.DEBIT;
    payement.operation = TypeOperation.PAYEMENT_LICENCE;
    payement.createur_id = user?.id;
    payement.montant = montant;
    const compte: Compte = await this.compteService.debit(zem.id, montant);
    payement.compte = compte;
    payement.solde = compte.montant;
    return this.payementRepository.save(payement);
  }

  async payAmande(montant:number,  zem: Zem, user?: User,){
    const payement: Payement = new Payement();
    payement.type = TypePayement.DEBIT;
    payement.operation = TypeOperation.PAYEMENT_AMANDE;
    payement.createur_id = user?.id;
    payement.montant = montant;
    const compte: Compte = await this.compteService.debit(zem.id, montant);
    payement.compte = compte;
    payement.solde = compte.montant;
    return this.payementRepository.save(payement);
  }

  findAll(): Promise<Payement[]> {
    return this.payementRepository.find();
  }

  findOne(id: number): Promise<Payement> {
    return this.payementRepository.findOne(id);
  }

  update(id: number, updatePayementDto: Payement) {
    return this.payementRepository.update(id, updatePayementDto);
  }

  patch(id: number, updatePayementDto: Payement) {
    return this.payementRepository.update(id, updatePayementDto);
  }

  remove(id: number) {
    return this.payementRepository.delete(id);
  }
}
