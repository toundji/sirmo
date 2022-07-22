/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber, IsOptional, IsString } from "class-validator";
import { IsPositive } from 'class-validator';

export class CreateLicenceDto {

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  vehicule_id: number;

  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  @IsOptional()
  mairie_id: number;

  @ApiProperty({required:true})
  @IsString()
  @IsNotEmpty()
  @IsOptional()
  transaction_id: string;

}