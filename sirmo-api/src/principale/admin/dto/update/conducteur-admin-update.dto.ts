/* eslint-disable prettier/prettier 
import { CreateUserConducteurCptDto } from "../user-conducteur-cpt.dto";
/* eslint-disable prettier/prettier */
import { IsDateString, IsEmail, IsEnum, IsNotEmpty, IsNumberString,  IsOptional, IsPhoneNumber, IsPositive, IsString, MinLength, ValidateNested } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { Genre } from "src/enums/genre";
import { IsNumber } from 'class-validator';

export class UpdateUserConducteurCompacteDto {
    
  
    @ApiProperty({required:true})
    @IsPositive()
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
    @IsOptional()
    ifu?: string;
  
    @ApiProperty({required:true})
    @IsNumberString({},{message:"Seules les chiffres sont valides"})
    @IsOptional()
    cip?: string;
  
    @ApiProperty({required:true})
    @IsNumberString({},{message:"Seules les chiffres sont valides"})
    @IsOptional()
    nip?: string;
  
    @ApiProperty({required:true})
    @IsNumberString({},{message:"Seules les chiffres sont valides"})
    @IsOptional()
    permis?: string;
  
    @ApiProperty()
    @IsDateString({message:"Vous devez spécifier la date d'obtention de votre permis"})
    @IsOptional()
    date_optention_permis?: Date;
  
    @ApiProperty()
    @IsDateString({message:"Vous devez spécifier la date délivrance de votre ifu"})
    @IsOptional()
    date_delivrance_ifu?:Date;
  
    @ApiProperty({required:true})
    @IsNumberString({},{message:"Seules les chiffres sont valides"})
    @IsOptional()
    idCarde?: string;
  
    @ApiProperty({required:true})
    @IsNumberString({},{message:"Seules les chiffres sont valides"})
    @IsOptional()
    ancienIdentifiant?: string;
  
    @ApiProperty({required:true})
    @IsNumber({},{message : "Mairie non valide"})
    @IsOptional()
    mairie_id?: number;
  
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    nom?: string;
  
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    prenom?: string;
  
    @ApiProperty({required:true, default:Genre.MASCULIN})
    @IsEnum(Genre)
    @IsOptional()
    genre?: Genre;
  
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    password?: string;
  
  
    @ApiProperty()
    @IsString()
    @IsOptional()
    date_naiss?: Date;
  
    @ApiProperty({required:true})
    @IsPhoneNumber("BJ")
    @IsOptional()
    phone?: string;
  
    @ApiProperty({required:true})
    @IsString()
    @IsOptional()
    arrondissement?: string;
}
