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
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { UpdateMotoDto } from '../updateDto/update-moto.dto';
import { Moto } from '../entities/moto.entity';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { editFileName, imageFileFilter } from '../utilis/utils';
import { User } from '../entities/user.entity';


@ApiTags('Moto')
@ApiBearerAuth("token")
@Controller('motos')
export class MotoController {
  constructor(private readonly motosService: MotoService) {}

  @Post()
  create(@Body() createMotoDto: CreateMotoDto) {
    return this.motosService.create(createMotoDto);
  }

  @Get()
  findAll() {
    return this.motosService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.motosService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateMotoDto: Moto) {
    return this.motosService.update(+id, updateMotoDto);
  }

  @Put(':id')
  edit(@Param('id') id: string, @Body() updateMotoDto: Moto) {
    return this.motosService.edit(+id, updateMotoDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.motosService.remove(+id);
  }

  @ApiOkResponse()
  @Post(":id/images")
  @UseInterceptors(
    FileInterceptor('motos', {
      storage: diskStorage({
        destination: './files/profiles',
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  updateProfile(@UploadedFile() profile, @Param('id') id: number, @Req() request,){
    const user: User = request.user;
    return this.motosService.updateImage(+id, profile, user);
  }
}
