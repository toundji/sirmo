/* eslint-disable prettier/prettier */
import { Controller, Get} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { SeederService } from './../services/seeder.service';

@ApiTags("Seeders")
@Controller('seeds')
export class SeedController {
    constructor(private readonly seederService: SeederService) {}


  @Get()
  async findOne() {
    return await this.seederService.seed();
  }

  @Get("grant-all-roles")
  async grant() {
    return await this.seederService.seed();
  }

}
