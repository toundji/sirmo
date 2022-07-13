/* eslint-disable prettier/prettier */
import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
  UploadedFile,
} from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm";
import { CreateUserDto } from "../createDto/create-user.dto";
import { Role } from "../entities/role.entity";
import { User } from "../entities/user.entity";
import { RoleService } from "./roles.service";
import { ArrondissementService } from "./arrondissement.service";
import { Arrondissement } from "./../entities/arrondissement.entity";
import { Logger } from "@nestjs/common";
import { HttpException } from "@nestjs/common";
import { HttpStatus } from "@nestjs/common";
import { FichierService } from "./fichier.service";
import { Fichier } from "../entities/fichier.entity";
import { RoleName } from 'src/enums/role-name';
import { Genre } from "src/enums/genre";
import { CreateUserWithRoleDto } from "../createDto/create-user-with-role.dto";
import { error, profile } from 'console';
import { Compte } from "../entities/compte.entity";
import { ChangePasswordDto } from './../createDto/change-password.dto';
import { compare, hash } from "bcrypt";
import { ChangeEmailDto } from "../createDto/change-emeail.dto";
import { UserDG_Dto } from '../admin/dto/user-dg.dto';
import { ProprietaireDto } from './../createDto/proprietaireDto';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User) private userRepository: Repository<User>,
    private readonly arrondissementService: ArrondissementService,
    private readonly fichierService: FichierService,
  ) {}

  async create(createUserDto: CreateUserWithRoleDto): Promise<User> {
    const user: User = new User();
    Object.keys(createUserDto).forEach((cle) => {
      user[cle] = createUserDto[cle];
    });
    user.roles = createUserDto.roles;
    user.roles ??= [];
    if(user.roles.indexOf(RoleName.USER) == -1){
      user.roles.push(RoleName.USER);
    }

    const arrondisement: Arrondissement =
      await this.arrondissementService.findOne(createUserDto.arrondissement);
    user.arrondissement = arrondisement;
    
      const u: User = await this.userRepository.save(user).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Erreur pendant la réation de l'utilisation. Vérifier que vos donnée n'existe pas déjà");
      });
      const compte:Compte = Compte.create({user:u, montant:0});
      Compte.save(compte);

      return u;
  
  }

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



 

  async register(createUserDto: CreateUserDto): Promise<User> {
    const user: User = new User();
    Object.keys(createUserDto).forEach((cle) => {
      user[cle] = createUserDto[cle];
    });
    user.roles = [RoleName.USER];

  
      const arrondisement: Arrondissement =
        await this.arrondissementService.findOne(createUserDto.arrondissement_id);
      user.arrondissement = arrondisement;
     
      const u: User = await this.userRepository.save(user).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Erreur pendant la réation de l'utilisation. Vérifier que vos donnée n'existe pas déjà");
      });
      const compte:Compte = Compte.create({user:u, montant:0});
      Compte.save(compte);

      return u;
  
  }

  async createWithProfile(
    createUserDto: CreateUserDto,
    @UploadedFile() profile
  ): Promise<User> {
    const user: User = new User();
    Object.keys(createUserDto).forEach((cle) => {
      user[cle] = createUserDto[cle];
    });
    
      user.roles = [RoleName.USER];

      const arrondisement: Arrondissement =
        await this.arrondissementService.findOne(+createUserDto.arrondissement_id);
      user.arrondissement = arrondisement;
      console.log(arrondisement);
      const name = profile.originalname.split(".")[0];
      const file: Fichier = Fichier.fromMap({
        nom: name,
        path: profile.path,
        mimetype: profile.mimetype,
        size: profile.size,
        entity: User.entityName,
      });
      const profil: Fichier = await this.fichierService.create(file);
      user.profile = profil;

      const userSaved = await this.userRepository.save(user).catch((error)=>{
        console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celle que nous espérons");
  
      });
      profil.entityId = userSaved.id;
      await this.fichierService.create(file);

      return userSaved;
    
  }

  async updateProfile(id: number, @UploadedFile() profile, createur: User) {
    const user: User = await this.findOne(id);
    const profil: Fichier = await this.fichierService.createOneWith(
      profile,
      User.entityName,
      id,
      createur,
    );
    user.profile = profil;
    user.profiles ??= [];
    user.profiles.push(profil);
    
      return this.userRepository.save(user).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont pas celles que nous espérons")
  
      });
  }

  async getUserProfile(id:number){
   const user:User= await  this.userRepository.findOneOrFail(id,{relations: ["profile"]}).catch((error)=>{
      console.log(error);
      throw new NotFoundException(
        "L'utilisateur avec spécifié n'existe est introuvable",
      );
    });
    console.log(user);
    if(user && user.profile){
      return user.profile;
    }
    throw new NotFoundException("Vous n'avez pas ajoutez une photo de profile")
  }

  async editUserProfilePath(id:number, @UploadedFile() profile,):Promise<string>{
    
    const user:User= await  this.userRepository.findOneOrFail(id,{relations: ["profile"]}).catch((error)=>{
       console.log(error);
       throw new NotFoundException(
         "L'utilisateur avec spécifié n'existe est introuvable",
       );
     });
     if(user && user.profile){
       const fichier:Fichier = user.profile;
       const name = profile.originalname.split(".")[0];
       fichier.nom = name;
       fichier.path = profile.path;
       fichier.mimetype = profile.mimetype;
       fichier.size = profile.size;
       await Fichier.save(fichier);
       return "Image de profile modifiée avec succès";
     }
     throw new NotFoundException("Vous n'avez pas ajoutez une photo de profile")
   }

  async createWithRole(
    createUserDto: CreateUserDto|UserDG_Dto,
    roles: RoleName[],
  ): Promise<User> {
    const user: User = new User();
    Object.keys(createUserDto).forEach((cle) => {
      user[cle] = createUserDto[cle];
    });
    user.roles = roles;
    
    if(createUserDto['arrondissement_id']){
        const arrondisement: Arrondissement =
        await this.arrondissementService.findOne(createUserDto['arrondissement_id']);
        user.arrondissement = arrondisement;
      }
      if(createUserDto['arrondissement']){
        const arrondisement: Arrondissement =
        await this.arrondissementService.findFirstByName(createUserDto['arrondissement']);
        user.arrondissement = arrondisement;
      }

      const u: User = await this.userRepository.save(user).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Erreur pendant la réation de l'utilisation. Vérifier que vos donnée n'existe pas déjà");
      });
      const compte:Compte = Compte.create({user:u, montant:0});
      Compte.save(compte);

      return u;
  }

  findAll(): Promise<User[]> {
    return this.userRepository.find({ relations: ["roles", "arrondissement"] });
  }

  findOne(id: number): Promise<User> {
    
      return this.userRepository.findOneOrFail(id, {
        relations: ["roles", "arrondissement"],
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
  countByMailOrPHone(mailOrPhone:string): Promise<number>{
    return this.userRepository.count({where: [{email: mailOrPhone}, {phone: mailOrPhone}]}).catch(
      (error)=>{
        throw new InternalServerErrorException("Erreur de traitement: "+error.message);
      });
  }
  countByEmail(mailOrPhone:string): Promise<number>{
   return this.userRepository.count({where: {email: mailOrPhone}}).catch(
      (error)=>{
        throw new InternalServerErrorException("Erreur de traitement: "+error.message);
      });
  }
  countByPhone(mailOrPhone:string): Promise<number>{
    return this.userRepository.count({where:  {phone: mailOrPhone}}).catch(
      (error)=>{
        throw new InternalServerErrorException("Erreur de traitement: "+error.message);
      });
  }
  change(id: number, updateUserDto: User) {
    this.findOne(id);
    updateUserDto.id = id;
    return this.userRepository.save(updateUserDto);
  }

  async changePassword( body: ChangePasswordDto, user:User): Promise<string> {
    const areEqual = await compare( body.old, user.password);
    if (!areEqual) {
      throw new HttpException(
        "Nom d'utilisateur ou mot de passe invalide ",
        HttpStatus.UNAUTHORIZED,
      );
    }

    // return user;
    await this.userRepository.update(user.id, {password: await hash(body.nevel, 10) });

    return "Mot de pass mise à jour avec succès";
  }

  async changePhone( body: ChangePasswordDto, user:User): Promise<string> {
    if(body.old?.trim() &&  body.old?.trim() != user.phone.trim()){
      throw new HttpException(
        "L'ancien numéro de téléphone que vous avez indiqué ne correspond pas au numéro existant",
        HttpStatus.UNAUTHORIZED,
      );
    }
    this.userRepository.find({where:[{phone: body.nevel}, {phone: body.nevel.trim()}]}).then((users:[])=>{
      if(users.length > 1){
        throw new BadRequestException("L'ancien numéro de téléphone que vous avez indiqué existe déjà")
      }
    });

    // return user;
    await this.userRepository.update(user.id, {phone:  body.nevel.trim()  });

    return "Mot de pass mise à jour avec succès";
  }

  async changeEmail( body: ChangeEmailDto, user:User): Promise<string> {
    if(body.old?.trim() &&  body.old?.trim() != user.email.trim()){
      throw new HttpException(
        "L'ancien email que vous avez indiqué ne correspond pas à l'email existant",
        HttpStatus.UNAUTHORIZED,
      );
    }

    this.userRepository.find({where:[{email: body.nevel}, {email: body.nevel.trim()}]}).then((users:[])=>{
      if(users.length > 1){
        throw new BadRequestException("L'email que vous avez indiqué existe déjà")
      }
    }).catch((error)=>{
      throw new InternalServerErrorException("Vérification d'email: " + error.message);
    });

    // return user;
    await this.userRepository.update(user.id, {email:  body.nevel.trim().toLowerCase()});

    return "Mot de pass mise à jour avec succès";
  }
  changeWithoutControle(updateUserDto: User) {
 
      return this.userRepository.save(updateUserDto).catch((error)=>{
        console.log(error);

        throw new BadRequestException("Les données que nous avons réçues ne sont pas celles que nous espérons")
     
      });

  }

  update(id: number, updateUserDto: User) {
    
      return this.userRepository.update(id, updateUserDto).catch((error)=>{
        console.log(error);
        throw new NotFoundException("L'utilisateur spécifier n'existe pas");      
      });
  }

  async updateAll() {
   const users: User[] = await this.findAll();
    return this.userRepository.save(users).catch((error)=>{
      console.log(error);

      throw new BadRequestException("L'utilisateur spécifier n'existe pas");
    })
  }

  remove(id: number) {
   
      return this.userRepository.delete(id).catch((error)=>{
        console.log(error);

        throw new NotFoundException("L'utilisateur spécifier n'existe pas")
      });
  }

  async initOneAdmin() {
    let user: User;
    try {
      user = await this.findOneByPseudo("+22992920202");
    } catch (e) {}
    if (user) return;
    user = new User();
  
    user.roles = Object.values(RoleName);

    const arrondis = await this.arrondissementService.findOne(103);
    if (!arrondis) {
      throw new HttpException(
        "Vous devez initialiser les arrondissement avant",
        HttpStatus.BAD_REQUEST,
      );
    }
    user.arrondissement = arrondis;
    user.prenom = "Ola";
    user.nom = "BABA";
    user.genre = Genre.MASCULIN;
    user.email = "Baba@gmail.com";
    user.password = "Baba@1234";
    user.phone = "+22994851785";
    user.date_naiss = new Date();
    const u: User =  await this.userRepository.save(user);
    const compte:Compte = Compte.create({user:u, montant:0});
    Compte.save(compte);
    return u;

  }
}
