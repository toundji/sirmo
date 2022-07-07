/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNumber } from "class-validator";
import { IsPositive } from 'class-validator';

export class PreLicenceDto {

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  montant: number;

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  conducteur_id: number;

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  mairie_id: number;

}