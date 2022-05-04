import { PartialType } from "@nestjs/swagger";
import { CreateMotoDto } from "../createDto/create-moto.dto";

export class UpdateMotoDto extends PartialType(CreateMotoDto) {}
