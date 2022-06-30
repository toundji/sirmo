/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Req, Res, UseInterceptors, UploadedFile, UploadedFiles } from '@nestjs/common';
import { FileFieldsInterceptor, FileInterceptor } from '@nestjs/platform-express';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { Fichier } from '../entities/fichier.entity';
import { User } from '../entities/user.entity';
import { FichierService } from '../services/fichier.service';
import { editFileName, imageFileFilter, imageOrPdfFileFilter } from '../utilis/utils';
import { diskStorage } from 'multer';
import { Express } from 'multer';
import { response } from 'express';


@ApiTags("Fichiers")
@Controller('fichiers')
export class FichierController {
  constructor(private readonly fichierService: FichierService) {}

  @Post()
  create(@Body() createFichierDto: Fichier) {
    return this.fichierService.create(createFichierDto);
  }

  @Get()
  findAll() {
    return this.fichierService.findAll();
  }

  @UseGuards(JwtAuthGuard)
  @Get("profiles/me")
  myProfile(@Req() request, @Res() res) {
    const user: User=request.user;
    const file:Fichier = user.profile;
    return res.sendFile(file.path, { root: './' })
  }

  @ApiBearerAuth("token")
  @Post("zems/:id/files")
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema:{
      type: 'object',
      properties: {
        cip:{
          type: 'string',
          format: 'binary'
        },
        nip:{
          type: 'string',
          format: 'binary'
        },
        ifu:{
          type: 'string',
          format: 'binary'
        },
        idCarde:{
          type: 'string',
          format: 'binary'
        },
        certificatRoute:{
          type: 'string',
          format: 'binary'
        }
      }
    }
  })
  @UseInterceptors(
    FileFieldsInterceptor([
      {name: 'ifu', maxCount: 1},
      {name: 'cip', maxCount: 1},
      {name: 'nip', maxCount: 1},
      {name: 'idCarde', maxCount: 1},
      {name: 'certificatRoute', maxCount: 1}
    ],{
      storage: diskStorage({
        destination: './files/zems-files',
        filename: editFileName,
      }),
      fileFilter: imageOrPdfFileFilter,
    }),
  )
  @ApiOkResponse({ schema:{
    type: 'string',
    format: 'binary'
  }
})
  updateProfile(
    @Param('id') id: number,
      @UploadedFiles() files: Array<Express.Multer.File>,
      @Req() request){
    const user: User = request.user;
    console.log(files);
    return  this.fichierService.createZemFiles(id, files, user);
  }


  @Get(':id')
  async findOneMedia(@Param('id') id: number, @Res() res) {
    const file:Fichier = await this.fichierService.findOne(+id);
    return res.sendFile(file.path, { root: './' })

  }

  @Get('zems/:id/dossiers')
  async findZemDossier(@Param('id') id: number, @Res() res) {
    const files:Fichier[] = await this.fichierService.getZemFiles(+id);
    files.forEach((file)=>{
      res.sendFile(file.path, { root: './' })
    });
    return res;
  }

  @Get('zems/:id/dossiers/details')
   findZemDossierInfo(@Param('id') id: number):Promise<Fichier[]> {
    return this.fichierService.getZemFiles(+id);
   
  }

  @Get(':id/details')
  findOne(@Param('id') id: number) {
    return this.fichierService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: number, @Body() fichier: Fichier):Promise<Fichier>  {
    return this.fichierService.edit(+id, fichier);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.fichierService.remove(+id);
  }
}


