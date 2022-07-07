/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsNumber, IsObject, IsPositive, Min } from "class-validator";
import { EtatVehicule } from "src/enums/etat-vehicule";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";
import { CreateUserDto } from "./create-user.dto";

export class CreateConducteurWithUserDto {
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
