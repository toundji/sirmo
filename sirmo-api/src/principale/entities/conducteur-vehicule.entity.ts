/* eslint-disable prettier/prettier */
import { Vehicule } from "src/principale/entities/vehicule.entity";
import { Column, CreateDateColumn, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Entity } from "typeorm/decorator/entity/Entity";
import { Audit } from "./audit";
import { User } from "./user.entity";
import { Conducteur } from "./conducteur.entity";


@Entity("conducteurs_vehicules")
export class ConducteurVehicule extends Audit{
  static entityName  = "conducteurs_vehicules";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false , default: ()=>'NOW()'})
  date_debut: Date ;

  @Column({nullable:true})
  date_fin: Date;

  @ManyToOne((type) => Conducteur,  {nullable:false})
  @JoinColumn({ name: 'conducteur_id'})
  conducteur:Conducteur;

  @ManyToOne((type) => Vehicule,  {nullable:false})
  @JoinColumn({ name: 'vehicule_id' })
  vehicule:Vehicule;

}
