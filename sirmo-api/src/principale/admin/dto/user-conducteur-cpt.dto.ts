/* eslint-disable prettier/prettier */
import { IsDateString, IsEmail, IsEnum, IsNotEmpty, IsNumberString,  IsOptional, IsPhoneNumber, IsPositive, IsString, MinLength, ValidateNested } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { Genre } from "src/enums/genre";
import { IsNumber } from 'class-validator';

export class CreateUserConducteurCptDto {

  
  @ApiProperty({required:true})
  @IsOptional()
  id?: number;

  @ApiProperty({required:true})
  @IsString()
  @IsOptional()
  profile_image?: string;

  @ApiProperty({required:true})
  @IsString()
  @IsOptional()
  idCarde_image?: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  ifu?: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  cip?: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  nip?: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  permis?: string;

  @ApiProperty()
  @IsDateString({message:"Vous devez spécifier la date d'obtention de votre permis"})
  date_optention_permis?: Date;

  @ApiProperty()
  @IsDateString({message:"Vous devez spécifier la date délivrance de votre ifu"})
  date_delivrance_ifu?:Date;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  @IsOptional()
  idCarde?: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  ancienIdentifiant?: string;

  @ApiProperty({required:true})
  @IsNumber({},{message : "Mairie non valide"})
  mairie_id?: number;

  @ApiProperty({required:true})
  @IsString()
  @IsNotEmpty()
  nom?: string;

  @ApiProperty({required:true})
  @IsString()
  @IsNotEmpty()
  prenom?: string;

  @ApiProperty({required:true, default:Genre.MASCULIN})
  @IsEnum(Genre)
  genre?: Genre;

  @ApiProperty({required:true})
  @IsString()
  @IsNotEmpty()
  password?: string;


  @ApiProperty()
  @IsString()
  date_naiss?: Date;

  @ApiProperty({required:true})
  @IsPhoneNumber("BJ")
  phone?: string;

  @ApiProperty({required:true})
  @IsString()
  arrondissement?: string;

}
