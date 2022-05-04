/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber, IsObject, Min } from "class-validator";
import { IsString } from 'class-validator';
import { CreateLocalisationDto } from './create-localisation.dto';

export class CreateMairieDto {
    @ApiProperty({required:true})
    @IsString()
    nom: string;

    @ApiProperty({required:true})
    @IsString()
    adresse: string;

    @ApiProperty({required:true})
    @IsNotEmpty()
    @IsNumber()
    @Min(1, {message:"Arrondissement invalide"})
    arrondissementId: number;

    @ApiProperty()
    localisation?: CreateLocalisationDto;

}
