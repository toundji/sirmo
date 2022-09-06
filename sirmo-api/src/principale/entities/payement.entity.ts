/* eslint-disable prettier/prettier */
import { TypeOptions } from 'class-transformer';
import { EtatVehicule } from 'src/enums/etat-vehicule';
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

  //SOLDE APRES L'OPERATION
  @Column()
  solde:number;

  @Column()
  type:TypePayement

  @Column({nullable:true})
  info: string

  @Column()
  operation:TypeOperation

  @ManyToOne((type) => Compte)
  @JoinColumn({ name : 'compte_id' })
  compte: Compte;
  
  @Column({nullable:true, name: "entity_name"})
   entityName: string;

   @Column({nullable:true, name: "entity_id"})
   entityId: number;

  }
