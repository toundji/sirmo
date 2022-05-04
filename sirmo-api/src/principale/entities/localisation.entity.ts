/* eslint-disable prettier/prettier */
import { CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Column } from "typeorm/decorator/columns/Column";
import { Arrondissement } from "./arrondissement.entity";
import { User } from "./user.entity";

@Entity("localisations")
export class Localisation {
    @PrimaryGeneratedColumn()
    id: number;
  
    @Column({ nullable: false})
    longitude: number;
  
    @Column({ nullable: false})
    latitude: number;

    @Column()
    altitude: number;

    @Column()
    speed: number;

    @Column()
    accuracy:number;

    @Column()
    entity:string;

    @Column()
    entityId:number;

    @Column()
  createur_id:number;

  
  @Column()
  editeur_id: number;

  @CreateDateColumn()
  create_at:Date;

  @UpdateDateColumn()
  update_at:Date;

  get createur(){
    return null;
  };

  set createur(editeur: User){
    this.editeur_id=editeur.id;
  }

  get diteur(){
    return null;
  };

  set editeur(editeur: User){
    this.editeur_id=editeur.id;
  }
}
