/* eslint-disable prettier/prettier */
import {
    Controller,
    Get,
    Post,
    Body,
    Patch,
    Param,
    Delete,
  } from "@nestjs/common";
  import { AppreciationService } from "../services/appreciation.service";
  import { CreateAppreciationDto } from "../createDto/create-appreciation.dto";
  import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
  import { Appreciation } from "../entities/appreciation.entity";
  
  @ApiTags("Appreciations des Zems")
  @ApiBearerAuth("token")
  @Controller("appreciations")
  export class AppreciationController {
    constructor(private readonly appreciationService: AppreciationService) {}
  
    @Post()
    create(@Body() createAppreciationDto: CreateAppreciationDto) {
      return this.appreciationService.create(createAppreciationDto);
    }
  
    @Get()
    findAll() {
      return this.appreciationService.findAll();
    }
  
    @Get(":id")
    findOne(@Param("id") id: string) {
      return this.appreciationService.findOne(+id);
    }
  
    @Patch(":id")
    update(@Param("id") id: string, @Body() appreciation: Appreciation) {
      return this.appreciationService.update(+id, appreciation);
    }

    @Delete(":id")
    remove(@Param("id") id: string) {
      return this.appreciationService.remove(+id);
    }
  }