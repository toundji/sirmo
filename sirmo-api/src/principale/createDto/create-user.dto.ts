/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { Transform, Type } from "class-transformer";
import { IsArray, IsBoolean, IsNotEmpty, IsNumber, IsPhoneNumber, IsPositive, IsString, Length } from "class-validator";



/* eslint-disable prettier/prettier */
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
    @IsString()
    email: string;

    @ApiProperty()
    @IsString()
    date_naiss:Date;

    @ApiProperty({required:true})
    @IsPhoneNumber("BJ")
    tel: string;

    @ApiProperty({isArray:true, })
    @IsNotEmpty({each:true})
    @IsNumber({},{each: true})
    roles:number[];

    @ApiProperty({required:true})
    @IsNumber()
    @IsPositive()
    arrondissement: number;
}

