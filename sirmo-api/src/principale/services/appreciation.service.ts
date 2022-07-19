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



@Injectable()
export class AppreciationService {
  constructor(
    @InjectRepository(Appreciation) private appreciationRepository: Repository<Appreciation>,
    private readonly conducteurService: ConducteurService,
    private readonly fichierService: FichierService,

  ) {}

  async create(createAppreciationDto: CreateAppreciationDto, user? : User) {
    const appreciation : Appreciation = new Appreciation();
    
    Object.keys(createAppreciationDto).forEach((cle) => {
      appreciation[cle] = createAppreciationDto[cle];
    });

    const conducteur: Conducteur = await this.conducteurService.findOne(createAppreciationDto.conducteur_id);
    appreciation.conducteur= conducteur;

    appreciation.createur_id = user?.id;

  
      return this.appreciationRepository.save(appreciation).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");

      });;

    

  }

  createAll(createAppreciationDtos: CreateAppreciationDto[], user?:User) {
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
    return this.appreciationRepository.find({relations:["typeAppreciation"]});
  }

  findOne(id: number):Promise<Appreciation> {
  
      return this.appreciationRepository.findOne(id, {relations:["typeAppreciation"]}).catch((error)=>{
        console.log(error);
        throw new NotFoundException("L'appréciation spécifiée n'existe pas");
  
      });

  
  }

  async 
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
