/* eslint-disable prettier/prettier */
import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  Req,
} from "@nestjs/common";
import { CompteService } from "../services/compte.service";
import { ApiBearerAuth, ApiTags } from "@nestjs/swagger";
import { CreditCompteDto } from './../createDto/credit-compte.dto';
import { PayementService } from './../services/payement.service';
import { User } from "../entities/user.entity";
import { Compte } from "../entities/compte.entity";
import { Payement } from './../entities/payement.entity';

@ApiTags("comptes")
@ApiBearerAuth("token")
@Controller("comptes")
export class CompteController {
  constructor(private readonly compteService: CompteService,
    private readonly payementService: PayementService) {}

  @Post("of-me/recharger-par-kikiapay")
  create(@Body() body: CreditCompteDto, @Req() request):Promise<Payement> {
    const user: User = request.user;
    return this.compteService.recharger(body, user);
  }

  

  @Get("of-me")
  getOne( @Req() request):Promise<Compte> {
    const user: User = request.user;
    return this.compteService.findOne(user.id);
  }

  @Get("of-me/history")
  getHistory( @Req() request):Promise<Payement[]> {
    const user: User = request.user;
    return this.payementService.payementOf(user);
  }

  @Delete(":id")
  remove(@Param("id") id: number) {
    return this.compteService.remove(+id);
  }
}
