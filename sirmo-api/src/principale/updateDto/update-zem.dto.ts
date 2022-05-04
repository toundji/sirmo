/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateZemDto } from '../createDto/create-zem.dto';

export class UpdateZemDto extends PartialType(CreateZemDto) {}
