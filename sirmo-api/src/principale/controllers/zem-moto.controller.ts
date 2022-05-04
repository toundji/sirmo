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
import { ApiTags } from "@nestjs/swagger";
import { CreateZemMotoDto } from "../createDto/create-zem-moto.dto";
import { ZemMoto } from "../entities/zem-moto.entity";
import { ZemMotoService } from "../services/zem-moto.service";
import { UpdateZemMotoDto } from "../updateDto/update-zem-moto.dto";

@ApiTags("ZemMotos")
@Controller("zemMotos")
export class ZemMotoController {
  constructor(private readonly zemMotoService: ZemMotoService) {}

  @Post()
  create(@Body() createZemMotoDto: CreateZemMotoDto) {
    return this.zemMotoService.create(createZemMotoDto);
  }

  @Get()
  findAll() {
    return this.zemMotoService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.zemMotoService.findOne(+id);
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() updateZemMotoDto: ZemMoto) {
    return this.zemMotoService.update(+id, updateZemMotoDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.zemMotoService.remove(+id);
  }
}
