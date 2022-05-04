/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateAppreciationDto } from '../createDto/create-appreciation.dto';

export class UpdateAppreciationDto extends PartialType(CreateAppreciationDto) {}
