import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Put,
  UseGuards,
  Req,
} from "@nestjs/common";
import { ZemService } from "../services/zem.service";
import { CreateZemDto } from "../createDto/create-zem.dto";
import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
import { CreateUserZemDto } from "./../createDto/create-user-zem.dto";
import { Zem } from "../entities/zem.entity";
import { User } from "../entities/user.entity";
import { Roles } from "../role.decorator";
import { JwtAuthGuard } from "src/auth/jwt-auth.guard";
import { RoleGuard } from "../role.guard";
import { RoleName } from "src/enums/role-name";
import { StatutZem } from 'src/enums/statut-zem';

@ApiTags("Zems")
@ApiBearerAuth("token")
@Controller("zems")
export class ZemController {
  constructor(private readonly zemService: ZemService) {}

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN, RoleName.MAIRIE)
  @Post()
  create(@Body() createZemDto: CreateUserZemDto) {
    return this.zemService.create(createZemDto);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN, RoleName.MAIRIE)
  @Post("for/user")
  createUserZem(@Body() createZemDto: CreateZemDto) : Promise<Zem>{
    return this.zemService.createForUser(createZemDto);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Post("request/by/user")
  requestByUser(@Body() createZemDto: CreateZemDto, @Req() request): Promise<Zem> {
    const user: User = request.user;
    return this.zemService.requestByUser(createZemDto, user);
  }

  @Get()
  findAll() : Promise<Zem[]>{
    return this.zemService.findAll();
  }

  @Get("/status/:status")
  findAllByStatus(@Param("status") status: StatutZem,): Promise<Zem[]> {
    return this.zemService.findByStatus(status);
  }

  @Get(":id")
  findOne(@Param("id") id: number) : Promise<Zem>{
    return this.zemService.findOne(+id);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ZEM)
  @Get("my/info")
  findOneMyInfo(@Req() request): Promise<Zem> {
    const user: User = request.user;
    return this.zemService.findActifForUser(user.id);
  }

  @Patch(":id")
  update(@Param("id") id: number, @Body() updateZemDto: Zem): Promise<Zem> {
    return this.zemService.update(id, updateZemDto);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN, RoleName.MAIRIE)
  @Put(":id")
  changed(@Param("id") id: number, @Body() updateZemDto: Zem): Promise<Zem> {
    return this.zemService.changed(id, updateZemDto);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN, RoleName.MAIRIE)
  @Delete(":id")
  remove(@Param("id") id: number) {
    return this.zemService.remove(+id);
  }
}
