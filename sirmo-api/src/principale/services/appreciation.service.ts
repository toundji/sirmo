/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException, UploadedFile } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateAppreciationDto } from '../createDto/create-appreciation.dto';
import { Appreciation } from '../entities/appreciation.entity';
import { User } from '../entities/user.entity';
import { Conducteur } from '../entities/conducteur.entity';
import { ConducteurService } from './conducteur.service';
import { Fichier } from '../entities/fichier.entity';
import { FichierService } from './fichier.service';
import { ConducteurStat } from '../createDto/conducteur-statistque';
import { TypeAppreciation } from 'src/enums/type-appreciation';



@Injectable()
export class AppreciationService {
  constructor(
    @InjectRepository(Appreciation) private appreciationRepository: Repository<Appreciation>,
    private readonly conducteurService: ConducteurService,
    private readonly fichierService: FichierService,

  ) {}

  async create(createAppreciationDto: CreateAppreciationDto, user : User):Promise<Appreciation> {
    const appreciation : Appreciation = new Appreciation();
    
    Object.keys(createAppreciationDto).forEach((cle) => {
      appreciation[cle] = createAppreciationDto[cle];
    });

    const conducteur: Conducteur = await this.conducteurService.findOne(createAppreciationDto.conducteur_id);
    appreciation.conducteur= conducteur;

    appreciation.createur_id = user?.id;
    appreciation.phone = user.phone;

  
      return this.appreciationRepository.save(appreciation).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");

      });;

    

  }

  createAll(createAppreciationDtos: CreateAppreciationDto[], user?:User):Promise<Appreciation[]>  {
    const appreciations: Appreciation[] = [];

      createAppreciationDtos.forEach(body=>{
        const appreciation : Appreciation = new Appreciation();
        const conducteur: Conducteur = new Conducteur();
        conducteur.id = body.conducteur_id;
        appreciation.createur_id = user?.id;
        appreciation.phone =  user.phone;
        appreciation.message = body.message;
        appreciation.typeAppreciation = body.typeAppreciation;
        appreciations.push(appreciation);
        return appreciation;
      });

      
        return this.appreciationRepository.save(appreciations).catch((error)=>{
          console.log(error);
          throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
  
        });

     
  }

  findAll() {
    return this.appreciationRepository.find();
  }

  findAllForConducteur(conducteur_id:number):Promise<Appreciation[]> {
    return this.appreciationRepository.find(
      {where:{conducteur:  Conducteur.create({id: conducteur_id})}, loadEagerRelations:false}
    );
  }

  async statistic(conducteur_id:number):Promise<ConducteurStat> {
    const conducteur:Conducteur = await Conducteur.findOneOrFail(conducteur_id).catch((error)=>{
      console.log(error);
      throw new BadRequestException("Impossible de trouver le conducteur");
    });
    const appreciateStat = await  this.appreciationRepository.createQueryBuilder("appreciate")
    .select("appreciate.typeAppreciation", "typeAppreciation")
    .addSelect("Count(appreciate.id)", "somme")
    .where("appreciate.conducteur_id =:id", {id: conducteur_id})
    .groupBy("appreciate.typeAppreciation")
    .getRawMany().catch((error)=>{
        throw error;
    });
    const statistique: ConducteurStat = {
      excellence :0,
    tres_bon : 0,
    bon :0,
    mauvais: 0,
    conducteur:conducteur
    }
    appreciateStat.forEach((element)=>{
      if(element.typeAppreciation == TypeAppreciation.EXCELLENT){
        statistique.excellence = element.somme;
      }else  if(element.typeAppreciation == TypeAppreciation.BON){
        statistique.bon = element.somme;
      }else if(element.typeAppreciation == TypeAppreciation.TRES_BON){
        statistique.tres_bon = element.somme;
      }else if(element.typeAppreciation == TypeAppreciation.MAUVAIS){
        statistique.mauvais = element.somme;
      }
    });
    return statistique;
  }

  findOne(id: number):Promise<Appreciation> {
  
      return this.appreciationRepository.findOneOrFail(id, ).catch((error)=>{
        console.log(error);
        throw new NotFoundException("L'appréciation spécifiée n'existe pas");
  
      });

  
  }

   
  async updateImage(id: number, @UploadedFile() profile, user:User){
    const appreciation: Appreciation = await this.findOne(id);
    const image: Fichier = await this.fichierService.createOneWith(
      profile,
      Appreciation.entityName,
      id,
      user
    );
    appreciation.fichier =  image.path;
    
    return await this.appreciationRepository.save(appreciation).catch((error)=>{
        console.log(error);
      throw new NotFoundException("Le payement spécifié n'existe pas");
      });
  }

  async update(id: number, appreciation: Appreciation) {
   
      return this.appreciationRepository.update(id,appreciation).catch((error)=>{
        console.log(error);
        throw new NotFoundException("L'appréciation spécifiée n'existe pas");
  
      });

   
  }

  patch(id: number, appreciation: Appreciation) {
   
      return this.appreciationRepository.update(id,appreciation).catch((error)=>{
        console.log(error);
      throw new NotFoundException("L'appreciation spécifiée n'existe pas");

      });

  
  }

  remove(id: number) {
   
      return this.appreciationRepository.delete(id).catch((error)=>{ console.log(error);

        throw new NotFoundException("L'appréciation spécifiée n'existe pas ou depend d'autres données");
  });

   
  }
}
