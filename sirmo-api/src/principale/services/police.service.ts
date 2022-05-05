/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreatePoliceDto } from '../createDto/create-police.dto';
import { CreatePoliceWithUserDto } from '../createDto/create-user-police.dto';
import { Police } from '../entities/police.entity';
import { Role } from '../entities/role.entity';
import { User } from '../entities/user.entity';
import { RoleService } from './roles.service';
import { UserService } from './user.service';
import { RoleName } from 'src/enums/role-name';

@Injectable()
export class PoliceService {
  constructor(
    @InjectRepository(Police) private policeRepository: Repository<Police>,
    private readonly userService:UserService,
    private readonly roleService:RoleService,
  ) {}

  async create(createPoliceWithUserDto: CreatePoliceWithUserDto): Promise<Police> {
    const police: Police = new Police();
    Object.keys(createPoliceWithUserDto).forEach((cle) => {
      police[cle] = createPoliceWithUserDto[cle];
    });

    const role:Role = await this.roleService.findOneByName("zem");
    const user: User = await this.userService.createWithRole(createPoliceWithUserDto.user, [role]);
    police.user = user;

    try {
      return this.policeRepository.save(police);

    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    
    }
  }

  async createForUser(createPoliceDto: CreatePoliceDto): Promise<Police> {
    const police: Police = new Police();
    Object.keys(createPoliceDto).forEach((cle) => {
      police[cle] = createPoliceDto[cle];
    });

    try{
      const user: User = await this.userService.findOne(createPoliceDto.userId);
      const role:Role = await this.roleService.findOneByName(RoleName.POLICE);
      const index:number = user.roles.indexOf(role);
      if( index == -1){
        user.roles.push(role);
        this.userService.changeWithoutControle(user);
      }
      police.user = user;
      return this.policeRepository.save(police);
    }catch(e){
      console.log(e);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    
      }

  }

  

  findAll(): Promise<Police[]> {
    return this.policeRepository.find();
  }

  findOne(id: number): Promise<Police> {
    return this.policeRepository.findOneOrFail(id).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le policier spécifié n'existe pas");
    
    });
  }

  change(id: number, police: Police) {
    try {
      this.findOne(id);
    police.id = id;
    return this.policeRepository.save(police);
    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le policier spécifié n'existe pas");
    
    }
    
  }

  update(id: number, updatePoliceDto: Police) {
    try {
      return this.policeRepository.update(id, updatePoliceDto);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le policier spécifié n'existe pas");
    
    }
  }

  remove(id: number) {
    try {
      return this.policeRepository.delete(id);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le policier spécifié n'existe pas");
    
    }
  }
}
