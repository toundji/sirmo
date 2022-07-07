/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateConducteurDto } from '../createDto/conducteur.dto';

export class UpdateConducteurDto extends PartialType(CreateConducteurDto) {}
