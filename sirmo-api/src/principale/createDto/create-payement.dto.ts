/* eslint-disable prettier/prettier */
import { IsNumber, IsPositive, Min } from "class-validator";
import { TypeOperation } from "src/enums/type-operation";
import { TypePayement } from "src/enums/type-payement";


export class CreatePayementDto{
  @IsNumber()
  @IsPositive()
  montant:number;

  type?:TypePayement

  operation?:TypeOperation

  @IsNumber()
  @IsPositive()
  compteId: number;

  @IsNumber()
  @IsPositive()
  payerParId: number;
}