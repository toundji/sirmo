/* eslint-disable prettier/prettier */
import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsOptional } from 'class-validator';
import { IsNull } from 'typeorm';
export class CreateLocalisationDto {

  @ApiProperty({required:true})
  @IsNotEmpty()
  @IsNumber()
  longitude: number;

  @ApiProperty({required:true})
  @IsNotEmpty()
  @IsNumber({},{message:"Latitude doit être un nombre"})
  latitude: number;

  @ApiProperty({required:true})
  @IsNumber({}, {message:"Altitude doit être un nombre"})
  @IsOptional()
  altitude?: number;

  @ApiProperty({required:true})
  @IsNumber({}, {message:"Speed doit être un nombre"})
  @IsOptional()
  speed?: number;

  @ApiProperty({required:true})
  @IsNumber({},{message:"Occuracy doit être un nombre"})
  @IsOptional()
  accuracy?: number;

  entity?: string;

  @ApiProperty({required:true})
  @IsNumber({}, {message:"Occuracy doit être un nombre"})
  @IsOptional()
  entityId?: number;
}
