/* eslint-disable prettier/prettier */
  import { IsNumber, IsObject } from "class-validator";
import { CreatePayementDto } from './create-payement.dto';
import { IsPositive } from 'class-validator';

export class CreatePayementAmandeDto {

  @IsObject()
  monta:number;

  @IsNumber()
  @IsPositive()
  amande_id: number;
}
