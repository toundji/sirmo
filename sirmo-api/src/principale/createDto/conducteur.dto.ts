/* eslint-disable prettier/prettier */
import { IsDateString, IsNumber, IsNumberString, IsOptional, IsString } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { IsPositive } from 'class-validator';

export class CreateConducteurDto {

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  ifu: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  cip: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  nip: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  @IsOptional()
  nic: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  @IsOptional()
  idCarde: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  permis: string;

  @ApiProperty()
  @IsDateString({message:"Vous devez spécifier la date d'obtention de votre permis"})
  date_optention_permis: Date;

  @ApiProperty()
  @IsDateString({message:"Vous devez spécifier la date délivrance de votre ifu"})
  date_delivrance_ifu:Date;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  ancienIdentifiant: string;

  @ApiProperty({required:true})
  @IsNumber({},{message : "Utilisateur invalide"})
  @IsPositive({message: "L'utilisaeur invalide"})
  userId:number;

  @ApiProperty({required:true})
  @IsNumber({},{message : "Mairie non valide"})
  @IsPositive({message: "La mairie introuvable"})
  mairie_id:number;

  @ApiProperty({required:true})
  @IsString()
  @IsOptional()
  profile_image: string;

  @ApiProperty({required:true})
  @IsString()
  @IsOptional()
  idCarde_image: string;

}
