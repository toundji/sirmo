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
} from 'typeorm';
import { Audit } from './audit';
import { Fichier } from './fichier.entity';
import { ProprietaireMoto } from './proprietaire-moto.entity';
import { Zem } from './zem.entity';

@Entity("motos")
export class Moto extends Audit {
  static entityName  = "motos";


  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  immatriculation: string;

  @Column({ nullable: false })
  numero_carte_grise: string;

  @Column({ nullable: false})
  numero_chassis: string;

  @Column({ nullable: false })
  numero_serie_moteur: string;

  @Column({ nullable: false })
  provenance:string;

  @Column({ nullable: false })
  puissance:string;

  @Column({ nullable: false })
  energie:string;

  @Column({ nullable: false })
  annee_mise_circulation:Date;

  @Column({ nullable: false })
  derniere_revision:Date;

  @Column({ default: EtatMoto.OCASION, nullable: false })
  etat: EtatMoto;

  @Column({ nullable: true })
  marque:string;

  @Column({ nullable: true })
  modele:string;

  @Column({ nullable: true })
  type:string;

  @ManyToOne((type) => User)
  @JoinColumn({ name: 'proprietaire_id'})
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
