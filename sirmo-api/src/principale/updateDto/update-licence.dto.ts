import { ApiProperty, PartialType } from "@nestjs/swagger";
import { IsDateString, IsNumber, IsOptional, IsPositive } from "class-validator";
import { CreateLicenceDto } from "../createDto/create-licence.dto";

export class UpdateLicenceDto extends PartialType(CreateLicenceDto) {
    @ApiProperty({required:true})
    @IsNumber()
    @IsPositive()
    @IsOptional()
    montant: number;
  
    @ApiProperty({required:false})
    @IsDateString()
    @IsOptional()
    dateDebut: Date;
    
    @ApiProperty({required:true})
    @IsDateString()
    @IsOptional()
    dateFin: Date;

}
