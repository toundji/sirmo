/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import {  IsDate, IsDateString, IsEmail, IsEnum, IsNotEmpty,  IsOptional, IsPhoneNumber,  IsString, Length, Min } from "class-validator";
import { Genre } from 'src/enums/genre';

export class ProprietaireDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    nom: string;

    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    prenom: string;

    @ApiProperty({required:true, default:Genre.MASCULIN})
    @IsEnum(Genre)
    genre: Genre;

    @ApiProperty()
    @IsString()
    date_naiss: Date;

    @ApiProperty({required:true})
    @IsPhoneNumber("BJ")
    phone: string;

    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    arrondissement: string;


//     @ApiProperty({required:true})
//     @IsDateString({message:"La date de début est obligatoir pour le champs date debut", always:true})
//     date_debut: Date = new Date();
// 
//     @ApiProperty({required:true})
//     @IsDateString()
//     date_fin: Date;
}

