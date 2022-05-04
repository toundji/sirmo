/* eslint-disable prettier/prettier */
import { IsArray, IsDate, IsNotEmpty, IsNumber, IsObject, Min } from "class-validator";
import { Police } from "../entities/police.entity";
import { TypeAmande } from "../entities/type-amande.entity";
import { Zem } from "../entities/zem.entity";
import { IsString } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";

export class CreateAmandeDto {

  @ApiProperty({required: true})
  @IsString()
  message: string;

  @ApiProperty({required:true})
  @IsDate({always:true, message:"Veillez indique la date au plus tard que l'amande doit être payer"},)
  date_limite: Date;

  @ApiProperty({required:true})
  @IsArray({always:true, each:true})
  @IsNumber()
  @IsNotEmpty()
  typeAmndeIds?: number[];

  @ApiProperty({required:true})
  @IsNumber()
  @Min(1, {message: "Zem spécifier est invalide"})
  zem_id: number;
}
