/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, UpdateResult } from 'typeorm';
import { CreateUserZemDto } from '../createDto/create-user-zem.dto';
import { CreateZemDto } from '../createDto/create-zem.dto';
import { User } from '../entities/user.entity';
import { Zem } from '../entities/zem.entity';
import { UserService } from './user.service';
import { RoleService } from './roles.service';
import { Role } from '../entities/role.entity';
import { Compte } from './../entities/compte.entity';
import { CompteService } from './compte.service';
import { RoleName } from 'src/enums/role-name';
import { StatutZem } from 'src/enums/statut-zem';

@Injectable()
export class ZemService {
  constructor(@InjectRepository(Zem) private zemRepository: Repository<Zem>,
    private readonly userService:UserService,
    private readonly roleService:RoleService,
    private readonly compteService:CompteService,
    
  ) {}
  async create(createZemDto: CreateUserZemDto) {
    const zem:Zem = new Zem();

    Object.keys(createZemDto).forEach(cle=>{zem[cle] = createZemDto[cle]});
    const role:Role = await this.roleService.findOneByName(RoleName.ZEM);
    const user: User = await this.userService.createWithRole(createZemDto.user, [role]);
    zem.user = user;
    const zemSaved : Zem= await this.zemRepository.save(zem);
    // const compte: Compte = 
   
      await this.compteService.create( Compte.create({user:user, montant:0})).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");  
      });
      return zemSaved;
  }

  async createForUser(createZemDto: CreateZemDto) {
    const zem:Zem = new Zem();
    Object.keys(createZemDto).forEach(cle=>{zem[cle] = createZemDto[cle]});

      const user: User =  await this.userService.findOne(createZemDto.userId);
      const role:Role = await this.roleService.findOneByName(RoleName.ZEM);
      const index:number = user.roles.indexOf(role);
      if( index == -1){
        user.roles.push(role);
        this.userService.changeWithoutControle(user);
      }
      zem.user = user;
      const zemSaved: Zem= await this.zemRepository.save(zem);
      // const compte: Compte = 
      await this.compteService.create(Compte.create({user:user, montant:0, id:user?.id})).catch((error)=>{

      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      });
      return zemSaved;
  }

  async requestByUser(createZemDto: CreateZemDto, user?:User) {
     await this.findForUser(user.id).then((zems:Zem[])=>{
      if(zems.length>0) throw new BadRequestException("Vous êtes déjà un zem");
      return [];
    })
    const zem:Zem = new Zem();
    Object.keys(createZemDto).forEach(cle=>{zem[cle] = createZemDto[cle]});

      zem.user = user;
      zem.statut = StatutZem.DEMANDE;
      const zemSaved: Zem= await this.zemRepository.save(zem);

      await this.compteService.create(Compte.create({user:user, montant:0, id:user?.id})).catch((error)=>{

      console.log(error);
      throw new BadRequestException("Création de zem: Données invalides");
      });
      return zemSaved;
  }

  createAll(createZemDto: CreateZemDto[]) {
      return this.zemRepository.save(createZemDto).catch((error)=>{
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      });
  }

  findAll() : Promise<Zem[]>{
    return this.zemRepository.find();
  }

  findByStatus(status: StatutZem) : Promise<Zem[]>{
    return this.zemRepository.find({where:{statut: status}}).catch((error)=>{
      console.log(error);
      throw new BadRequestException("Erreur pendant la récupération des zems. Veillez reprendre ou contacter un administrateur si cela persiste");
    });
  }

  findOne(id: number) {
    return this.zemRepository.findOneOrFail(id).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le zem spécifié n'existe pas");
    });
  }

  findForUser(user_id: number):Promise<Zem[]> {
    return this.zemRepository.find({where:{ user: User.create({id: user_id}) }}).catch((error)=>{
      console.log(error);

      throw new NotFoundException("Le zem spécifié n'existe pas");
    });
  }

  findActifForUser(user_id: number):Promise<Zem> {
    const user:User = User.create({id: user_id});
    return this.zemRepository.find({where:{ user: user, statut: StatutZem.ACTIF}})
    .then((zems:Zem[])=>{
      if(zems.length>0)return zems[0];
      throw new NotFoundException();
    })

    .catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le zem spécifié n'existe pas");
    });
  }

  update(id: number, updateZemDto: Zem): Promise<Zem> {
   
      return this.zemRepository.update(id, updateZemDto). then((zem: UpdateResult) => zem.raw).catch((error)=>{
        console.log(error);
       throw new NotFoundException("Le zem spécifié n'existe pas");
      });
  }

  changed(id:number, updateZemDto: Zem){
    
      this.findOne(id);
      updateZemDto.id = id;
     return this.zemRepository.save(updateZemDto).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le zem spécifié n'existe pas");
    
     });

  }

  remove(id: number) {
   
      return this.zemRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le zem spécifié n'existe pas ou dépend d'autre données");
      
      });

   
  }

}
