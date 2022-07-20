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
import { VehiculeService } from '../services/vehicule.service';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Vehicule } from '../entities/vehicule.entity';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { editFileName, imageFileFilter } from '../utilis/utils';
import { User } from '../entities/user.entity';
import { UpdateVehiculeByConducteurDto } from '../createDto/update-by-conducteur.dto';
import { CreateVehiculeDto } from '../createDto/vehicule.dto';
import { ApiConstante } from '../utilis/api-constantes';
import { CreateVehiculeByConducteurDto } from '../createDto/vehicule-by-conducteur.dto';


@ApiTags('Vehicule')
@ApiBearerAuth("token")
@Controller('vehicules')
export class VehiculeController {
  constructor(private readonly vehiculesService: VehiculeService) {}

  @Post()
  create(@Body() createVehiculeDto: CreateVehiculeDto):Promise<Vehicule> {
    return this.vehiculesService.create(createVehiculeDto);
  }

  @Post("by-conducteur")
  createByConducteur(@Body() createVehiculeDto: CreateVehiculeByConducteurDto):Promise<Vehicule> {
    return this.vehiculesService.createByConducteur(createVehiculeDto);
  }

  
  @Post("by-conducteur")
  updateByConducteur(@Body() createVehiculeDto: UpdateVehiculeByConducteurDto):Promise<Vehicule> {
    return this.vehiculesService.updateByConducteur(createVehiculeDto);
  }

  

  @Get()
  findAll():Promise<Vehicule[]> {
    return this.vehiculesService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: number):Promise<Vehicule> {
    return this.vehiculesService.findOne(+id);
  }

  

  @Patch(':id')
  update(@Param('id') id: number, @Body() updateVehiculeDto: Vehicule) {
    return this.vehiculesService.update(+id, updateVehiculeDto);
  }

  @Put(':id')
  edit(@Param('id') id: number, @Body() updateVehiculeDto: Vehicule):Promise<Vehicule> {
    return this.vehiculesService.edit(+id, updateVehiculeDto);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.vehiculesService.remove(+id);
  }

  @ApiOkResponse()
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema:{
      type: 'object',
      properties: {
        vehicule_image:{
          type: 'string',
          format: 'binary'
        },
      }
    }
  })
  @Post(":id/images")
  @UseInterceptors(
    FileInterceptor('vehicule_image', {
      storage: diskStorage({
        destination:  ApiConstante.vehicule_path,
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  updateProfile(@UploadedFile() vehicule_image, @Param('id') id: number, @Req() request,){
    const user: User = request.user;
    return this.vehiculesService.updateImage(+id, vehicule_image, user);
  }
}
