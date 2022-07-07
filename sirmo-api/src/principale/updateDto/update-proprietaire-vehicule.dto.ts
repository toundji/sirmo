/* eslint-disable prettier/prettier */
import { PartialType } from '@nestjs/swagger';
import { CreateProprietaireVehiculeDto } from '../createDto/proprietaire-vehicule.dto';

export class UpdateProprietaireVehiculeDto extends PartialType(
  CreateProprietaireVehiculeDto,
) {}
