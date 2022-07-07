/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateConstanteDto } from '../createDto/constante.dto';

export class UpdateConstanteDto extends PartialType(CreateConstanteDto) {}
