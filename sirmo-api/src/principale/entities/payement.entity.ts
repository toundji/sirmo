/* eslint-disable prettier/prettier */
import { TypeOptions } from 'class-transformer';
import { EtatMoto } from 'src/enums/etat-moto';
import { TypeOperation } from 'src/enums/type-operation';
import { TypePayement } from 'src/enums/type-payement';
import { User } from 'src/principale/entities/user.entity';
import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  JoinColumn,
  ManyToOne,
 
} from 'typeorm';
import { Audit } from './audit';
import { Compte } from './compte.entity';

@Entity("payements")
export class Payement extends Audit{
  static entityName  = "payements";

  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  montant:number;


  @Column()
  solde:number;

  @Column()
  type:TypePayement


  @Column()
  operation:TypeOperation

  @ManyToOne((type) => Compte)
  @JoinColumn({ name : 'compte_id' })
  compte: Compte;
}
