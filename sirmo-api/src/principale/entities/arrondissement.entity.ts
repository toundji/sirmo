/* eslint-disable prettier/prettier */
import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Commune } from './commune.entity';

@Entity()
export class Arrondissement {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  nom: string;

  @JoinColumn({ name: 'commune_id' })
  @ManyToOne(type => Commune, (commune) => commune.arrondissements, {nullable:false})
  commune?: Commune;
}
