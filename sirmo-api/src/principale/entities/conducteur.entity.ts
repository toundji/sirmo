/* eslint-disable prettier/prettier */
import { BeforeInsert, Column, Entity, Index, JoinColumn, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId, UpdateDateColumn } from 'typeorm';
import { Licence } from './licence.entity';
import { Vehicule } from './vehicule.entity';
import { Appreciation } from './appreciation.entity';
import { Amande } from './amande.entity';
import { ConducteurVehicule } from './conducteur-vehicule.entity';
import { User } from './user.entity';
import { Audit } from './audit';
import { StatutConducteur } from 'src/enums/statut-zem copy';
import { Mairie } from './mairie.entity';



@Entity("conducteurs")
export class Conducteur extends Audit {
  static entityName  = "conducteurs";

  @PrimaryGeneratedColumn()
  id: number;

  @OneToOne((type) => User, { nullable:false, eager:true})
  @JoinColumn({ name: 'conducteur_id'})
  user:User;

  @Column({ nullable: false })
  ifu: string;

  @Column({nullable:true})
  date_delivrance_ifu: Date;

  @Column({ nullable: true,})
  cip: string;

  @Column({ nullable: true,  })
  nip: string;

  @Column({ nullable: true, })
  @Index({ unique: true, where: "nic IS NOT NULL" })
  nic: string;

  @Column({nullable:true})
  idCarde: string;

  @Column({ unique: true })
  permis: string;

  @Column({nullable:true})
  date_optention_permis: Date;

  @Column({ default: StatutConducteur.ACTIF, nullable: false })
  statut: StatutConducteur;

  @Column({ nullable: false })
  ancienIdentifiant: string;

  //licence en cours
  @ManyToOne((type) => Licence,
   { nullable:true, eager:true })
  @JoinColumn({ name: 'licence_id'})
  licence?:Licence;

  @JoinColumn({ name: 'mairie_id' })
  @ManyToOne((type) => Mairie, {nullable:false, eager:true})
  mairie: Mairie;

  @ManyToOne((type) => Vehicule, vehicule=>vehicule.conducteur, { nullable:true})
  @JoinColumn({ name: 'vehicule_id'})
  vehicule?:Vehicule;

  @OneToMany(type => Licence, licence => licence.conducteur)
  licences?: Licence[];

  // List des anciens vehicules conduit
  @OneToMany(type => ConducteurVehicule, conducteurVehicule => conducteurVehicule.conducteur)
  conducteurVehicules?: ConducteurVehicule[];


  @OneToMany(type => Appreciation, appreciation  => appreciation.conducteur)
  appreciations?: Appreciation[];

  @OneToMany(type => Amande, amande  => amande.conducteur )
  amandes?: Amande[];

  @Column({ nullable: true, unique:false })
  profile_image: string;

  @Column({ nullable: true,  unique:false  })
  idCarde_image: string;

  
  @BeforeInsert()  async generateNiz() {
    const t = new Date();
    const date = ('0' + t.getDate()).slice(-2);
    const month = ('0' + (t.getMonth() + 1)).slice(-2);
    const year = (''+t.getFullYear()).slice(-2);
    const hours = ('0' + t.getHours()).slice(-2);
    const minutes = ('0' + t.getMinutes()).slice(-2);
    const seconds = ('0' + t.getSeconds()).slice(-2);
    const dif = ("0"+Math.floor(Math.random() * (99 + 1))).slice(-2);
    const time = `${dif}${seconds}${minutes}${hours}${date}${month}${year}`;
    this.nic = time;
  }
}

