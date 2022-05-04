/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsString, Min } from "class-validator";
import { IsNumber } from 'class-validator';

export class CreateTypeAmandeDto {
  @ApiProperty({required:true})
  @IsString({message:"Le nom du type d'amande est obligatoire", })
  nom: string;

  @ApiProperty({required:true})
  @IsNumber({allowNaN:false})
  @Min(1, {message:"Montant de l'amande invalide"})
  montant: number;

  @ApiProperty()
  @IsString()
  description: string;
}
