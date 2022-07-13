/* eslint-disable prettier/prettier */
import {
    Controller,
    Get,
    Post,
    Body,
    Patch,
    Param,
    Delete,
    Put,
    UseInterceptors,
    UploadedFile,
    Req,
  } from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { CreateVehiculeDto } from 'src/principale/createDto/vehicule.dto';
import { Vehicule } from 'src/principale/entities/vehicule.entity';
import { VehiculeAdminService } from '../services/vehicule-admin.service';
  
  
  @ApiTags('Admin Vehicule')
  @ApiBearerAuth("token")
  @Controller('admin/vehicules')
  export class VehiculeAdminController {
    constructor(private readonly vehiculesService: VehiculeAdminService) {}
  
    @Post()
    create(@Body() createVehiculeDto: CreateVehiculeDto):Promise<Vehicule> {
      return this.vehiculesService.create(createVehiculeDto);
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
  