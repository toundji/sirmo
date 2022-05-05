/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable } from '@nestjs/common';
import { CreateRoleDto } from '../createDto/create-role.dto';
import { Repository } from 'typeorm';
import { Role } from '../entities/role.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { UpdateRoleDto } from '../updateDto/update-role.dto';
import { NotFoundException } from '@nestjs/common';
import { RoleName } from 'src/enums/role-name';

@Injectable()
export class RoleService {
  constructor(  @InjectRepository(Role)  private roleRepository: Repository<Role>){}
  create(createRoleDto: CreateRoleDto) {
    return this.roleRepository.save(createRoleDto);
  }

  createAll(createRoleDto: CreateRoleDto[]) {
    try {
      return this.roleRepository.save(createRoleDto);

    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    
    }
  }

  findAll() {
    return this.roleRepository.find();
  }

  findAllByIds(ids:number[]) {
    return this.roleRepository.findByIds(ids);
  }

  findOne(id: number) {
    return this.roleRepository.findOneOrFail(id).catch((e)=>{
      throw new NotFoundException("Le role spécifié n'existe pas");
    });
  }

 

  findOneByName(name: string):Promise<Role> {
    try{return this.roleRepository.findOne({where:{
      nom: name.toUpperCase()
    }});}catch(e){
      throw new NotFoundException("Recupération d'un rôle", e.message);
    }
  }

  update(id: number, updateRoleDto: UpdateRoleDto) {
    return this.roleRepository.update(id, updateRoleDto);
  }

  remove(id: number) {
    return this.roleRepository.delete(id);
  }

  async init(){
    const roles: Role[] = await this.findAll();
    if(!roles || roles.length === 0){
      Object.values(RoleName).forEach(value=>{
        roles.push({"nom" : value} as Role);
      })
      return this.roleRepository.save(roles);
    }
  }
}
