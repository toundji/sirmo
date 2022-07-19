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
import { User } from "src/principale/entities/user.entity";
import { ArrondissementService } from "src/principale/services/arrondissement.service";
import { Repository } from "typeorm";

  @Injectable()
  export class UserAdminService {
    constructor(
      @InjectRepository(User) private userRepository: Repository<User>,
      private readonly arrondissementService: ArrondissementService,
    ) {}
  
 
    async createOwner(createUserDto: ProprietaireDto): Promise<User> {
      const user: User = new User();
      Object.keys(createUserDto).forEach((cle) => {
        user[cle] = createUserDto[cle];
      });
      user.roles = [RoleName.PROPRIETAIRE];
  
  
        const arrondisement: Arrondissement =
          await this.arrondissementService.findFirstByName(createUserDto.arrondissement);
        user.arrondissement = arrondisement;
  
        user.password = user.nom +( user.updated_at ?? '');
       
        const u: User = await this.userRepository.save(user).catch((error)=>{
          console.log(error);
          throw new BadRequestException("Erreur pendant la réation de l'utilisation. Vérifier que vos donnée n'existe pas déjà");
        });
        const compte:Compte = Compte.create({user:u, montant:0});
        Compte.save(compte);
  
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
  