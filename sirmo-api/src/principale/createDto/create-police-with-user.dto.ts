/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsNumber, IsObject, IsPositive, Min } from "class-validator";
import { EtatMoto } from "src/enums/etat-moto";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";
import { CreateUserDto } from "./create-user.dto";

export class CreateZemWithUserDto {
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
  user:CreateUserDto;

}
