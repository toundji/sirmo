/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateConducteurVehiculeDto } from '../createDto/create-conducteur-vehicule.dto';

export class UpdateConducteurVehiculeDto extends PartialType(CreateConducteurVehiculeDto) {}
