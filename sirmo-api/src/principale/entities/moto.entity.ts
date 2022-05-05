/* eslint-disable prettier/prettier */
import { EtatMoto } from 'src/enums/etat-moto';
import { User } from 'src/principale/entities/user.entity';
import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  JoinColumn,
  ManyToOne,
  OneToMany,
  ManyToMany,
  JoinTable,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Audit } from './audit';
import { Fichier } from './fichier.entity';
import { ProprietaireMoto } from './proprietaire-moto.entity';
import { ZemMoto } from './zem-moto.entity';
import { Zem } from './zem.entity';

@Entity()
export class Moto extends Audit {
  static entityName  = "moto";


  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false, unique: true })
  matricule: string;

  @Column({ nullable: false, unique: true })
  carteGrise: string;

  @Column({ nullable: false, unique: true })
  chassis: string;

  @Column({ nullable: false, unique: true })
  serie: string;

  @Column({ default: EtatMoto.OCASION, nullable: false })
  etat: EtatMoto;

  @ManyToOne((type) => User)
  @JoinColumn({ name: 'proprietaire_id' })
  proprietaire: User;

  @ManyToOne((type) => Zem)
  @JoinColumn({ name: 'zem_id'})
  zem: Zem;

  // @OneToMany(type => ZemMoto, zemMoto => zemMoto.zem)
  // zemMotos?: ZemMoto[];

  @OneToMany(type => ProprietaireMoto, prprietaireMoto => prprietaireMoto.moto)
  proprietaireMotos?: ProprietaireMoto[];

  
  @JoinColumn({ name: 'fichier_id' , })
  @ManyToOne(type => Fichier, {eager:true})
  image: Fichier;

  @ManyToMany(type=>Fichier)
  @JoinTable({
    name: 'motos_images',
    joinColumn: { name: 'moto_id', referencedColumnName: 'id'},
    inverseJoinColumn: { name: 'fichier_id', referencedColumnName: 'id'},
  })
  images?: Fichier[];


}
