import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsNumber, IsPositive, IsString } from "class-validator";


export class TokenDto{
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    token:string;
}