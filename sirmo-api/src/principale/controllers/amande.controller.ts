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
import { RoleGuard } from "../role.guard";
import { User } from "../entities/user.entity";
import { Roles } from "../role.decorator";
import { RoleName } from "src/enums/role-name";

@ApiTags("Amandes")
@Controller("amandes")
export class AmandeController {
  constructor(private readonly amandeService: AmandeService) {}

  @Post()
  create(@Body() createAmandeDto: CreateAmandeDto,  @Req() request) {
    const user: User = request.user;

    return this.amandeService.create(createAmandeDto, user);
  }

  @Post("admin")
  @UseGuards(RoleGuard)
  @Roles(RoleName.ADMIN)
  createByAdmin(@Body() createAmandeDto: CreateAmandeDto,  @Req() request) {
    const user: User = request.user;
    return this.amandeService.createByAdmin(createAmandeDto, user);
  }

  @Get()
  findAll() {
    return this.amandeService.findAll();
  }

  @Get("conducteurs/:id")
  findAllForConducteur(@Param("id") id:number):Promise<Amande[]>{
    return this.amandeService.findAllForConducteur(id);
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
