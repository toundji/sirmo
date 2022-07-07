/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsDate, IsNumber, Min } from "class-validator";
import { IsPositive } from 'class-validator';
import { IsDateString } from 'class-validator';

export class CreateLicenceDto {

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  montant: number;

  @ApiProperty({required:true})
  @IsDateString()
  dateDebut: Date;

  @ApiProperty({required:true})
  @IsDateString()
  dateFin: Date;

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  conducteur_id: number;

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  mairie_id: number;

}