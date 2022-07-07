/* eslint-disable prettier/prettier */
import { Vehicule } from "src/principale/entities/vehicule.entity";
import { User } from "src/principale/entities/user.entity";
import { Column, JoinColumn, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { Entity } from "typeorm/decorator/entity/Entity";
import { Audit } from "./audit";


@Entity("proprietaires_vehicules")
export class ProprietaireVehicule extends Audit{
  static entityName  = "proprietaires_vehicules";

  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne((type) => User, {nullable:false})
  @JoinColumn({ name: 'proprietaire_id'})
  proprietaire:User;

  @ManyToOne((type) => Vehicule,  {nullable:false})
  @JoinColumn({ name: 'vehicule_id' })
  vehicule:Vehicule;

  @Column({ nullable: false, default: ()=>'NOW()'})
  date_debut: Date ;

  @Column({nullable: true})
  date_fin: Date;

  static fromMap({proprietaire, vehicule, date_debut, date_fin, ...res }):ProprietaireVehicule{
    const pm: ProprietaireVehicule= new ProprietaireVehicule();
    pm.date_debut = date_debut;
    pm.date_fin = date_fin,
    pm.proprietaire = proprietaire;
    pm.vehicule = vehicule;
    pm.createur_id = res["createur_id"];
    pm.editeur_id = res["editeur_id"];
    return pm;
  }
}
