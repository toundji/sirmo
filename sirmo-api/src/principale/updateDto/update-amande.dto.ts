/* eslint-disable prettier/prettier */
import { PartialType } from "@nestjs/swagger";
import { CreateAmandeDto } from "../createDto/create-amande.dto";

export class UpdateAmandeDto extends PartialType(CreateAmandeDto) {}
