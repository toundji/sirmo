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
import { CreateMotoDto } from '../createDto/create-moto.dto';
import { MotoService } from '../services/moto.service';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { Moto } from '../entities/moto.entity';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { editFileName, imageFileFilter } from '../utilis/utils';
import { User } from '../entities/user.entity';
import { CreateMotoByZemDto } from './../createDto/create-moto-by-zem.dto';


@ApiTags('Moto')
@ApiBearerAuth("token")
@Controller('motos')
export class MotoController {
  constructor(private readonly motosService: MotoService) {}

  @Post()
  create(@Body() createMotoDto: CreateMotoDto):Promise<Moto> {
    return this.motosService.create(createMotoDto);
  }

  @Post("by-zem")
  createByZem(@Body() createMotoDto: CreateMotoByZemDto):Promise<Moto> {
    return this.motosService.createByZem(createMotoDto);
  }

  @Get()
  findAll():Promise<Moto[]> {
    return this.motosService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: number):Promise<Moto> {
    return this.motosService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: number, @Body() updateMotoDto: Moto) {
    return this.motosService.update(+id, updateMotoDto);
  }

  @Put(':id')
  edit(@Param('id') id: number, @Body() updateMotoDto: Moto):Promise<Moto> {
    return this.motosService.edit(+id, updateMotoDto);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.motosService.remove(+id);
  }

  @ApiOkResponse()
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema:{
      type: 'object',
      properties: {
        moto_image:{
          type: 'string',
          format: 'binary'
        },
      }
    }
  })
  @Post(":id/images")
  @UseInterceptors(
    FileInterceptor('moto_image', {
      storage: diskStorage({
        destination: './files/motos',
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  updateProfile(@UploadedFile() moto_image, @Param('id') id: number, @Req() request,){
    const user: User = request.user;
    return this.motosService.updateImage(+id, moto_image, user);
  }
}
