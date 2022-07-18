/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ArrondissementService } from '../services/arrondissement.service';
import { CreateArrondissementDto } from '../createDto/create-arrondissement.dto';
import { UpdateArrondissementDto } from '../updateDto/update-arrondissement.dto';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';


@ApiTags("Arrondissements")
@ApiBearerAuth("token")
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
  findOne(@Param('id') id: number) {
    return this.arrondissementService.findOne(+id);
  }

  @Get('by-name/:name')
  findByName(@Param('name') name: string) {
    return this.arrondissementService.findByName(name);
  }


  @Patch(':id')
  update(@Param('id') id: number, @Body() updateArrondissementDto: UpdateArrondissementDto) {
    return this.arrondissementService.update(+id, updateArrondissementDto);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.arrondissementService.remove(+id);
  }
}
