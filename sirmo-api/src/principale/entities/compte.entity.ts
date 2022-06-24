/* eslint-disable prettier/prettier */
import {
  Column,
  Entity,
  JoinColumn,
  PrimaryColumn,
  RelationId,
} from 'typeorm';
import { OneToOne } from 'typeorm';
import { User } from './user.entity';
import { Audit } from './audit';


@Entity("comptes")
export class Compte extends Audit{
  static  entityName  = "comptes";


  @OneToOne((type) => User, {primary:true, nullable:false})
  @JoinColumn({ name: 'id'})
  user: User;

  @PrimaryColumn()
  @RelationId((compte: Compte) => compte.user)
  id: number;

  @Column()
  montant:number;

  
  @Column({default:0})
  total_in:number;
}