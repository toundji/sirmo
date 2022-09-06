/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, InternalServerErrorException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { MoreThan, Repository } from 'typeorm';
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
import { Constante } from '../entities/constante.entity';
import { ConstanteService } from './constante.service';
import { LicenceProperty } from 'src/enums/licence-property';
import * as admin from 'firebase-admin';




@Injectable()
export class AmandeService {
  constructor(
    @InjectRepository(Amande) private amandeRepository: Repository<Amande>,
    private readonly policeService: PoliceService,
    private readonly conducteurService: ConducteurService,
    private readonly typeAmandeService: TypeAmandeService,
    private readonly payementService: PayementService,
    private readonly constanteService: ConstanteService,

  ) {}

  async create(createAmandeDto: CreateAmandeDto, user: User):Promise<Amande>  {
    const amande : Amande = new Amande();


    const police:Police = await this.policeService.findOne(user.id);
    amande.police = police;

    const conducteur: Conducteur = await this.conducteurService.findOne(createAmandeDto.conducteur_id);
    amande.conducteur= conducteur;

   const typeAmandes: TypeAmande[] =  await this.typeAmandeService.findBysIds(createAmandeDto.typeAmndeIds);
   if(typeAmandes.length == 0){
     throw new BadRequestException("Les types d'amande spécifiés n'existent pas");
   }
   let montant =0
    typeAmandes.forEach(ele=>{
        montant += ele.montant;
    });

    const amandeDuration:Constante = await this.constanteService.searchFirst({nom: LicenceProperty.DUREE_AMNADE}).catch((error)=>{
      throw new InternalServerErrorException("Une errerur liée à la durée de l'amande s'est produit");
    })

    const date: Date = new Date();
    amande.date_limite = new Date( date.getFullYear(), date.getMonth(), +amandeDuration.valeur+ date.getDate());

    amande.montant = montant;
    amande.restant = montant;

      return this.amandeRepository.save(amande).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
  
      });

  }

  
  async notifyUser(token:string, data:any){
    const messaging = admin.messaging();    
    const message = {
      notification: {
        title: 'Amande',
        body: 'Vous avez été amandé',
        data: data
      },
      token: token
    };
   
    return await messaging.send(message)
      .then((response) => {
        console.log('Successfully sent message:', response);
      }).catch((error) => {
        console.log('Error sending message:', error);
        throw new BadRequestException("Nous ne parvenons pas à notifyer à l'utilisteur",error.message);
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
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
  
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
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
  
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

  findAllUnsolveForConducteur(conducteur_id:number) {
    return this.amandeRepository.find(
      {where:{conducteur:  Conducteur.create(
        {id: conducteur_id}), restant: MoreThan(0)}, relations: ["typeAmndes", "payements", "police"], loadEagerRelations:false}).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Une erreur s'est produit. Vuilez contacter un administrateur");
      });
  }

  findOne(id: number):Promise<Amande> {
   
      return this.amandeRepository.findOne(id, {}).catch((error)=>{
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
