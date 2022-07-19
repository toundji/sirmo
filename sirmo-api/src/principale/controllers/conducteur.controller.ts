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
import { ConducteurService } from "../services/conducteur.service";
import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
import { Conducteur } from "../entities/conducteur.entity";
import { User } from "../entities/user.entity";
import { Roles } from "../role.decorator";
import { JwtAuthGuard } from "src/auth/jwt-auth.guard";
import { RoleGuard } from "../role.guard";
import { RoleName } from "src/enums/role-name";
import { CreateUserConducteurDto } from "../createDto/user-conducteur.dto";
import { CreateConducteurDto } from "../createDto/conducteur.dto";
import { StatutConducteur } from "src/enums/statut-zem copy";
import { CreateUserConducteurCptDto } from '../admin/dto/user-conducteur-cpt.dto';
import { Vehicule } from './../entities/vehicule.entity';

@ApiTags("Conducteurs")
@ApiBearerAuth("token")
@Controller("conducteurs")
export class ConducteurController {
  constructor(private readonly conducteurService: ConducteurService) {}

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN, RoleName.MAIRIE)
  @Post()
  create(@Body() createConducteurDto: CreateUserConducteurDto) {
    return this.conducteurService.create(createConducteurDto);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN, RoleName.MAIRIE)
  @Post("for/user")
  createUserConducteur(@Body() createConducteurDto: CreateConducteurDto) : Promise<Conducteur>{
    return this.conducteurService.createForUser(createConducteurDto);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Post("request/by/user")
  requestByUser(@Body() createConducteurDto: CreateConducteurDto, @Req() request): Promise<Conducteur> {
    const user: User = request.user;
    return this.conducteurService.requestByUser(createConducteurDto, user);
  }

  @Get()
  findAll() : Promise<Conducteur[]>{
    return this.conducteurService.findAll();
  }

  @Get("/status/:status")
  findAllByStatus(@Param("status") status: StatutConducteur,): Promise<Conducteur[]> {
    return this.conducteurService.findByStatus(status);
  }

  @Get('nics/:nic')
  findOneByNic(@Param('nic') nic: number):Promise<Conducteur> {
    return this.conducteurService.findOneByCipOrNip(+nic);
  }

  @Get(":id")
  findOne(@Param("id") id: number) : Promise<Conducteur>{
    return this.conducteurService.findOne(+id);
  }

  @Get(":id/vehicule")
  getVehicule(@Param("id") id: number) : Promise<Vehicule>{
    return this.conducteurService.getVehicule(+id);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.CONDUCTEUR)
  @Get("my/info")
  findOneMyInfo(@Req() request): Promise<Conducteur> {
    const user: User = request.user;
    return this.conducteurService.findActifForUser(user.id);
  }


  @UseGuards(JwtAuthGuard, RoleGuard)
  @Get("my/list")
  findConducteurOfUser(@Req() request): Promise<Conducteur[]> {
    const user: User = request.user;
    return this.conducteurService.findOfUser(user.id);
  }

  @Patch(":id")
  update(@Param("id") id: number, @Body() updateConducteurDto: Conducteur): Promise<Conducteur> {
    return this.conducteurService.update(id, updateConducteurDto);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN, RoleName.MAIRIE)
  @Put(":id")
  changed(@Param("id") id: number, @Body() updateConducteurDto: Conducteur): Promise<Conducteur> {
    return this.conducteurService.changed(id, updateConducteurDto);
  }

  @UseGuards(JwtAuthGuard, RoleGuard)
  @Roles(RoleName.ADMIN, RoleName.MAIRIE)
  @Delete(":id")
  remove(@Param("id") id: number) {
    return this.conducteurService.remove(+id);
  }
}
