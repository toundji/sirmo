import { PartialType } from "@nestjs/swagger";
import { CreateVehiculeDto } from "../createDto/vehicule.dto";

export class UpdateVehiculeDto extends PartialType(CreateVehiculeDto) {}
