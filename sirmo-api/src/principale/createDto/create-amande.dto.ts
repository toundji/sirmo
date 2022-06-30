/* eslint-disable prettier/prettier */
import { IsArray, IsDate, IsNotEmpty, IsNumber, IsObject, IsOptional, Min } from "class-validator";
import { Police } from "../entities/police.entity";
import { TypeAmande } from "../entities/type-amande.entity";
import { Zem } from "../entities/zem.entity";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";
import { IsDateString } from 'class-validator';
import { IsPositive } from 'class-validator';

export class CreateAmandeDto {

  @ApiProperty({required: true})
  @IsString()
  @IsOptional()
  message: string;

  @ApiProperty({required:true})
  @IsDateString({always:true, message:"Veillez indique la date au plus tard que l'amande doit être payer"},)
  date_limite: Date;

  @ApiProperty({required:true})
  @IsNumber({}, {each:true})
  @IsPositive({each:true})
  typeAmndeIds?: number[];

  @ApiProperty({required:true})
  @IsNumber({},{message:"Le zem amander est requise"})
  @IsPositive( {message: "Le zem spécifié n'existe pas"})
  zem_id: number;
}
