/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateAmandeDto } from '../createDto/create-amande.dto';
import { Amande } from '../entities/amande.entity';
import { Police } from '../entities/police.entity';
import { TypeAmande } from '../entities/type-amande.entity';
import { Zem } from '../entities/zem.entity';
import { PoliceService } from './police.service';
import { ZemService } from './zem.service';
import { User } from '../entities/user.entity';
import { TypeAmandeService } from './type-amande.service';
import { PayementService } from './payement.service';
import { Payement } from './../entities/payement.entity';



@Injectable()
export class AmandeService {
  constructor(
    @InjectRepository(Amande) private amandeRepository: Repository<Amande>,
    private readonly policeService: PoliceService,
    private readonly zemService: ZemService,
    private readonly typeAmandeService: TypeAmandeService,
    private readonly payementService: PayementService,
  ) {}

  async create(createAmandeDto: CreateAmandeDto, user: User) {
    const amande : Amande = new Amande();

    Object.keys(createAmandeDto).forEach((cle) => {
      amande[cle] = createAmandeDto[cle];
    });


    const police:Police = await this.policeService.findOne(user.id);
    amande.police = police;

    const zem: Zem = await this.zemService.findOne(createAmandeDto.zem_id);
    amande.zem= zem;

   const typeAmandes: TypeAmande[] =  await this.typeAmandeService.findBysIds(createAmandeDto.typeAmndeIds);
   let montant =0
    typeAmandes.forEach(ele=>{
        montant += ele.montant;
    });
    amande.montant = montant;
    amande.restant = montant;

    
      return this.amandeRepository.save(amande).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
  
      });

  }
  async payAmande(id:number, montant:number, user:User){
    const amande:Amande = await this.findOne(id);
    const paiement: Payement = await this.payementService.payAmande(montant, amande.zem, user);
    amande.payements ??= [];
    amande.payements.push(paiement);

    amande.restant -= montant;

   return await this.amandeRepository.save(amande);
  }

  findAll() {
    return this.amandeRepository.find({relations:["commune"]});
  }

  findOne(id: number):Promise<Amande> {
   
      return this.amandeRepository.findOne(id, {relations:["commune"]}).catch((error)=>{
        console.log(error);
        throw new NotFoundException("L'amande spécifiée n'existe pas");
      });

 
  }

  async update(id: number, amande: Amande) {
   
      return this.amandeRepository.update(id,amande).catch((error)=>{
        console.log(error);
      throw new NotFoundException("L'amande spécifiée n'existe pas");
      });

   
  }

  patch(id: number, amande: Amande) {
  
      return this.amandeRepository.update(id, amande).catch((error)=>{
        console.log(error);
      throw new NotFoundException("L'amande spécifiée n'existe pas");

      });

  
  }

  remove(id: number) {
    
    return this.amandeRepository.delete(id).catch((error)=>{
      console.log(error);
      throw new NotFoundException("L'amande spécifiée n'existe pas ou dépend dautre données");

    });
      
    
  }
}
