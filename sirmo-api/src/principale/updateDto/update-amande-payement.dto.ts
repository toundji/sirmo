/* eslint-disable prettier/prettier */

import { PartialType } from '@nestjs/swagger';
import { CreatePayementAmandeDto } from '../createDto/create-amande-payement.dto';

export class UpdatePayementAmandeDto extends PartialType(CreatePayementAmandeDto){}