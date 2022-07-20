/* eslint-disable prettier/prettier */
;
import { PartialType } from '@nestjs/swagger';
import { IsNumber, IsPositive } from 'class-validator/types/decorator/decorators';
import { CreateVehiculeByConducteurDto } from "./vehicule-by-conducteur.dto";



export class UpdateVehiculeByConducteurDto extends PartialType(CreateVehiculeByConducteurDto) {
  @IsPositive()
  @IsNumber()
  id:number;
}
