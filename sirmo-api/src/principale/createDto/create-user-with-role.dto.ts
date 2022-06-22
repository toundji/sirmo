/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsBoolean, IsEmail, IsEnum, IsNotEmpty, IsNumber, IsOptional, IsPhoneNumber, IsPositive, IsString, Length } from "class-validator";
import { Genre } from 'src/enums/genre';

export class CreateUserWithRoleDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    nom: string;

    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    prenom: string;

    @ApiProperty({required:true, default:Genre.MASCULIN})
    @IsEnum({entity:Genre})
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
    @IsOptional()
    date_naiss: Date;

    @ApiProperty({required:true})
    @IsPhoneNumber("BJ")
    phone: string;

    @ApiProperty({required:true})
    @IsNumber()
    @IsPositive()
    arrondissement: number;

    @ApiProperty({required:true})
    @IsNumber({},{each:true})
    @IsPositive({each:true})
    role_ids?: number[];
}

