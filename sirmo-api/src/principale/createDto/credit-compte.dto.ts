/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber, IsPositive, IsString, Min } from "class-validator";

export class CreditCompteDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    transactionId:string;

    @ApiProperty({required:true})
    @IsNumber()
    @IsPositive()
    @Min(500)
    montant:number;
}
