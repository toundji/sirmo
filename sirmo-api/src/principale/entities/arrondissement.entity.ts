/* eslint-disable prettier/prettier */
import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Commune } from './commune.entity';

@Entity("arrondissements")
export class Arrondissement {
  static  entityName  = "arrondissements";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  nom: string;

  @JoinColumn({ name: 'commune_id' })
  @ManyToOne(type => Commune, (commune) => commune.arrondissements, {nullable:false, eager:true})
  commune?: Commune;
}
