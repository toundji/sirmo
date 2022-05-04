/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateDepartementDto } from '../createDto/create-departement.dto';

export class UpdateDepartementDto extends PartialType(CreateDepartementDto) {}
