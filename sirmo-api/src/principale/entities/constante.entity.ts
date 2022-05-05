/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { Audit } from './audit';
import { User } from './user.entity';

@Entity("constantes")
export class Constante extends Audit {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false})
  nom: string;

  @Column({ nullable: false, unique: true })
  valeur: string;

  @Column({ nullable: false})
  description: string;

}
