/* eslint-disable prettier/prettier */
import {
    Controller,
    Get,
    Post,
    Body,
    Patch,
    Param,
    Delete,
  } from '@nestjs/common';
  import { CreatePayementDto } from '../createDto/create-payement.dto';
  import { PayementService } from '../services/payement.service';
  import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { Payement } from '../entities/payement.entity';
  
  @ApiTags('Payement')
  @ApiBearerAuth("token")
  @Controller('payements')
  export class PayementController {
    constructor(private readonly payementsService: PayementService) {}
  
    @Post()
    create(@Body() createPayementDto: CreatePayementDto) {
      return this.payementsService.create(createPayementDto);
    }
  
    @Get()
    findAll() {
      return this.payementsService.findAll();
    }
  
    @Get(':id')
    findOne(@Param('id') id: string) {
      return this.payementsService.findOne(+id);
    }
  
    @Patch(':id')
    update(@Param('id') id: string, @Body() updatePayementDto: Payement) {
      return this.payementsService.update(+id, updatePayementDto);
    }
  
    @Delete(':id')
    remove(@Param('id') id: string) {
      return this.payementsService.remove(+id);
    }
  }
  