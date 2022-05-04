/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateRoleDto } from '../createDto/create-role.dto';

export class UpdateRoleDto extends PartialType(CreateRoleDto) {}
