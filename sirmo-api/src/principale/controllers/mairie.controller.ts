import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Req,
  UseGuards,
  UseInterceptors,
  UploadedFile,
  Res,
} from "@nestjs/common";
import { CreateMairieDto } from "../createDto/create-mairie.dto";
import { MairieService } from "../services/mairie.service";
import { ApiBearerAuth, ApiOkResponse, ApiTags } from "@nestjs/swagger";
import { Mairie } from "../entities/mairie.entity";
import { Roles } from "../role.decorator";
import { RoleName } from "src/enums/role-name";
import { User } from "../entities/user.entity";
import { JwtAuthGuard } from "src/auth/jwt-auth.guard";
import { RoleGuard } from "../role.guard";
import { FileInterceptor } from "@nestjs/platform-express";

import { diskStorage } from "multer";
import { editFileName, imageFileFilter } from "../utilis/utils";
import { CreateLocalisationDto } from "./../createDto/create-localisation.dto";
import { ApiConstante } from './../utilis/api-constantes';

@ApiTags("Mairie")
@ApiBearerAuth("token")
@Controller("mairies")
export class MairieController {
  constructor(private readonly mairieService: MairieService) {}

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN)
  @Post()
  create(@Body() createMairieDto: CreateMairieDto, @Req() request) {
    const user: User = request.user;
    try {
      return this.mairieService.create(createMairieDto, user);
    } catch (e) {
      throw e;
    }
  }

  @Get()
  findAll() {
    return this.mairieService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: number) {
    return this.mairieService.findOne(+id);
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() mairie: Mairie) {
    return this.mairieService.update(+id, mairie);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.mairieService.remove(+id);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN)
  @ApiOkResponse({ type: Mairie })
  @Post(":id/images")
  @UseInterceptors(
    FileInterceptor("image", {
      storage: diskStorage({
        destination: ApiConstante.mairie_image_path,
        filename: editFileName,
      }),
      fileFilter: imageFileFilter,
    }),
  )
  updateProfile(
    @UploadedFile() image,
    @Param("id") id: number,
    @Req() request,
  ) {
    try {
      const user: User = request.user;

      return this.mairieService.updateProfile(+id, image, user);
    } catch (e) {
      throw e;
    }
  }

  @UseGuards(JwtAuthGuard)
  @Get(":id/image")
  async loadImage(@Param("id") id: number, @Res() res) {
    const mairie: Mairie = await this.mairieService.findOne(id);
    return res.sendFile(mairie.image_path, { root: "./" });
  }
  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN, RoleName.MAIRIE)
  @ApiOkResponse({ type: Mairie })
  @Post(":id/localisation")
  async setLocalisation(
    @Req() request,
    @Param("id") id: number,
    @Body() location: CreateLocalisationDto,
  ) {
    return await this.mairieService.updateLocalisation(id, location);
  }
}
