/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, Put, UseGuards, SetMetadata, Req, UseInterceptors, UploadedFile } from '@nestjs/common';
import { UserService } from '../services/user.service';
import { CreateUserDto } from '../createDto/create-user.dto';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';
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



@ApiTags("Users")
@Controller('users')

@UseGuards(JwtAuthGuard, RoleGuard)
export class UserController {
  constructor(private readonly userService: UserService, private readonly authService: AuthService) {}

  @ApiOkResponse({type:User})
  @ApiBearerAuth("token")
  @Post()
  async create(@Body() createUserDto: CreateUserDto) {
    return await this.userService.create(createUserDto);
  }


  @Public()
  @Post("register")
  async register(@Body() body: CreateUserDto):Promise<LoginRespo> {
     await this.userService.create(body);
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
  updateProfile(@UploadedFile() profile, @Param('id') id: number, @Req() request,):Promise<User> {
    const user: User = request.user;
    return this.userService.updateProfile(+id, profile, user);
  }
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




