/* eslint-disable prettier/prettier */
import { IsDateString, IsNumberString, IsObject, IsOptional, IsPositive, IsString, MinLength, ValidateNested } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { Type } from "class-transformer";
import { IsNumber } from 'class-validator';
import { CreateUserDto } from "src/principale/createDto/create-user.dto";

export class CreateUserConducteurDto {

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  @MinLength(13, {message: "Ifu invalide, Ifu trop court"})
  ifu: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  cip: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  nip: string;

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
  @IsOptional()
  idCarde: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  ancienIdentifiant: string;


  @ApiProperty({required:true})
  @IsNumber({},{message : "Mairie non valide"})
  @IsPositive()
  mairie_id:number;

  @ApiProperty({required:true})
  @ValidateNested({ each: true })
  @Type(() => CreateUserDto)
  user:CreateUserDto;

  @ApiProperty({required:true})
  @IsString()
  @IsOptional()
  profile_image: string;

  @ApiProperty({required:true})
  @IsString()
  @IsOptional()
  idCarde_image: string;

}
