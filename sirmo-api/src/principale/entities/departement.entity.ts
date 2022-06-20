/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { Commune } from "src/principale/entities/commune.entity";
import { Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./user.entity";

@Entity("departements")
export class Departement {
    static  entityName  = "departements";


    @PrimaryGeneratedColumn()
    id: number;
  
    @Column({ nullable: false })
    nom: string;

    @OneToMany(type => Commune, commune => commune.departement)
    communes?: Commune[];

   }
