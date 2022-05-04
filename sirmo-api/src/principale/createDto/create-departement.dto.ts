/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsString } from "class-validator";

export class CreateDepartementDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    nom:string;

}
