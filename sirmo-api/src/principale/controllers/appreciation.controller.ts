/* eslint-disable prettier/prettier */
import {
    Controller,
    Get,
    Post,
    Body,
    Patch,
    Param,
    Delete,
    UseInterceptors,
    UploadedFile,
    Req,
  } from "@nestjs/common";
  import { AppreciationService } from "../services/appreciation.service";
  import { CreateAppreciationDto } from "../createDto/create-appreciation.dto";
  import { ApiBearerAuth, ApiBody, ApiConsumes, ApiOkResponse, ApiTags } from "@nestjs/swagger";
  import { Appreciation } from "../entities/appreciation.entity";
import { FileInterceptor } from "@nestjs/platform-express";
import { editFileName, imageFileFilter } from "../utilis/utils";
import { User } from "../entities/user.entity";
import { diskStorage } from 'multer';
import { ApiConstante } from './../utilis/api-constantes';

  
  @ApiTags("Appreciations des Conducteurs")
  @ApiBearerAuth("token")
  @Controller("appreciations")
  export class AppreciationController {
    constructor(private readonly appreciationService: AppreciationService) {}

    @Post()
    create(@Body() createAppreciationDto: CreateAppreciationDto):Promise<Appreciation>  {
      return this.appreciationService.create(createAppreciationDto);
    }

    @Get()
    findAll(): Promise<Appreciation[]>  {
      return this.appreciationService.findAll();
    }

    @Get(":id")
    findOne(@Param("id") id: string): Promise<Appreciation> {
      return this.appreciationService.findOne(+id);
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
        destination: ApiConstante.appreciation_path,
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  updateProfile(@UploadedFile() vehicule_image, @Param('id') id: number, @Req() request,){
    const user: User = request.user;
    return this.appreciationService.updateImage(+id, vehicule_image, user, request.headers.origin);
  }
  
    @Patch(":id")
    update(@Param("id") id: string, @Body() appreciation: Appreciation) {
      return this.appreciationService.update(+id, appreciation);
    }

    @Delete(":id")
    remove(@Param("id") id: string) {
      return this.appreciationService.remove(+id);
    }
  }