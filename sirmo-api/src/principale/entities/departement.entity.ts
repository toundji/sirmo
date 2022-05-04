/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger";
import { Commune } from "src/principale/entities/commune.entity";
import { Column, CreateDateColumn, Entity, OneToMany, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./user.entity";

@Entity()
export class Departement {
    @PrimaryGeneratedColumn()
    id: number;
  
    @Column({ nullable: false })
    nom: string;

    @OneToMany(type => Commune, commune => commune.departement, {eager:true})
    communes?: Commune[];

   }
