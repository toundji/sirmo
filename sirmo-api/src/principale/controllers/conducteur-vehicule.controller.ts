/* eslint-disable prettier/prettier */
import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from "@nestjs/common";
import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
import { CreateConducteurVehiculeDto } from "../createDto/create-conducteur-vehicule.dto";
import { ConducteurVehicule } from "../entities/conducteur-vehicule.entity";
import { ConducteurVehiculeService } from "../services/conducteur-vehicule.service";

@ApiTags("ConducteurVehicules")
@ApiBearerAuth("token")
@Controller("conducteurVehicules")
export class ConducteurVehiculeController {
  constructor(private readonly conducteurVehiculeService: ConducteurVehiculeService) {}

  @Post()
  create(@Body() createConducteurVehiculeDto: CreateConducteurVehiculeDto) {
    return this.conducteurVehiculeService.create(createConducteurVehiculeDto);
  }

  @Get()
  findAll() {
    return this.conducteurVehiculeService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.conducteurVehiculeService.findOne(+id);
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() updateConducteurVehiculeDto: ConducteurVehicule) {
    return this.conducteurVehiculeService.update(+id, updateConducteurVehiculeDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.conducteurVehiculeService.remove(+id);
  }
}
