/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsEmail, IsEnum, IsNotEmpty, IsNumber, IsOptional, IsPhoneNumber, IsPositive, IsString } from "class-validator";
import { Genre } from 'src/enums/genre';
import { RoleName } from 'src/enums/role-name';

export class CreateUserWithRoleDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    nom: string;

    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    prenom: string;

    @ApiProperty({required:true, default: Genre.MASCULIN})
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
    @IsEnum(RoleName,{each:true})
    roles?: RoleName[];
}

function AppState(AppState: any) {
    throw new Error("Function not implemented.");
}

