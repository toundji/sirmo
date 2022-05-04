/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { IsNotEmpty, IsString, IsUppercase } from "class-validator";
import { RoleName } from 'src/enums/role-name';

/* eslint-disable prettier/prettier */
export class CreateRoleDto {
    @ApiProperty({required:true})
    @IsString()
    @IsNotEmpty()
    @IsUppercase()
    nom:RoleName;
}
