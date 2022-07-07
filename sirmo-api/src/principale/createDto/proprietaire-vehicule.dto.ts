/* eslint-disable prettier/prettier */
import { ApiProperty } from '@nestjs/swagger';
import { IsDate, IsNumber, Min } from 'class-validator';

export class CreateProprietaireVehiculeDto {
    @ApiProperty({required:true})
    @IsDate({message:"La date de début est obligatoir pour le champs date debut", always:true})
    date_debut: Date = new Date();

    @ApiProperty({required:true})
    @IsDate()
    date_fin: Date;

    @ApiProperty({required:true})
    @IsNumber()
    @Min(1, {message: "L'identifiant du proprietaire est invalide"})
    proprietaireId:number;
  
    @ApiProperty({required:true})
    @IsNumber()
    @Min(1, {message: "L'identifiant de la vehicule est invalide"})
    vehiculeId: number;
}


export class CreateProprietaireDto {
    @ApiProperty({required:true})
    @IsDate({message:"La date de début est obligatoir pour le champs date debut", always:true})
    date_debut: Date = new Date();

    @ApiProperty({required:true})
    @IsDate()
    date_fin: Date;

    @ApiProperty({required:true})
    @IsNumber()
    @Min(1, {message: "L'identifiant du proprietaire est invalide"})
    proprietaireId:number;
}
