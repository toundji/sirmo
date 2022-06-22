/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsBoolean, IsEmail, IsEnum, IsNotEmpty, IsNumber, IsOptional, IsPhoneNumber, IsPositive, IsString, Length } from "class-validator";
import { Genre } from 'src/enums/genre';

export class CreateUserDto {
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

    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    password: string;

    @ApiProperty()
    @IsEmail()
    @IsOptional()
    email: string;

    @ApiProperty()
    @IsString()
    date_naiss: Date;

    @ApiProperty({required:true})
    @IsPhoneNumber("BJ")
    phone: string;

    @ApiProperty({required:true})
    @IsNumber()
    @IsPositive()
    arrondissement: number;
}

