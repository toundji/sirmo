/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsNumber, IsPositive, Min } from "class-validator";
import { EtatVehicule } from "src/enums/etat-vehicule";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";
import { IsNumberString } from 'class-validator';

export class CreatePoliceDto {
  @ApiProperty({required:true})
  @IsNumberString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero matricule de la plaque est obligatoire"})
  identifiant: string;

    
  @ApiProperty({required:true})
  @IsNumberString({message:"Format invalide"})
  @IsNotEmpty({message:"Le numero matricule de la plaque est obligatoire"})
  ifu: string;


  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  userId: number;

}
