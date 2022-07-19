/* eslint-disable prettier/prettier */
import { ApiProperty, PartialType } from "@nestjs/swagger";
import { IsNumber, IsPositive } from "class-validator";
import { CreateUserConducteurCptDto } from "../user-conducteur-cpt.dto";

export class UpdateUserConducteurCompacteDto extends PartialType(CreateUserConducteurCptDto) {
    
  
  @ApiProperty({required:true})
  @IsNumber()
  @IsPositive()
  id?: number;
}
