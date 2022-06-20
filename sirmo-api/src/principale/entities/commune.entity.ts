/* eslint-disable prettier/prettier */
import { ApiProperty } from '@nestjs/swagger';
import { Departement } from 'src/principale/entities/departement.entity';
import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { Arrondissement } from './arrondissement.entity';

@Entity("communes")
export class Commune {
  static  entityName  = "communes";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  nom: string;

  @JoinColumn({ name: 'departement_id' })
  @ManyToOne(type => Departement, (departement) => departement.communes, {nullable:false, eager:true})
  departement?: Departement;

  @OneToMany(type => Arrondissement, (arrondissement) => arrondissement.commune,)
  arrondissements?: Arrondissement[];
}
