/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, Put, UseGuards, SetMetadata, Req, UseInterceptors, UploadedFile, Res } from '@nestjs/common';
import { ApiBearerAuth, ApiOkResponse, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { AuthService } from 'src/auth/services/auth/auth.service';
import { RoleName } from 'src/enums/role-name';
import { ProprietaireDto } from 'src/principale/createDto/proprietaireDto';
import { User } from 'src/principale/entities/user.entity';
import { Roles } from 'src/principale/role.decorator';
import { RoleGuard } from 'src/principale/role.guard';
import { UserAdminService } from '../services/user-admin.service';

@ApiTags("Admin Users")
@Controller('admin/users')
@UseGuards(JwtAuthGuard, RoleGuard)
export class UserAdminController {
  constructor(private readonly userService: UserAdminService
) {}


  @ApiOkResponse({type:User})
  @ApiBearerAuth("token")
  @Post("proprietaire")
  @Roles(RoleName.ADMIN)
  async createProprietaire(@Body() createUserDto: ProprietaireDto): Promise<User> {
    return await this.userService.createOwner(createUserDto);
  }

 }

