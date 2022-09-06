/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, Put, UseGuards, SetMetadata, Req, UseInterceptors, UploadedFile, Res } from '@nestjs/common';
import { UserService } from '../services/user.service';
import { CreateUserDto } from '../createDto/create-user.dto';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { User } from '../entities/user.entity';
import { RoleName } from 'src/enums/role-name';
import { Roles } from '../role.decorator';
import { RoleGuard } from 'src/principale/role.guard';
import { JwtAuthGuard } from './../../auth/jwt-auth.guard';
import { editFileName, imageFileFilter } from '../utilis/utils';
import { FileInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { BadRequestException } from '@nestjs/common';
import { Public } from 'src/auth/public-decore';
import { AuthService } from 'src/auth/services/auth/auth.service';
import { LoginRespo } from './../../auth/dto/login-respo.dto';
import { Fichier } from '../entities/fichier.entity';
import { CreateUserWithRoleDto } from '../createDto/create-user-with-role.dto';
import { Role } from '../entities/role.entity';
import { ChangePasswordDto } from './../createDto/change-password.dto';
import { ChangePhoneDto } from '../createDto/change-phone.dto';
import { ChangeEmailDto } from '../createDto/change-emeail.dto';
import { ProprietaireDto } from '../admin/dto/proprietaireDto';
import { NotFoundException } from '@nestjs/common';
import { ApiConstante } from '../utilis/api-constantes';
import { TokenDto } from '../createDto/token-dto';



@ApiTags("Users")
@Controller('users')

@UseGuards(JwtAuthGuard, RoleGuard)
export class UserController {
  constructor(private readonly userService: UserService, private readonly authService: AuthService) {}

  @ApiOkResponse({type:User})
  @ApiBearerAuth("token")
  @Post()
  @Roles(RoleName.ADMIN)
  async create(@Body() createUserDto: CreateUserWithRoleDto): Promise<User> {
    return await this.userService.create(createUserDto);
  }

  @Public()
  @Post("register")
  async register(@Body() body: CreateUserDto):Promise<LoginRespo> {
     await this.userService.register(body);
     return await this.authService.login({"username": body.phone, "password": body.password})
  }

  @ApiBearerAuth("token")
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN)
  @ApiOkResponse({type:User, isArray:true})
  @Get()
  findAll() {
    return this.userService.findAll();
  }

  @ApiBearerAuth("token")
  @Get(':id')
  findOne(@Param('id') id: number):Promise<User> {
    return this.userService.findOne(+id);
  }

  @ApiBearerAuth("token")
  @UseGuards(JwtAuthGuard)
  @Post("reset/token")
  resetToken(@Body() body: TokenDto, @Req() request):Promise<User> {
    const user: User = request.user;
    return this.userService.updateTokent(body.token, user);
  }

  @ApiBearerAuth("token")
  @Get('my/info')
  findMyInfo(@Req() request):Promise<User> {
    const user: User = request.user;
    return this.userService.findOne(user.id);
  }

  @ApiBearerAuth("token")
  @Put(':id')
  change(@Param('id') id: number, @Body() updateUserDto: User):Promise<User> {
    return this.userService.change(+id, updateUserDto);
  }

  @ApiBearerAuth("token")
  @Put('change/password')
  changePassword(@Req() request,  @Body() body: ChangePasswordDto):Promise<string> {
    const user: User = request.user;
    return this.userService.changePassword(body, user);
  }

  @ApiBearerAuth("token")
  @Put('change/phone')
  changePhone(@Req() request,  @Body() body: ChangePhoneDto):Promise<string> {
    const user: User = request.user;
    return this.userService.changePhone(body, user);
  }

  @ApiBearerAuth("token")
  @Put('change/email')
  changeEmail(@Req() request,  @Body() body: ChangeEmailDto):Promise<string> {
    const user: User = request.user;
    return this.userService.changeEmail(body, user);
  }

  @ApiBearerAuth("token")
  @Patch(':id')
  update(@Param('id') id: number, @Body() updateUserDto: User):Promise<User> {
    return this.userService.change(+id, updateUserDto);
  }

  @Public()
  @Get('check/available-email/:email')
  chackEmail(@Param('email')  email: string) {
    return this.userService.countByEmail(email).then((nber:number)=>{
      if(nber && nber>0){
        throw new  BadRequestException("L'adresse email n'est pas disponible");
      }
      return "L'adresse email est disponible";
    });
  }

  @Public()
  @Get('check/available-phone/:phone')
  chackPhone(@Param('phone') phone: string) {
    return this.userService.countByPhone(phone).then((nber:number)=>{
      if(nber && nber>0){
        throw new  BadRequestException("Le numéro de téléphone n'est pas disponible");
      }
      return "Le numéro de téléphone est disponible";
    });
  }

  @ApiBearerAuth("token")
  @ApiOkResponse({type:User})
  @Get("password/hash")
  updateAll() {
    return this.userService.updateAll();
  }

  @ApiBearerAuth("token")
  @Delete(':id')
  remove(@Param('id') id: number) {
    return this.userService.remove(+id);
  }

  @ApiBearerAuth("token")
  @Post("profile/image")
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema:{
      type: 'object',
      properties: {
        profile:{
          type: 'string',
          format: 'binary'
        }
      }
    }
  })
  @UseInterceptors(
    FileInterceptor('profile', {
      storage: diskStorage({
        destination: './files/profiles',
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  updateProfile(@UploadedFile() profile, @Req() request,):Promise<User> {
    const user: User = request.user;
    return this.userService.updateProfile(user.id, profile, user);
  }

  @ApiBearerAuth("token")
  @Post("profile/image/path")
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema:{
      type: 'object',
      properties: {
        profile:{
          type: 'string',
          format: 'binary'
        }
      }
    }
  })
  @UseInterceptors(
    FileInterceptor('profile', {
      storage: diskStorage({
        destination:  ApiConstante.profile_path,
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  updateProfilePath(@UploadedFile() profile, @Req() request):Promise<string> {
    const user: User = request.user;
    return this.userService.editUserProfilePath(user.id, profile);
  }


  @ApiBearerAuth("token")
  @ApiOkResponse({ schema:{
        type: 'string',
        format: 'binary'
      }
  })
  @UseGuards(JwtAuthGuard)
  @Get("profile/image")
  async myProfile(@Req() request, @Res() res){
    const user: User = request.user;
    if(user.profile_image){
      return res.sendFile(user.profile_image, { root: './' })
    }
    throw new NotFoundException("Vous définir votre photo de profile");
  }
}



function Host(arg0: string) {
  throw new Error('Function not implemented.');
}
// @ApiOkResponse({type:User})
// @Post("with/image")
// @UseInterceptors(
//   FileInterceptor('profile', {
//     storage: diskStorage({
//       destination: './files/profiles',
//       filename: editFileName,
//     }),
//     fileFilter: imageFileFilter,
//   }),
// )
// async createWithProfile(@UploadedFile() profile ,@Body() createUserDto: CreateUserDto) {
//   return await this.userService.createWithProfile(createUserDto, profile);
// }




