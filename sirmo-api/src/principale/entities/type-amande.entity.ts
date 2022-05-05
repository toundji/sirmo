/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Audit } from "./audit";
import { Fichier } from './fichier.entity';
import { User } from "./user.entity";

@Entity()
export class TypeAmande extends Audit{
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  nom: string;

  @Column()
  montant: number;

  @Column()
  description: string;

  @ManyToOne((type) => Fichier,{eager:true})
  @JoinColumn({ name: 'fichier_id' })
  document: Fichier;

}
