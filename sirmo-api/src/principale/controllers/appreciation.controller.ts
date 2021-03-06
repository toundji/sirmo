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
import { ConducteurStat } from "../createDto/conducteur-statistque";

  
  @ApiTags("Appreciations des Conducteurs")
  @ApiBearerAuth("token")
  @Controller("appreciations")
  export class AppreciationController {
    constructor(private readonly appreciationService: AppreciationService) {}

    @Post()
    create(@Body() createAppreciationDto: CreateAppreciationDto, @Req() request):Promise<Appreciation>  {
      const user: User = request.user;
      return this.appreciationService.create(createAppreciationDto, user);
    }

    @Get()
    findAll(): Promise<Appreciation[]>  {
      return this.appreciationService.findAll();
    }

    @Get("conducteurs/:id")
    findAllForConducteur(@Param("id") id:number):Promise<Appreciation[]>{
      return this.appreciationService.findAllForConducteur(id);
    }

    @Get(":id")
    findOne(@Param("id") id: string): Promise<Appreciation> {
      return this.appreciationService.findOne(+id);
    }
    
    @Get("conducteurs/:id/statistiques")
    getStatistics(@Param("id") id: string): Promise<ConducteurStat> {
      return this.appreciationService.statistic(+id);
    }


  @ApiOkResponse()
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema:{
      type: 'object',
      properties: {
        image:{
          type: 'string',
          format: 'binary'
        },
      }
    }
  })
  @Post(":id/images")
  @UseInterceptors(
    FileInterceptor('image', {
      storage: diskStorage({
        destination: ApiConstante.appreciation_path,
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  updateProfile(@UploadedFile() image, @Param('id') id: number, @Req() request,){
    const user: User = request.user;
    return this.appreciationService.updateImage(+id, image, user);
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