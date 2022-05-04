/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { CreateLocalisationDto } from '../createDto/create-localisation.dto';
import { Localisation } from '../entities/localisation.entity';
import { LocalisationService } from '../services/localisation.service';

@ApiTags("Localisations")
@Controller('localisations')
export class LocalisationController {
  constructor(private readonly localisationService: LocalisationService) {}

  @Post()
  create(@Body() createLocalisationDto: CreateLocalisationDto) {
    return this.localisationService.create(createLocalisationDto);
  }

  @Get()
  findAll() {
    return this.localisationService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.localisationService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() localisation: Localisation) {
    return this.localisationService.update(+id, localisation);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.localisationService.remove(+id);
  }
}
