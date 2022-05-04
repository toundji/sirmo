/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/mapped-types';
import { CreateUserDto } from '../createDto/create-user.dto';

export class UpdateUserDto extends PartialType(CreateUserDto) {}
