/* eslint-disable prettier/prettier */
import { Body, Controller, Get, Param, Post, Put } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { Public } from 'src/auth/public-decore';
import { ConstanteDto } from '../createDto/constante-search.dto';
import { Constante } from '../entities/constante.entity';
import { ConstanteService } from '../services/constante.service';

@Controller('constantes')
@ApiTags('constantes')
export class ConstanteController {
  constructor(private readonly constanteService: ConstanteService) {}

  @Post()
   createConstante(
    @Body() createConstanteDto: ConstanteDto,
  ): Promise<Constante> {
    return  this.constanteService.create(createConstanteDto);
  }

  @Get()
   getAll(): Promise<Constante[]> {
    return  this.constanteService.findAll();
  }

  @Put(':id')
   update(
    @Param('id') id: number,
    @Body() createConstanteDto: ConstanteDto,
  ): Promise<Constante> {
    return  this.constanteService.create(createConstanteDto);
  }

  @Public()
  @Post('search')
   search(@Body() body:ConstanteDto): Promise<Constante[]> {
    return  this.constanteService.search(body);
  }

  @Public()
  @Post('search-first')
   findFirst(@Body() body:ConstanteDto): Promise<Constante> {
    return  this.constanteService.searchFirst(body);
  }

    @Get("init")
    init():Promise<Constante[]>{
        return  this.constanteService.init();
    }
}
