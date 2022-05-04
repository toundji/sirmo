/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ArrondissementService } from '../services/arrondissement.service';
import { CreateArrondissementDto } from '../createDto/create-arrondissement.dto';
import { UpdateArrondissementDto } from '../updateDto/update-arrondissement.dto';
import { ApiTags } from '@nestjs/swagger';


@ApiTags("Arrondissements")
@Controller('arrondissements')
export class ArrondissementController {
  constructor(private readonly arrondissementService: ArrondissementService) {}

  @Post()
  create(@Body() createArrondissementDto: CreateArrondissementDto) {
    return this.arrondissementService.create(createArrondissementDto);
  }

  @Get()
  findAll() {
    return this.arrondissementService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.arrondissementService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateArrondissementDto: UpdateArrondissementDto) {
    return this.arrondissementService.update(+id, updateArrondissementDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.arrondissementService.remove(+id);
  }
}
