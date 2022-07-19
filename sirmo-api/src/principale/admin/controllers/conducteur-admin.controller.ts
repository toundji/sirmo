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
  import { ConducteurService } from "../../services/conducteur.service";
  import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
  import { Conducteur } from "../../entities/conducteur.entity";
  import { Roles } from "../../role.decorator";
  import { JwtAuthGuard } from "src/auth/jwt-auth.guard";
  import { RoleGuard } from "../../role.guard";
  import { RoleName } from "src/enums/role-name";
  import { StatutConducteur } from "src/enums/statut-zem copy";
  import { CreateUserConducteurCptDto } from '../dto/user-conducteur-cpt.dto';
import { UserConducteurDG_Dto } from "../dto/user-conducteur-dg.dto";
import { Public } from "src/auth/public-decore";
import { ConducteurAdminService } from "../services/conducteur-admin.service";

  @ApiTags("Admin Conducteurs")
  @ApiBearerAuth("token")
  @Controller("admin/conducteurs")
  export class ConducteurAdminController {
    constructor(private readonly conducteurService: ConducteurAdminService) {}

    // @UseGuards(JwtAuthGuard, RoleGuard)
    // @Roles(RoleName.ADMIN, RoleName.MAIRIE)
    @Post()
    @Public()
    createConducteur(@Body() body: CreateUserConducteurCptDto) : Promise<Conducteur| CreateUserConducteurCptDto>{
      return this.conducteurService.createConducteur(body);
    }

    @Post("update")
    @Public()
    updateConducteur(@Body() body: CreateUserConducteurCptDto) : Promise<Conducteur| CreateUserConducteurCptDto>{
      return this.conducteurService.updateConducteur(body);
    }

    @UseGuards(JwtAuthGuard, RoleGuard)
    @Roles(RoleName.ADMIN, RoleName.MAIRIE)
    @Post("with-vehicule")
    createConducteurWithVehiculeByDG(@Body() body: UserConducteurDG_Dto) : Promise<Conducteur>{
      return this.conducteurService.createByDG(body);
    }

    @Get("/status/:status")
    findAllByStatus(@Param("status") status: StatutConducteur,): Promise<Conducteur[]> {
      return this.conducteurService.findByStatus(status);
    }

    @Get('nic_or_nip/:nic')
    findOneByNic(@Param('nic') nic: string):Promise<CreateUserConducteurCptDto> {
      return this.conducteurService.findOneByCipOrNip(nic);
    }

    @Get(":id")
    findOne(@Param("id") id: number) : Promise<Conducteur>{
      return this.conducteurService.findOne(+id);
    }

    @UseGuards(JwtAuthGuard, RoleGuard)
    @Roles(RoleName.ADMIN, RoleName.MAIRIE)
    @Delete(":id")
    remove(@Param("id") id: number) {
      return this.conducteurService.remove(+id);
    }
  }
  