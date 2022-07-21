import { ApiProperty } from "@nestjs/swagger";
import { IsNumber, IsPositive } from "class-validator";


export class PayConducteurDto{
    @ApiProperty({required:true})
    @IsPositive()
    @IsNumber()
    conducteur_id:number;

    @ApiProperty({required:true})
    @IsPositive()
    @IsNumber()
    montant:number;
}