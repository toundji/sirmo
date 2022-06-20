/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsBoolean, IsEmail, IsNotEmpty, IsNumber, IsOptional, IsPhoneNumber, IsPositive, IsString, Length } from "class-validator";

export class CreateUserDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    nom: string;

    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    prenom: string;

    @ApiProperty({required:true})
    @IsBoolean({always:true})
    genre: boolean;

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

