/* eslint-disable prettier/prettier */
import {
  BadRequestException,
  Injectable,
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

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User) private userRepository: Repository<User>,
    private readonly roleService: RoleService,
    private readonly arrondissementService: ArrondissementService,
    private readonly fichierService: FichierService,
  ) {}

  async create(createUserDto: CreateUserDto): Promise<User> {
    const user: User = new User();
    Object.keys(createUserDto).forEach((cle) => {
      user[cle] = createUserDto[cle];
    });
   
    const role: Role = await this.roleService.findOneByName(RoleName.USER);
    user.roles = [role];

      const arrondisement: Arrondissement =
        await this.arrondissementService.findOne(createUserDto.arrondissement);
      user.arrondissement = arrondisement;
      return this.userRepository.save(user).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons récu ne sont pas celle que nous espérons");
      
      });
  
  }

  async createWithProfile(
    createUserDto: CreateUserDto,
    @UploadedFile() profile,
  ): Promise<User> {
    const user: User = new User();
    Object.keys(createUserDto).forEach((cle) => {
      user[cle] = createUserDto[cle];
    });
    
      const role: Role = await this.roleService.findOneByName(RoleName.USER);
      user.roles = [role];

      const arrondisement: Arrondissement =
        await this.arrondissementService.findOne(+createUserDto.arrondissement);
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

  async createWithRole(
    createUserDto: CreateUserDto,
    roles: Role[],
  ): Promise<User> {
    const user: User = new User();
    Object.keys(createUserDto).forEach((cle) => {
      user[cle] = createUserDto[cle];
    });
    user.roles = roles;

    
      const arrondisement: Arrondissement =
        await this.arrondissementService.findOne(createUserDto.arrondissement);
      user.arrondissement = arrondisement;
      return this.userRepository.save(user).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont pas celles que nous espérons")
      
      });
   
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
    );
  
  }

  change(id: number, updateUserDto: User) {
    this.findOne(id);
    updateUserDto.id = id;
    return this.userRepository.save(updateUserDto);
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

    const roles: Role[] = await this.roleService.findAll();
    if (!roles) {
      throw new HttpException(
        "Vous devez initialiser les roles avants",
        HttpStatus.BAD_REQUEST,
      );
    }
    user.roles = roles;

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
    user.genre = true;
    user.email = "Baba@gmail.com";
    user.password = "Baba@1234";
    user.phone = "+22994851785";
    user.date_naiss = new Date();
    this.userRepository.save(user);
  }

  async grandAllRole() {
    const user: User = await this.findOne(1);
    const roles: Role[] = await this.roleService.findAll();
    user.roles = roles;
    this.userRepository.save(user);
  }
}
