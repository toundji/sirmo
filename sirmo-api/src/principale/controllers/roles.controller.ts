/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { RoleService } from '../services/roles.service';
import { CreateRoleDto } from '../createDto/create-role.dto';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { UpdateRoleDto } from '../updateDto/update-role.dto';
import { RoleName } from 'src/enums/role-name';

@ApiTags("Roles")
@ApiBearerAuth("token")
@Controller('roles')
export class RolesController {

  @Get()
  findAll():RoleName[] {
    return Object.values(RoleName);
  }
}
