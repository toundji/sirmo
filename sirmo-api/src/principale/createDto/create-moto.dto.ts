/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsNumber, IsObject, Min } from "class-validator";
import { EtatMoto } from "src/enums/etat-moto";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";
import { CreateProprietaireDto } from "./create-proprietaire-moto.dto";
import { CreateZemMDto, CreateZemMotoDto } from './create-zem-moto.dto';
import { CreateZemDto } from "./create-zem.dto";

export class CreateMotoDto {
  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero matricule de la plaque est obligatoire"})
  matricule: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero matricule de la plaque est obligatoire"})
  carteGrise: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero matricule de la plaque est obligatoire"})
  chassis: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero matricule de la plaque est obligatoire"})
  serie: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero matricule de la plaque est obligatoire"})
  etat: EtatMoto;

  @ApiProperty({required:true})
  @IsObject()
  proprietaire: CreateProprietaireDto;

  @ApiProperty({required:true})
  @IsObject()
  zem: CreateZemMDto;
}
