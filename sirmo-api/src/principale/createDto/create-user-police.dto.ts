/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsObject } from "class-validator";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";
import { CreateUserDto } from './create-user.dto';

export class CreatePoliceWithUserDto {
  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero matricule de la plaque est obligatoire"})
  identifiant: string;

    
  @ApiProperty({required:true})
  @IsString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero matricule de la plaque est obligatoire"})
  ifu: string;


  @ApiProperty({required:true})
  @IsObject()
  user: CreateUserDto;

}
