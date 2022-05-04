/* eslint-disable prettier/prettier */
import { Injectable, Logger } from '@nestjs/common';
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
    const role:Role = await this.roleService.findOneByName("zem");
    const user: User = await this.userService.createWithRole(createZemDto.user, [role]);
    zem.user = user;
    const zemSaved : Zem= await this.zemRepository.save(zem);
    // const compte: Compte = 
    await this.compteService.create(new Compte({zem:zemSaved}));
    return zemSaved;
  }

  async createForUser(createZemDto: CreateZemDto) {
    const zem:Zem = new Zem();
    Object.keys(createZemDto).forEach(cle=>{zem[cle] = createZemDto[cle]});

    try{
      const user: User =  await this.userService.findOne(createZemDto.userId);
      const role:Role = await this.roleService.findOneByName("zem");
      const index:number = user.roles.indexOf(role);
      if( index == -1){
        user.roles.push(role);
        this.userService.changeWithoutControle(user);
      }
      zem.user = user;
      const zemSaved: Zem= await this.zemRepository.save(zem);
      // const compte: Compte = 
      await this.compteService.create(new Compte({zem:zemSaved}));
      return zemSaved;
    }catch(e){
      Logger.debug(e);
      throw e;
    }
  }

  createAll(createZemDto: CreateZemDto[]) {
    return this.zemRepository.save(createZemDto);
  }

  findAll() : Promise<Zem[]>{
    return this.zemRepository.find();
  }

  findOne(id: number) {
    return this.zemRepository.findOneOrFail(id);
  }

  update(id: number, updateZemDto: Zem): Promise<Zem> {
    return this.zemRepository.update(id, updateZemDto). then((zem: UpdateResult) => zem.raw);
  }

  changed(id:number, updateZemDto: Zem){
     this.findOne(id);
     updateZemDto.id = id;
    return this.zemRepository.save(updateZemDto);
  }

  remove(id: number) {
    return this.zemRepository.delete(id);
  }

  async initZemCompt(){
    const zems: Zem[] = await this.findAll();
    const comptes: Compte[] = [] ;

    zems.forEach(zem=>{
      comptes.push(new Compte({zem:zem}));
    });
   return this.compteService.createAll(comptes);
  }
}
