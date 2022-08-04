/* eslint-disable prettier/prettier */
import { EtatVehicule } from 'src/enums/etat-vehicule';
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
  Index,
} from 'typeorm';
import { Audit } from './audit';
import { Fichier } from './fichier.entity';
import { ProprietaireVehicule } from './proprietaire-vehicule.entity';
import { ConducteurVehicule } from './conducteur-vehicule.entity';
import { Conducteur } from './conducteur.entity';
import { LicenceVehicule } from './licence-vehicule.entity';

@Entity("vehicules")
export class Vehicule extends Audit {
  static entityName  = "vehicules";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: true })
  immatriculation: string;

  @Column({ nullable: true })
  @Index({ unique: true, where: "niv IS NOT NULL" })
  niv: string;

  @Column({ nullable: true })
  @Index({ unique: true, where: "niv IS NOT NULL" })
  ci_er: string;

  @Column({ nullable: true })
  commune_enregistrement: string;

  @Column({ nullable: true })
  numero_carte_grise: string;

  @Column({ nullable: true})
  numero_chassis: string;

  @Column({ nullable: true })
  numero_serie: string;

  @Column({ nullable: true })
  numero_serie_moteur: string;

  @Column({ nullable: true })
  provenance:string;

  @Column({ nullable: true })
  puissance:string;

  @Column({ nullable: true })
  carosserie:string;

  @Column({ nullable: true })
  categorie:string;

  @Column({ nullable: true })
  energie:string;

  @Column({ nullable: true })
  date_circulation:Date;

  @Column({ default: EtatVehicule.OCASION, nullable: true })
  etat: EtatVehicule;

  @Column({ nullable: true })
  marque:string;

  @Column({ nullable: true })
  modele:string;

  @Column({ nullable: true })
  type:string;

  @Column({ nullable: false, default:1 })
  place_assise:number;

  @Column({ nullable: true })
  couleur: string;

  @Column({ nullable: true })
  ptac: string;

  @Column({ nullable: true })
  pv: string;

  @Column({ nullable: true })
  cu: string;

  @ManyToOne((type) => User)
  @JoinColumn({ name: 'proprietaire_id'})
  proprietaire: User;

  @ManyToOne((type) => Conducteur)
  @JoinColumn({ name: 'conducteur_id'})
  conducteur: Conducteur;

  @ManyToOne((type) => LicenceVehicule,
  { nullable:true, eager:true})
  @JoinColumn({ name: 'licence_vehicule_id'})
  licence?:LicenceVehicule;

  @Column({ nullable: true })
  image_path: string;



  @OneToMany(type => LicenceVehicule, licence => licence.vehicule)
  licences?: LicenceVehicule[];

  @OneToMany(type => ConducteurVehicule, conducteurVehicule => conducteurVehicule.vehicule)
  conducteurVehicules?: ConducteurVehicule[];

  @OneToMany(type => ProprietaireVehicule, prprietaireVehicule => prprietaireVehicule.vehicule)
  proprietaireVehicules?: ProprietaireVehicule[];


  @ManyToMany(type=>Fichier)
  @JoinTable({
    name: 'vehicules_images',
    joinColumn: { name: 'vehicule_id', referencedColumnName: 'id'},
    inverseJoinColumn: { name: 'fichier_id', referencedColumnName: 'id'},
  })
  images?: Fichier[];


}
