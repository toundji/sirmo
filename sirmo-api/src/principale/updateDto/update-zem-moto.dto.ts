/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateZemMotoDto } from '../createDto/create-zem-moto.dto';

export class UpdateZemMotoDto extends PartialType(CreateZemMotoDto) {}
