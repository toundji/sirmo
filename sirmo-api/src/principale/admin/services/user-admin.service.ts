/* eslint-disable prettier/prettier */
import {
    BadRequestException,
    Injectable,
    Logger,
    NotFoundException,
  } from "@nestjs/common";
  import { InjectRepository } from "@nestjs/typeorm";
import { RoleName } from "src/enums/role-name";
import { ProprietaireDto } from "src/principale/admin/dto/proprietaireDto";
import { Arrondissement } from "src/principale/entities/arrondissement.entity";
import { Compte } from "src/principale/entities/compte.entity";
import { Fichier } from "src/principale/entities/fichier.entity";
import { User } from "src/principale/entities/user.entity";
import { ArrondissementService } from "src/principale/services/arrondissement.service";
import { ApiConstante } from "src/principale/utilis/api-constantes";
import { Repository } from "typeorm";
import * as fs from 'fs';


  @Injectable()
  export class UserAdminService {
    constructor(
      @InjectRepository(User) private userRepository: Repository<User>,
      private readonly arrondissementService: ArrondissementService,
    ) {}
  
 
    async createOwner(body: ProprietaireDto): Promise<User> {
      const user: User = new User();
      Object.keys(body).forEach((cle) => {
        user[cle] = body[cle];
      });
      user.roles = [RoleName.PROPRIETAIRE];
  
  
        const arrondisement: Arrondissement =
          await this.arrondissementService.findFirstByName(body.arrondissement);
        user.arrondissement = arrondisement;
  
        user.password = user.nom +"-"+ user.prenom ;

        const id:number=  Date.now();
       
        const u: User = await this.userRepository.save(user).catch((error)=>{
          console.log(error);
          throw new BadRequestException("Erreur pendant la réation de l'utilisation. Vérifier que vos donnée n'existe pas déjà");
        });
        const compte:Compte = Compte.create({user:u, montant:0});
        await Compte.save(compte);

        if(body.profile_image){
          let bitmap: Buffer =  Buffer.from(body.profile_image, 'base64');
          if(!fs.existsSync(ApiConstante.profile_path)){
            fs.promises.mkdir(ApiConstante.profile_path, { recursive: true }).catch(console.error);
          }
          const filename:string = '/conducteur_profile'+ id + Date.now() + '.png';
    
          fs.writeFileSync(ApiConstante.profile_path + filename,   bitmap);
    
          let profile:Fichier = Fichier.create({
            nom: "profile",
            path: ApiConstante.profile_path + filename,
            entity: User.entityName,
            entityId: u.id
          });
          profile = await Fichier.save(profile);
          u.profile_image = profile.path;
        }
        if(body.idCarde_image){
          let bitmap: Buffer =  Buffer.from(body.idCarde_image, 'base64');
          const filename:string = '/carte_identite'+ id + Date.now() + '.png';
    
          if(!fs.existsSync(ApiConstante.id_carde_path)){
            fs.promises.mkdir(ApiConstante.id_carde_path, { recursive: true }).catch(console.error);
          }
          fs.writeFileSync(ApiConstante.id_carde_path + filename, bitmap);
    
          let id_carde_Image:Fichier = Fichier.create({
            nom:"cate d'identié",
            path: ApiConstante.id_carde_path + filename,
            entity: User.entityName,
            entityId: u.id
          });
    
         id_carde_Image = await Fichier.save(id_carde_Image)
         u.idCarde_image =  id_carde_Image.path;
        }
    
        if(body.idCarde_image || body.profile_image){
          await u.save();
        }

        return u;
    }

    findAll(): Promise<User[]> {
      return this.userRepository.find({ relations: [ "arrondissement"] });
    }

    findOne(id: number): Promise<User> {
      
        return this.userRepository.findOneOrFail(id, {
          relations: [ "arrondissement"],
        }).catch((error)=>{
          console.log(error);
  
        throw new NotFoundException(
          "L'utilisateur avec l'id " + id + " est introuvable",
        );
        });
     
    }
  
    findOneByPseudo(pseudo: string): Promise<any> {
      Logger.debug(pseudo);
      return this.userRepository.findOneOrFail({
        where: { phone: pseudo },
      }).catch(
        (error)=>{
          console.log(error);
    
          throw new NotFoundException(
                "L'utilisateur avec l'pseudo " + pseudo + " est introuvable",
              );
        }
      )
    }
  
  
    
    change(id: number, updateUserDto: User) {
      this.findOne(id);
      updateUserDto.id = id;
      return this.userRepository.save(updateUserDto);
    }

    update(id: number, updateUserDto: User) {
      
        return this.userRepository.update(id, updateUserDto).catch((error)=>{
          console.log(error);
          throw new NotFoundException("L'utilisateur spécifier n'existe pas");      
        });
    }
  

  
    remove(id: number) {
     
        return this.userRepository.delete(id).catch((error)=>{
          console.log(error);
  
          throw new NotFoundException("L'utilisateur spécifier n'existe pas")
        });
    }
  }
  