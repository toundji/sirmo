/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateCommuneDto } from '../createDto/create-commune.dto';

export class UpdateCommuneDto extends PartialType(CreateCommuneDto) {}
