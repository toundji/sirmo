/* eslint-disable prettier/prettier */
import { IsNumber, IsNumberString } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { IsPositive } from 'class-validator';

export class CreateZemDto {

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
  certificatRoute: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  ancienIdentifiant: string;

  @ApiProperty({required:true})
  @IsNumber({},{message : "Utilisateur invalide"})
  @IsPositive({message: "L'utilisaeur invalide"})
  userId:number;
}
