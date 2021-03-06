/* eslint-disable prettier/prettier */
import { CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Column } from "typeorm/decorator/columns/Column";
import { Arrondissement } from "./arrondissement.entity";
import { User } from "./user.entity";

@Entity("localisations")
export class Localisation {
  static  entityName  = "localisations";

    @PrimaryGeneratedColumn()
    id: number;
  
    @Column({ nullable: false})
    longitude: number;
  
    @Column({ nullable: false})
    latitude: number;

    @Column()
    altitude: number;

    @Column({nullable:false})
    place_id: string;

    @Column({nullable:null})
    entity:string;

    @Column({nullable:null})
    entityId:number;

}
