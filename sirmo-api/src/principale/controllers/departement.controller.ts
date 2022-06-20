/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { DepartementService } from '../services/departement.service';
import { CreateDepartementDto } from '../createDto/create-departement.dto';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { UpdateDepartementDto } from '../updateDto/update-departement.dto';
import { Public } from 'src/auth/public-decore';


@ApiTags("Departements")
@Controller('departements')
export class DepartementController {
  constructor(private readonly departementService: DepartementService) {}

  @ApiBearerAuth("token")
  @Post()
  create(@Body() createDepartementDto: CreateDepartementDto) {
    return this.departementService.create(createDepartementDto);
  }

  @Public()
  @Get()
  findAll() {
    return this.departementService.findAll();
  }

  @ApiBearerAuth("token")
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.departementService.findOne(+id);
  }

  @ApiBearerAuth("token")
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateDepartementDto: UpdateDepartementDto) {
    return this.departementService.update(+id, updateDepartementDto);
  }

  @ApiBearerAuth("token")
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.departementService.remove(+id);
  }

  @ApiBearerAuth("token")
  @Get('init/all')
  init() {
    return this.departementService.initDepComAr();
  }
}
