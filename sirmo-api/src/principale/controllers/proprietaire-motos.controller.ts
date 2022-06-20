import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from "@nestjs/common";
import { ProprietaireMotosService } from "../services/proprietaire-motos.service";
import { CreateProprietaireMotoDto } from "../createDto/create-proprietaire-moto.dto";
import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
import { UpdateProprietaireMotoDto } from "../updateDto/update-proprietaire-moto.dto";

@ApiTags("Proprietaires de Motos")
@ApiBearerAuth("token")
@Controller("proprietaire-motos")
export class ProprietaireMotosController {
  constructor(
    private readonly proprietaireMotosService: ProprietaireMotosService,
  ) {}

  @Post()
  create(@Body() createProprietaireMotoDto: CreateProprietaireMotoDto) {
    return this.proprietaireMotosService.create(createProprietaireMotoDto);
  }

  @Get()
  findAll() {
    return this.proprietaireMotosService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.proprietaireMotosService.findOne(+id);
  }

  @Patch(":id")
  update(
    @Param("id") id: string,
    @Body() updateProprietaireMotoDto: UpdateProprietaireMotoDto,
  ) {
    return this.proprietaireMotosService.update(+id, updateProprietaireMotoDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.proprietaireMotosService.remove(+id);
  }
}
