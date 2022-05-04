/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateArrondissementDto } from '../createDto/create-arrondissement.dto';

export class UpdateArrondissementDto extends PartialType(CreateArrondissementDto) {}
