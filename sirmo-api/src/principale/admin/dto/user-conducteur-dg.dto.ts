/* eslint-disable prettier/prettier */
import { IsDateString, IsNumber, IsNumberString, IsObject, IsOptional, IsPositive, IsString, MinLength, ValidateNested } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { Type } from "class-transformer";
import { VehiculeSubDto } from "src/principale/createDto/vehicule-sub.dto";
import { UserDG_Dto } from "src/principale/admin/dto/user-dg.dto";

export class UserConducteurDG_Dto {

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
