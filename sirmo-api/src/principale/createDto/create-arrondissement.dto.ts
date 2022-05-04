/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger/dist";
import { IsNotEmpty, IsObject, IsString } from "class-validator";
import { Commune } from "src/principale/entities/commune.entity";

export class CreateArrondissementDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    nom:string;

    @ApiProperty({required:true})
    commune:Commune;
}
