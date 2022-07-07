/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsAlphanumeric, IsDate, IsIdentityCard, IsNumber, IsPositive, IsString, IS_NUMBER_STRING, Min } from "class-validator";
import { IsNotEmpty } from 'class-validator';


export class CreateConducteurVehiculeDto {
  
    @ApiProperty({required:true})
    @IsDate({message:"La date de début est obligatoir pour le champs date debut"})
    date_debut: Date = new Date();


    @ApiProperty({required:true})
    @IsDate()
    date_fin: Date;


    @ApiProperty({required:true})
    @IsNumber()
    @Min(1, {message: "L'identifiant du conducteur est invalide"})
    conducteur_id:number;
  
    @ApiProperty({required:true})
    @IsNumber()
    @Min(1, {message: "L'identifiant de la vehicule est invalide"})
    vehicule_id: number;

}


export class CreateConducteurMDto {
  
    @ApiProperty({required:true})
    @IsDate({message:"La date de début est obligatoir pour le champs date debut"})
    date_debut: Date = new Date();


    @ApiProperty({required:true})
    @IsDate()
    date_fin: Date;


    @ApiProperty({required:true})
    @IsNumber()
    @IsPositive()
    conducteur_id:number;

}
