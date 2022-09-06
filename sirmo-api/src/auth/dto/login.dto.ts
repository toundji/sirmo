/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsOptional, IsString } from "class-validator";

export class LoginDto {
  
  @ApiProperty({required:true})
  @IsNotEmpty()
  readonly username: string;

  @ApiProperty({required:true})
  @IsNotEmpty() 
  readonly password: string;

  @ApiProperty({required:true})
  @IsString()
  @IsNotEmpty()
  @IsOptional()
  readonly  token:string;
}
