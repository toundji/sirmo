import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  UseGuards,
  Req,
} from "@nestjs/common";
import { LicenceService } from "../services/licence.service";
import { CreateLicenceDto } from "../createDto/create-licence.dto";
import { ApiTags } from "@nestjs/swagger";
import { UpdateLicenceDto } from "../updateDto/update-licence.dto";
import { JwtAuthGuard } from "src/auth/jwt-auth.guard";
import { RoleGuard } from "../role.guard";
import { User } from "../entities/user.entity";

@UseGuards(JwtAuthGuard, RoleGuard)
@ApiTags("Licences des Zems")
@Controller("licences")
export class LicenceController {
  constructor(private readonly licenceService: LicenceService) {}

  @Post()
  create(@Body() createLicenceDto: CreateLicenceDto, @Req() request) {
    const user: User = request.user;

    return this.licenceService.create(createLicenceDto, user);
  }

  @Get()
  findAll() {
    return this.licenceService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.licenceService.findOne(+id);
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() updateLicenceDto: UpdateLicenceDto) {
    return this.licenceService.update(+id, updateLicenceDto);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.licenceService.remove(+id);
  }
}
