/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateTypeAmandeDto } from '../createDto/create-type-amande.dto';

export class UpdateTypeAmandeDto extends PartialType(CreateTypeAmandeDto) {}
