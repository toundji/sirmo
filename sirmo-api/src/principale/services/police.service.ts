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
  ) {}

  async create(createPoliceWithUserDto: CreatePoliceWithUserDto): Promise<Police> {
    const police: Police = new Police();
    Object.keys(createPoliceWithUserDto).forEach((cle) => {
      police[cle] = createPoliceWithUserDto[cle];
    });

    const user: User = await this.userService.createWithRole(createPoliceWithUserDto.user, [RoleName.POLICE]);
    police.user = user;

  
      return this.policeRepository.save(police).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      
      });

  }

  async createForUser(createPoliceDto: CreatePoliceDto): Promise<Police> {
    const police: Police = new Police();
    Object.keys(createPoliceDto).forEach((cle) => {
      police[cle] = createPoliceDto[cle];
    });

  
      const user: User = await this.userService.findOne(createPoliceDto.userId);
      const index:number = user.roles.indexOf(RoleName.POLICE);
      if( index == -1){
        user.roles.push(RoleName.POLICE);
        this.userService.changeWithoutControle(user);
      }
      police.user = user;
      return this.policeRepository.save(police).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
      });
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
//.catch((error)=>{})

  change(id: number, police: Police) {
   
      this.findOne(id);
    police.id = id;
    return this.policeRepository.save(police).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le policier spécifié n'existe pas");
    
    });
   
    
  }

  update(id: number, updatePoliceDto: Police) {
  
      return this.policeRepository.update(id, updatePoliceDto).catch((error)=>{
        console.log(error);
      throw new NotFoundException("Le policier spécifié n'existe pas");
    
      });

  }

  remove(id: number) {
  
      return this.policeRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le policier spécifié n'existe pas");
      
      });

  }
}
