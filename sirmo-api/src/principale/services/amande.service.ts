/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateAmandeDto } from '../createDto/create-amande.dto';
import { Amande } from '../entities/amande.entity';
import { Police } from '../entities/police.entity';
import { TypeAmande } from '../entities/type-amande.entity';
import { Conducteur } from '../entities/conducteur.entity';
import { PoliceService } from './police.service';
import { User } from '../entities/user.entity';
import { TypeAmandeService } from './type-amande.service';
import { PayementService } from './payement.service';
import { Payement } from './../entities/payement.entity';
import { ConducteurService } from './conducteur.service';
import { UpdateAmandeDto } from './../updateDto/update-amande.dto';



@Injectable()
export class AmandeService {
  constructor(
    @InjectRepository(Amande) private amandeRepository: Repository<Amande>,
    private readonly policeService: PoliceService,
    private readonly conducteurService: ConducteurService,
    private readonly typeAmandeService: TypeAmandeService,
    private readonly payementService: PayementService,
  ) {}

  async create(createAmandeDto: CreateAmandeDto, user: User):Promise<Amande>  {
    const amande : Amande = new Amande();

    Object.keys(createAmandeDto).forEach((cle) => {
      amande[cle] = createAmandeDto[cle];
    });


    const police:Police = await this.policeService.findOne(user.id);
    amande.police = police;

    const conducteur: Conducteur = await this.conducteurService.findOne(createAmandeDto.conducteur_id);
    amande.conducteur= conducteur;

   const typeAmandes: TypeAmande[] =  await this.typeAmandeService.findBysIds(createAmandeDto.typeAmndeIds);
   let montant =0
    typeAmandes.forEach(ele=>{
        montant += ele.montant;
    });
    amande.montant = montant;
    amande.restant = montant;

    
      return this.amandeRepository.save(amande).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les donn??es que nous avons r????ues ne sont celles que  nous esp??rons");
  
      });

  }

  async createByAdmin(createAmandeDto: CreateAmandeDto, user: User):Promise<Amande>  {
    const amande : Amande = new Amande();

    Object.keys(createAmandeDto).forEach((cle) => {
      amande[cle] = createAmandeDto[cle];
    });

    amande.createur_id = user.id;

    const conducteur: Conducteur = await this.conducteurService.findOne(createAmandeDto.conducteur_id);
    amande.conducteur= conducteur;

   const typeAmandes: TypeAmande[] =  await this.typeAmandeService.findBysIds(createAmandeDto.typeAmndeIds);
   let montant =0;
    typeAmandes.forEach(ele=>{
        montant += ele.montant;
    });
    amande.montant = montant;
    amande.restant = montant;
    amande.typeAmndes = typeAmandes;

      return this.amandeRepository.save(amande).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les donn??es que nous avons r????ues ne sont celles que  nous esp??rons");
  
      });

  }
  async payAmande(id:number, montant:number, user:User){
    const amande:Amande = await this.findOne(id);
    const paiement: Payement = await this.payementService.payAmande(montant, amande.conducteur, user);
    amande.payements ??= [];
    amande.payements.push(paiement);

    amande.restant -= montant;

   return await this.amandeRepository.save(amande);
  }

  async update(id:number, createAmandeDto: UpdateAmandeDto, user: User):Promise<Amande>  {
    const amande : Amande = await this.findOne(id);

    Object.keys(createAmandeDto).forEach((cle) => {
      amande[cle] = createAmandeDto[cle];
    });

    amande.editeur_id = user.id;

    if(createAmandeDto.conducteur_id){
      const conducteur: Conducteur = await this.conducteurService.findOne(createAmandeDto.conducteur_id);
      amande.conducteur= conducteur;
    }

    if(createAmandeDto.typeAmndeIds){
      const typeAmandes: TypeAmande[] =  await this.typeAmandeService.findBysIds(createAmandeDto.typeAmndeIds);
      let montant =0;
        typeAmandes.forEach(ele=>{
            montant += ele.montant;
        });
        amande.montant = montant;
        amande.restant = montant;
        amande.typeAmndes = typeAmandes;
    }
      return this.amandeRepository.save(amande).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les donn??es que nous avons r????ues ne sont celles que  nous esp??rons");
  
      });

  }

  findAll() {
    return this.amandeRepository.find({});
  }

  findAllForConducteur(conducteur_id:number) {
    return this.amandeRepository.find(
      {where:{conducteur:  Conducteur.create({id: conducteur_id})}, relations: ["typeAmndes", "payements", "police"], loadEagerRelations:false}).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Une erreur s'est produit. Vuilez contacter un administrateur");
        
      });
  }

  findOne(id: number):Promise<Amande> {
   
      return this.amandeRepository.findOne(id, {}).catch((error)=>{
        console.log(error);
        throw new NotFoundException("L'amande sp??cifi??e n'existe pas");
      });

 
  }

  patch(id: number, amande: Amande) {
  
      return this.amandeRepository.update(id, amande).catch((error)=>{
        console.log(error);
      throw new NotFoundException("L'amande sp??cifi??e n'existe pas");

      });

  
  }

  remove(id: number) {
    
    return this.amandeRepository.delete(id).catch((error)=>{
      console.log(error);
      throw new NotFoundException("L'amande sp??cifi??e n'existe pas ou d??pend dautre donn??es");

    });
      
    
  }
}
