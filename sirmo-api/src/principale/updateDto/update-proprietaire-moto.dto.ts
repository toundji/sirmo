/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateProprietaireMotoDto } from '../createDto/create-proprietaire-moto.dto';

export class UpdateProprietaireMotoDto extends PartialType(
  CreateProprietaireMotoDto,
) {}
