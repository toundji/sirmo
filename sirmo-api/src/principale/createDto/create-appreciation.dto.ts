/* eslint-disable prettier/prettier */
import { TypeAppreciation } from "src/enums/type-appreciation";
import { IsNotEmpty, IsPhoneNumber, IsString } from 'class-validator';
import { IsNumber } from 'class-validator';
import { ApiProperty } from "@nestjs/swagger";

 export  class CreateAppreciationDto {

  @ApiProperty({required:true})
  @IsNotEmpty()
  typeAppreciation: TypeAppreciation;

  @ApiProperty({required:true})
  @IsString()
  message: string;

  @ApiProperty({required:true})
  @IsPhoneNumber("BJ")
  tel: string;

  @ApiProperty({required:true})
  @IsNumber({allowNaN:false}, {message:"Zem spécifié est inalide"})
  zem_id: number;

}
