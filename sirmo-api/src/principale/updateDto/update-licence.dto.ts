import { PartialType } from "@nestjs/swagger";
import { CreateLicenceDto } from "../createDto/create-licence.dto";

export class UpdateLicenceDto extends PartialType(CreateLicenceDto) {}
