/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsString } from "class-validator";
import { Departement } from 'src/principale/entities/departement.entity';

export class CreateCommuneDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    nom:string;

    @ApiProperty({required:true})
    departement:Departement;
}
