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
      return this.compteRepository.save(compte).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
  
      });

  }

  createAll(compte: Compte[]) {
      return this.compteRepository.save(compte).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
  
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

  async creditByCip(cip:string, amount:number){
      const compte: Compte = await  this.findOneByCip(cip);
      if( amount < 0){
        throw new BadRequestException("Montant invalide");
      }
      compte.montant+=amount;
      return this.compteRepository.save(compte).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Erreur pendant la mise à jour du compte. Veillez contacter un administrateur si cela persiste");
      });
  }

  async debitByCip(cip:string, amount:number){
    const compte: Compte = await  this.findOneByCip(cip);
    if( !(amount > 0 && amount < compte.montant )){
      throw new BadRequestException("Montant invalide ou solde insuffisant");
    }        compte.montant-=amount;
        return this.compteRepository.save(compte).catch((error)=>{
          console.log(error);
          throw new BadRequestException("Erreur pendant la mise à jour du compte. Veillez contacter un administrateur si cela persiste");
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
