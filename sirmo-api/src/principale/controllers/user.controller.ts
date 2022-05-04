/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, Put, UseGuards, SetMetadata, Req, UseInterceptors, UploadedFile } from '@nestjs/common';
import { UserService } from '../services/user.service';
import { CreateUserDto } from '../createDto/create-user.dto';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { User } from '../entities/user.entity';
import { RoleName } from 'src/enums/role-name';
import { Roles } from '../role.decorator';
import { RoleGuard } from 'src/principale/role.guard';
import { JwtAuthGuard } from './../../auth/jwt-auth.guard';
import { editFileName, imageFileFilter } from '../utilis/utils';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';



@ApiTags("Users")
@Controller('users')
@UseGuards(JwtAuthGuard, RoleGuard)
export class UserController {
  constructor(private readonly userService: UserService) {}

  @ApiOkResponse({type:User})
  @Post()
  async create(@Body() createUserDto: CreateUserDto) {
    return await this.userService.create(createUserDto);
  }

  @ApiOkResponse({type:User})
  @Post("with/image")
  @UseInterceptors(
    FileInterceptor('profile', {
      storage: diskStorage({
        destination: './files/profiles',
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  async createWithProfile(@UploadedFile() profile ,@Body() createUserDto: CreateUserDto) {
    return await this.userService.createWithProfile(createUserDto, profile);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN)
  @ApiOkResponse({type:User, isArray:true})
  @Get()
  findAll() {
    return this.userService.findAll();
  }

  @ApiOkResponse({type:User})
  @Get(':id')
  findOne(@Param('id') id: number) {
    return this.userService.findOne(+id);
  }

 
  @ApiOkResponse({type:User})
  @Get('my/info')
  findOneMyInfo(@Req() request) {
    const user: User = request.user;
    return this.userService.findOne(user.id);
  }

  @ApiOkResponse({type:User})
  @Put(':id')
  change(@Param('id') id: number, @Body() updateUserDto: User) {
    return this.userService.change(+id, updateUserDto);
  }

  @ApiOkResponse({type:User})
  @Patch(':id')
  update(@Param('id') id: number, @Body() updateUserDto: User) {
    return this.userService.change(+id, updateUserDto);
  }

  @ApiOkResponse({type:User})
  @Get("password/hash")
  updateAll() {
    return this.userService.updateAll();
  }

  @ApiOkResponse({type:User})
  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.userService.remove(+id);
  }

  @ApiOkResponse({type:User})
  @Post(":id")
  @UseInterceptors(
    FileInterceptor('profile', {
      storage: diskStorage({
        destination: './files/profiles',
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  updateProfile(@UploadedFile() profile, @Param('id') id: number, @Req() request,){
    
    const user: User = request.user;
    return this.userService.updateProfile(+id, profile, user);
  }
}




