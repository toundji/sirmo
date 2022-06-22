/* eslint-disable prettier/prettier */
import { IsNumberString, IsObject, MinLength, ValidateNested } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { CreateUserDto } from './create-user.dto';
import { IsNumber } from 'class-validator';
import { Type } from "class-transformer";

export class CreateUserZemDto {

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
  certificatRoute: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  ancienIdentifiant: string;

  @ApiProperty({required:true})
  @ValidateNested({ each: true })
  @Type(() => CreateUserDto)
  user:CreateUserDto;

}
