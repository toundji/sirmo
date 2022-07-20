/* eslint-disable prettier/prettier */
import {
    Controller,
  
    Post,
    Body,
    
    Param,
    Delete,
   
  } from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { CreateVehiculeByConducteurDto } from 'src/principale/createDto/vehicule-by-conducteur.dto';
import { CreateVehiculeDto } from 'src/principale/createDto/vehicule.dto';
import { Vehicule } from 'src/principale/entities/vehicule.entity';
import { VehiculeAdminService } from '../services/vehicule-admin.service';
  
  
  @ApiTags('Admin Vehicule')
  @ApiBearerAuth("token")
  @Controller('admin/vehicules')
  export class VehiculeAdminController {
    constructor(private readonly vehiculesService: VehiculeAdminService) {}
  
    @Post()
    create(@Body() createVehiculeDto: CreateVehiculeByConducteurDto):Promise<Vehicule> {
      return this.vehiculesService.createByConducteur(createVehiculeDto);
    }
  
    // @Get(':id')
    // findOne(@Param('id') id: number):Promise<Vehicule> {
    //   return this.vehiculesService.findOne(+id);
    // }

    // @Put(':id')
    // edit(@Param('id') id: number, @Body() updateVehiculeDto: Vehicule):Promise<Vehicule> {
    //   return this.vehiculesService.edit(+id, updateVehiculeDto);
    // }
  
    @Delete(':id')
    remove(@Param('id') id: number) {
      return this.vehiculesService.remove(+id);
    }
  }
  