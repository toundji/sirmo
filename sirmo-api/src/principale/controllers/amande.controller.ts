/* eslint-disable prettier/prettier */
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
import { AmandeService } from "../services/amande.service";
import { CreateAmandeDto } from "../createDto/create-amande.dto";
import { ApiTags } from "@nestjs/swagger";
import { Amande } from "../entities/amande.entity";
import { JwtAuthGuard } from "src/auth/jwt-auth.guard";
import { RoleGuard } from "../role.guard";
import { User } from "../entities/user.entity";

@ApiTags("Amandes")
@Controller("amandes")
export class AmandeController {
  constructor(private readonly amandeService: AmandeService) {}

  @Post()
  create(@Body() createAmandeDto: CreateAmandeDto,  @Req() request) {
    const user: User = request.user;

    return this.amandeService.create(createAmandeDto, user);
  }

  @Get()
  findAll() {
    return this.amandeService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: string) {
    return this.amandeService.findOne(+id);
  }

  @Patch(":id")
  update(@Param("id") id: string, @Body() amande: Amande) {
    return this.amandeService.update(+id, amande);
  }

  @Delete(":id")
  remove(@Param("id") id: string) {
    return this.amandeService.remove(+id);
  }
}
