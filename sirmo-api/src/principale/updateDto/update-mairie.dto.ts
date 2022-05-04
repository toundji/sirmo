import { PartialType } from "@nestjs/swagger";
import { CreateMairieDto } from "../createDto/create-mairie.dto";

export class UpdateMairieDto extends PartialType(CreateMairieDto) {}
