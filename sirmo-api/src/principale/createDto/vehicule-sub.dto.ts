/* eslint-disable prettier/prettier */
import { IsDateString, IsNotEmpty, IsNumber, IsObject, IsPositive, Min } from "class-validator";
import { EtatVehicule } from "src/enums/etat-vehicule";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";

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
  @IsNotEmpty({message:"Le numéro serie moteur est obligatoire"})
  numero_serie_moteur:  string;


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
  @IsNumber()
  @IsPositive({message:"Le nombre de places d'assise doit être suppérieur ou égale à 1"})
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
  cv: string;

  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le  est obligatoire"})
  puissance_fiscale:string;

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
  pays_immatriculation: string;


}
