/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { assert } from 'console';
import { Repository } from 'typeorm/repository/Repository';
import { Compte } from '../entities/compte.entity';
import { NotFoundException } from '@nestjs/common';
import { BadRequestException } from '@nestjs/common';
import { CreditCompteDto } from './../createDto/credit-compte.dto';
import { User } from '../entities/user.entity';
import { Payement } from './../entities/payement.entity';
import { TypePayement } from 'src/enums/type-payement';
import { json } from 'stream/consumers';
import { TypeOperation } from 'src/enums/type-operation';

@Injectable()
export class CompteService {
  constructor(
    @InjectRepository(Compte) private compteRepository: Repository<Compte>,
  ) {}

  create(compte: Compte) {
      return this.compteRepository.save(compte).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Erreur de création de compte. Données invalides ");
  
      });

  }


  async recharger(recharge: CreditCompteDto, user: User ): Promise<Payement> {
    const compte: Compte = await  this.findOne(user.id).catch((error)=>{
      console.log(error);
      throw new BadRequestException("Erreur pendant la recupération du compte. Veillez contacter un administrateur si cela persiste");
      });
    compte.montant+=recharge.montant;
    compte.total_in+=recharge.montant;

      const payement: Payement = Payement.create({
        montant: recharge.montant,
        solde: compte.montant,
        type: TypePayement.CREDIT,
        info: JSON.stringify({
          translationId: recharge.transactionId,
          type: "phone"
        }),
        operation: TypeOperation.RECHARGEMENT_PAR_FEDAPAY,
        compte: compte
      });
      await this.compteRepository.save(compte);
    
    return await Payement.save(payement);
}

  createAll(compte: Compte[]) {
      return this.compteRepository.save(compte).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Erreur de création de comptes. Données invalides ");
  
      });

  }

  findAll() {
      return this.compteRepository.find();

  }

  findOne(id: number) {
      return this.compteRepository.findOne(id).catch((error)=>{
        console.log(error);
      throw new NotFoundException("Le compte spécifié n'existe pas");
    
      });

    
  }

  findOneByCip(cip: string) {
      return this.compteRepository.findOneOrFail({where:{cip:cip}}).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le compte spécifié n'existe pas");
      
      });

  }

  change(id: number, compte: Compte) {
      return this.compteRepository.update(id, compte).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le compte spécifié n'existe pas");
      
      });
  }

  update(id: number, compte: Compte) {
      return this.compteRepository.update(id, compte).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le compte spécifié n'existe pas");
      
      });

  }

  remove(id: number) {
 
      return this.compteRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le compte spécifié n'existe pas");
      
      });

  }

    async credit(id:number, amount:number){
        const compte: Compte = await  this.findOne(id).catch((error)=>{
          console.log(error);
          throw new BadRequestException("Erreur pendant la mise à jour du compte. Veillez contacter un administrateur si cela persiste");
          });
        if( amount < 0){
          throw new BadRequestException("Montant invalide")
        }
        compte.montant+=amount;
        return this.compteRepository.save(compte);
    }
  
    async debit(id:number, amount:number){
      const compte: Compte = await  this.findOne(id);
         
          if( !(amount > 0 && amount < compte.montant )){
            throw new BadRequestException("Montant invalide ou solde insuffisant");
          }
          compte.montant-=amount;
         return this.compteRepository.save(compte).catch((error)=>{
          console.log(error);
          throw new BadRequestException("Erreur pendant la mise à jour du compte. Veillez contacter un administrateur si cela persiste");
        });
      }
}
