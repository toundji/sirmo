/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsOptional, IsString, IsUppercase } from "class-validator";
import { ConstanteVisibility } from "src/enums/constante-visibility";
import { RoleName } from 'src/enums/role-name';

/* eslint-disable prettier/prettier */
export class CreateConstanteDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    nom:RoleName;
  
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    valeur: string;
  
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    visibilite:ConstanteVisibility;
  
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    @IsOptional()
    description: string;
}
