import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Put,
} from "@nestjs/common";
import { TypeAmandeService } from "../services/type-amande.service";
import { CreateTypeAmandeDto } from "../createDto/create-type-amande.dto";
import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
import { UpdateTypeAmandeDto } from "../updateDto/update-type-amande.dto";
import { TypeAmande } from "src/principale/entities/type-amande.entity";

@ApiTags("Les Types d'amandes")
@ApiBearerAuth("token")
@Controller("type-amandes")
export class TypeAmandeController {
  constructor(private readonly typeAmandeService: TypeAmandeService) {}

  @Post()
  create(@Body() createTypeAmandeDto: CreateTypeAmandeDto) {
    return this.typeAmandeService.create(createTypeAmandeDto);
  }

  @Post("all")
  createAll(@Body() createTypeAmandeDtos: CreateTypeAmandeDto[]) {
    return this.typeAmandeService.createAll(createTypeAmandeDtos);
  }

  @Get()
  findAll() {
    return this.typeAmandeService.findAll();
  }

  @Get(":id")
  findOne(@Param("id") id: number) {
    return this.typeAmandeService.findOne(+id);
  }

  @Put(":id")
  edit(@Param("id") id: number, @Body() typeAmande: TypeAmande) {
    return this.typeAmandeService.edit(id, typeAmande);
  }

  @Patch(":id")
  update(@Param("id") id: number, @Body() typeAmande: TypeAmande) {
    return this.typeAmandeService.update(id, typeAmande);
  }

  @Delete(":id")
  remove(@Param("id") id: number) {
    return this.typeAmandeService.remove(+id);
  }
}
