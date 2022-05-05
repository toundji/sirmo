/* eslint-disable prettier/prettier */
import { Moto } from "src/principale/entities/moto.entity";
import { User } from "src/principale/entities/user.entity";
import { Column, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Entity } from "typeorm/decorator/entity/Entity";
import { CreateDateColumn } from 'typeorm';
import { Audit } from "./audit";


@Entity("proprietaires_motos")
export class ProprietaireMoto extends Audit{
  static entityName  = "proprietaires_motos";

  @PrimaryGeneratedColumn()
  id: number;

 

  @ManyToOne((type) => User, {nullable:false})
  @JoinColumn({ name: 'proprietaire_id'})
  proprietaire:User;

  @ManyToOne((type) => Moto,  {nullable:false})
  @JoinColumn({ name: 'moto_id' })
  moto:Moto;

  @Column({ nullable: false, default: ()=>'NOW()'})
  date_debut: Date ;

  @Column()
  date_fin: Date;

  

  static fromMap({proprietaire, moto, date_debut, date_fin, ...res }):ProprietaireMoto{
    const pm: ProprietaireMoto= new ProprietaireMoto();
    pm.date_debut = date_debut;
    pm.date_fin = date_fin,
    pm.proprietaire = proprietaire;
    pm.moto = moto;
    pm.createur_id = res["createur_id"];
    pm.editeur_id = res["editeur_id"];
    return pm;
  }
}
