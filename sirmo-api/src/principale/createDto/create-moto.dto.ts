/* eslint-disable prettier/prettier */
import { IsDateString, IsNotEmpty, IsNumber, IsObject, Min } from "class-validator";
import { EtatMoto } from "src/enums/etat-moto";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";
import { CreateProprietaireDto } from "./create-proprietaire-moto.dto";
import { CreateZemMDto, CreateZemMotoDto } from './create-zem-moto.dto';
import { CreateZemDto } from "./create-zem.dto";



export class CreateMotoDto {

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  numero matricule de la plaque est obligatoire"})
  immatriculation: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numéro de la carte grise  est obligatoire"})
  numero_carte_grise: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numéro chassis est obligatoire"})
  numero_chassis: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numéro série est obligatoire"})
  numero_serie: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numéro serie moteur est obligatoire"})
  numero_serie_moteur:  string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  etat: EtatMoto;

  
  @ApiProperty({required:true})
  @IsDateString({message:"Format invalide"})
  @IsNotEmpty({message:"L'annee de mise en circulation est requise."})
  annee_mise_circulation:Date;

  @ApiProperty({required:true})
  @IsDateString({message:"Format invalide"})
  @IsNotEmpty({message:"La date de revision est requise."})
  derniere_revision:Date;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le provenance  est obligatoire"})
  provenance:string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le puissance est obligatoire"})
  puissance:string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero energie de la plaque est obligatoire"})
  energie:string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  marque:string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero energie de la plaque est obligatoire"})
  modele:string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  type:string;

  @ApiProperty({required:true})
  @IsObject()
  proprietaire: CreateProprietaireDto;

  @ApiProperty({required:true})
  @IsObject()
  zem: CreateZemMDto;
}
