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
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Compte } from './compte.entity';

@Entity()
export class Payement {
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


  @Column()
  createur_id:number;

  
  @Column()
  editeur_id: number;

  @CreateDateColumn()
  create_at:Date;

  @UpdateDateColumn()
  update_at:Date;


}
