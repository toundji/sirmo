/* eslint-disable prettier/prettier */
import {
    Controller,
    Get,
    Post,
    Body,
    Patch,
    Param,
    Delete,
    Req,
  } from '@nestjs/common';
  import { CreatePayementDto } from '../createDto/create-payement.dto';
  import { PayementService } from '../services/payement.service';
  import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { Payement } from '../entities/payement.entity';
import { PayConducteurDto } from './../createDto/pay-conducteur.dto';
import { User } from '../entities/user.entity';
  
  @ApiTags('Payement')
  @ApiBearerAuth("token")
  @Controller('payements')
  export class PayementController {
    constructor(private readonly payementsService: PayementService) {}
  
    @Post()
    create(@Body() createPayementDto: CreatePayementDto) {
      return this.payementsService.create(createPayementDto);
    }


    @Post("conducteur")
    payConducteur(@Body() body: PayConducteurDto, @Req() req ) {
      const user:User = req.user;
      return this.payementsService.payConducteur(user, body);
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
  