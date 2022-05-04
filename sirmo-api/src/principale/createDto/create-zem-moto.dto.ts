/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsAlphanumeric, IsDate, IsIdentityCard, IsNumber, IsPositive, IsString, IS_NUMBER_STRING, Min } from "class-validator";
import { IsNotEmpty } from 'class-validator';


export class CreateZemMotoDto {
  
    @ApiProperty({required:true})
    @IsDate({message:"La date de début est obligatoir pour le champs date debut"})
    date_debut: Date = new Date();


    @ApiProperty({required:true})
    @IsDate()
    date_fin: Date;


    @ApiProperty({required:true})
    @IsNumber()
    @Min(1, {message: "L'identifiant du zem est invalide"})
    zem_id:number;
  
    @ApiProperty({required:true})
    @IsNumber()
    @Min(1, {message: "L'identifiant de la moto est invalide"})
    moto_id: number;

}


export class CreateZemMDto {
  
    @ApiProperty({required:true})
    @IsDate({message:"La date de début est obligatoir pour le champs date debut"})
    date_debut: Date = new Date();


    @ApiProperty({required:true})
    @IsDate()
    date_fin: Date;


    @ApiProperty({required:true})
    @IsNumber()
    @IsPositive()
    zem_id:number;

}
