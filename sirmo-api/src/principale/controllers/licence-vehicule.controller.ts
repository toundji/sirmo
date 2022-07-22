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
  import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
  import { UpdateLicenceDto } from "../updateDto/update-licence.dto";
  import { JwtAuthGuard } from "src/auth/jwt-auth.guard";
  import { RoleGuard } from "../role.guard";
  import { User } from "../entities/user.entity";
import { LicenceVehiculeService } from "../services/licence-vehicule.service";
  
  @UseGuards(JwtAuthGuard, RoleGuard)
  @ApiTags("Licences des Véhicules")
  @ApiBearerAuth("token")
  @Controller("licences")
  export class LicenceVehiculeController {
    constructor(private readonly licenceService: LicenceVehiculeService) {}

    @Post()
    create(@Body() createLicenceDto: CreateLicenceDto, @Req() request) {
      const user: User = request.user;
      return this.licenceService.create(createLicenceDto, user);
    }

    @Post("admin")
    createByAdmin(@Body() createLicenceDto: CreateLicenceDto, @Req() request) {
      const user: User = request.user;
      return this.licenceService.createByAdmin(createLicenceDto, user);
    }

    @Post("fedapay")
    createByFedapay(@Body() createLicenceDto: CreateLicenceDto, @Req() request) {
      const user: User = request.user;
      return this.licenceService.createByFedapay(createLicenceDto, user);
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