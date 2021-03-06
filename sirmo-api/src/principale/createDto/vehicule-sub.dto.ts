/* eslint-disable prettier/prettier */
import { IsDateString, IsNotEmpty, IsNumber, IsObject, IsOptional, IsPositive, Min } from "class-validator";
import { EtatVehicule } from "src/enums/etat-vehicule";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";
import { IsNumberString } from 'class-validator';

export class VehiculeSubDto {

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
  @IsNotEmpty({message:"La couleur est obligatoire"})
  couleur:  string;


  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le code d'identification est obligatoire"})
  ci_er: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  etat: EtatVehicule;

  @ApiProperty({required:true})
  @IsDateString({message:"Format invalide"})
  @IsNotEmpty({message:"L'annee de mise en circulation est requise."})
  date_circulation:Date;


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
  @IsNumberString()
  @IsOptional()
  place_assise:number;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  ptac: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  pv: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  cu: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  carosserie:string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  categorie:string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  commune_enregistrement: string;


}
