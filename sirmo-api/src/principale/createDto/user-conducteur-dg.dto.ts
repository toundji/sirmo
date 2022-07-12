/* eslint-disable prettier/prettier */
import { IsDateString, IsNumber, IsNumberString, IsObject, IsOptional, IsPositive, IsString, MinLength, ValidateNested } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { CreateUserDto } from './create-user.dto';
import { Type } from "class-transformer";
import { VehiculeSubDto } from "./vehicule-sub.dto";
import { UserDG_Dto } from './user-dg.dto';

export class UserConducteurDG_Dto {

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  @MinLength(13, {message: "Ifu invalide, Ifu trop court"})
  ifu: string;

  @MinLength(14, {message: "cip invalide, cip trop court"})
  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  cip: string;

  @MinLength(10, {message: "nip invalide, nip trop court"})
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
  @IsString()
  @IsOptional()
  profile_image: string;

  @ApiProperty({required:true})
  @IsString()
  @IsOptional()
  idCarde_image: string;


  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  ancienIdentifiant: string;

  @ApiProperty({required:true})
  @ValidateNested({ each: true })
  @Type(() => UserDG_Dto)
  user: UserDG_Dto;

  @ApiProperty({required:true})
  @ValidateNested({ each: true })
  @Type(() => VehiculeSubDto)
  vehicule: VehiculeSubDto;

  @ApiProperty({required:true})
  @ValidateNested({ each: true })
  @Type(() => UserDG_Dto )
  @IsOptional()
  proprietaire: UserDG_Dto ;

  @ApiProperty({required:true})
  @IsNumberString({},{message : "Mairie non valide"})
  mairie_id?:number;

}
