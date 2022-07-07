import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from "@nestjs/common";
import { ProprietaireVehiculesService } from "../services/proprietaire-vehicule.service";
import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
import { CreateProprietaireVehiculeDto } from "../createDto/proprietaire-vehicule.dto";
import { UpdateProprietaireVehiculeDto } from "../updateDto/update-proprietaire-vehicule.dto";

@ApiTags("Proprietaires de Vehicules")
@ApiBearerAuth("token")
@Controller("proprietaire-vehicules")
export class ProprietaireVehiculesController {
  constructor(
    private readonly proprietaireVehiculesService: ProprietaireVehiculesService,
  ) {}

  @Post()
  create(@Body() createProprietaireVehiculeDto: CreateProprietaireVehiculeDto) {
    return this.proprietaireVehiculesService.create(createProprietaireVehiculeDto);
  }

  @Get()
  findAll() {
    return this.proprietaireVehiculesService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.proprietaireVehiculesService.findOne(+id);
  }

  @Patch(":id")
  update(
    @Param("id") id: string,
    @Body() updateProprietaireVehiculeDto: UpdateProprietaireVehiculeDto,
  ) {
    return this.proprietaireVehiculesService.update(+id, updateProprietaireVehiculeDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.proprietaireVehiculesService.remove(+id);
  }
}
