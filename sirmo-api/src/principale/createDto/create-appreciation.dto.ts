/* eslint-disable prettier/prettier */
import { TypeAppreciation } from "src/enums/type-appreciation";
import { IsNotEmpty, IsOptional, IsPhoneNumber, IsPositive, IsString } from 'class-validator';
import { IsNumber } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";

 export  class CreateAppreciationDto {

  @ApiProperty({required:true})
  @IsNotEmpty()
  typeAppreciation: TypeAppreciation;


  @ApiProperty({required:true})
  @IsNumber({allowNaN:false}, {message:"Le conducteur spécifié est inalide"})
  @IsPositive({message: "Le conducteur spécifié est inalide"})
  conducteur_id: number;

  
  @ApiProperty({required:true})
  @IsString()
  @IsNotEmpty()
  @IsOptional()
  message: string;

}
