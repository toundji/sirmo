/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseGuards, Req } from '@nestjs/common';
import { CreatePoliceDto } from '../createDto/create-police.dto';
import { PoliceService } from '../services/police.service';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { Police } from '../entities/police.entity';
import { CreatePoliceWithUserDto } from './../createDto/create-user-police.dto';
import { Roles } from '../role.decorator';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { RoleGuard } from '../role.guard';
import { RoleName } from 'src/enums/role-name';
import { User } from '../entities/user.entity';

@ApiTags("Police")
@ApiBearerAuth("token")
@Controller('polices')
export class PoliceController {
  constructor(private readonly policeService: PoliceService) {}

  @Post()
  create(@Body() createPoliceDto: CreatePoliceWithUserDto) {
    return this.policeService.create(createPoliceDto);
  }

  @Post("for/user")
  createFroUser(@Body() createPoliceDto: CreatePoliceDto) {
    return this.policeService.createForUser(createPoliceDto);
  }

  
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.POLICE)
  @Get("my/info")
  findOneMyInfo(@Req() request) {
    const user: User = request.user;
    return this.policeService.findOne(user.id);
  }


  @Get()
  findAll() {
    return this.policeService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: number) {
    return this.policeService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: number, @Body() police: Police) {
    return this.policeService.change(+id, police);
  }

  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.policeService.remove(+id);
  }
}
