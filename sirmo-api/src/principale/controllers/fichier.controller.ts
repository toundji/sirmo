/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Req, Res } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { Fichier } from '../entities/fichier.entity';
import { User } from '../entities/user.entity';
import { FichierService } from '../services/fichier.service';

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

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.fichierService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() fichier: Fichier) {
    return this.fichierService.edit(+id, fichier);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.fichierService.remove(+id);
  }
}
