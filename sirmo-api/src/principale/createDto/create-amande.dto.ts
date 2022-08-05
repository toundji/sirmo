/* eslint-disable prettier/prettier */
import { IsNumber,  IsOptional, IsString } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { IsDateString } from 'class-validator';
import { IsPositive } from 'class-validator';

export class CreateAmandeDto {

  @ApiProperty({required: true})
  @IsString()
  @IsOptional()
  message: string;

  @ApiProperty({required:true})
  @IsNumber({}, {each:true})
  @IsPositive({each:true})
  typeAmndeIds?: number[];

  @ApiProperty({required:true})
  @IsNumber({},{message:"Le conducteur amander est requise"})
  @IsPositive( {message: "Le conducteur spécifié n'existe pas"})
  conducteur_id: number;
}
