/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { assert } from 'console';
import { Repository } from 'typeorm/repository/Repository';
import { Compte } from '../entities/compte.entity';
import { NotFoundException } from '@nestjs/common';
import { BadRequestException } from '@nestjs/common';

@Injectable()
export class CompteService {
  constructor(
    @InjectRepository(Compte) private compteRepository: Repository<Compte>,
  ) {}

  create(compte: Compte) {
    return this.compteRepository.save(compte);
  }

  createAll(compte: Compte[]) {
    return this.compteRepository.save(compte);
  }

  findAll() {
    return this.compteRepository.find();
  }

  findOne(id: number) {
    try {
      return this.compteRepository.findOneOrFail(id);
    } catch (error) {
      throw new NotFoundException();
    }
    
  }

  findOneByCip(cip: string) {
    return this.compteRepository.findOneOrFail({where:{cip:cip}});
  }

  change(id: number, compte: Compte) {
    return this.compteRepository.update(id, compte);
  }

  update(id: number, compte: Compte) {
    return this.compteRepository.update(id, compte);
  }

  remove(id: number) {
    return this.compteRepository.delete(id);
  }

  async creditByCip(cip:string, amount:number){
      const compte: Compte = await  this.findOneByCip(cip);
      assert (amount > 0);
      compte.montant+=amount;
      return this.compteRepository.save(compte);
  }

  async debitByCip(cip:string, amount:number){
    const compte: Compte = await  this.findOneByCip(cip);
        assert (amount > 0 && amount < compte.montant );
        compte.montant-=amount;
        return this.compteRepository.save(compte);
    }

    async credit(id:number, amount:number){
        const compte: Compte = await  this.findOne(id);
        assert (amount > 0);
        compte.montant+=amount;
        return this.compteRepository.save(compte);
    }
  
    async debit(id:number, amount:number){
      const compte: Compte = await  this.findOne(id);
          assert (amount > 0 && amount < compte.montant );
          if( !(amount > 0 && amount < compte.montant )){
            throw new BadRequestException("Montant invalide ou solde insuffisant");
          }
          compte.montant-=amount;
         return this.compteRepository.save(compte);
      }
}
