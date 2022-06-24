/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
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
import { error } from 'console';

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

   
      const user: User = await this.userService.findOne(createPayementDto.payerParId);
      const compte: Compte = await this.compteService.credit(createPayementDto.compteId, createPayementDto.montant);
      payement.compte = compte;
      payement.solde = compte.montant;
    try{
      return this.payementRepository.save(payement);
    }catch(e){
      console.log(e);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    
    }
  }

  payementOf(user:User):Promise<Payement[]>{
    const compte:Compte = Compte.create({user:user, id:user.id})
     return  this.payementRepository.find({where:{compte:compte}}).catch((error)=>{
       console.log(error);
       throw new BadRequestException("Une erreur s'est produit. Veillez contacter l'administrateur si cella persiste");
     })
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
    try {
      return this.payementRepository.save(payement);

    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    }
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
    try {
      return this.payementRepository.save(payement);
    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    
    }
  }

  findAll(): Promise<Payement[]> {
    return this.payementRepository.find();
  }

  findOne(id: number): Promise<Payement> {
  
      return this.payementRepository.findOne(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le payement spécifié n'existe pas");
      
      })

  }

  update(id: number, updatePayementDto: Payement) {
   
      return this.payementRepository.update(id, updatePayementDto).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le payement spécifié n'existe pas");
      
      });

  }

  patch(id: number, updatePayementDto: Payement) {
 
      return this.payementRepository.update(id, updatePayementDto).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le payement spécifié n'existe pas");
      
      })    

  }

  remove(id: number) {

      return this.payementRepository.delete(id).catch((error)=> {
        console.log(error);
        throw new NotFoundException("Le payement spécifié n'existe pas");
      });

 
  }
}
