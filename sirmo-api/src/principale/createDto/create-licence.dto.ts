/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsDate, IsNumber, Min } from "class-validator";
import { IsPositive } from 'class-validator';

export class CreateLicenceDto {

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  montant: number;

  @ApiProperty({required:true})
  @IsDate({always:true})
  dateDebut: Date;

  @ApiProperty({required:true})
  @IsDate({always:true})
  dateFin: Date;

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  zem_id: number;

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  mairie_id: number;

}