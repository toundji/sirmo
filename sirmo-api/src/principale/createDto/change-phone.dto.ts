/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsOptional, IsPhoneNumber, IsString, MinLength } from "class-validator";

export class ChangePhoneDto {
  
    @ApiProperty()
  @IsPhoneNumber()
  @IsNotEmpty()
  @IsOptional()
  old: string;

  @ApiProperty({required:true})
  @IsPhoneNumber()
  @IsNotEmpty()
  nevel: string;
}
