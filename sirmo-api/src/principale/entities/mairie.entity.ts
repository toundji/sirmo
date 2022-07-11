/* eslint-disable prettier/prettier */
import { CreateDateColumn, Entity, JoinColumn, JoinTable, ManyToMany, ManyToOne, OneToMany, OneToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Column } from "typeorm/decorator/columns/Column";
import { Arrondissement } from "./arrondissement.entity";
import { Localisation } from './localisation.entity';
import { Licence } from './licence.entity';
import { User } from "./user.entity";
import { Commune } from "./commune.entity";
import { Fichier } from 'src/principale/entities/fichier.entity';
import { Audit } from "./audit";

@Entity("mairies")
export class Mairie extends Audit{
    
    static  entityName  = "mairies";

    
    @PrimaryGeneratedColumn()
    id: number;
  
    @Column({ nullable: false, unique: true })
    nom: string;
  
    @Column({ nullable: false})
    adresse: string;


    @Column({ default: "#00561b"})
    couleur:string;

    @Column({
        nullable: false, default : 0 })
    solde:number;

    @Column({
        nullable: false, default : 0 })
    accumulation:number;

    @JoinColumn({ name: 'arrondissement_id' })
    @ManyToOne(type => Arrondissement)
    arrondissement?: Arrondissement;

    @JoinColumn({ name: 'localisation_id' })
    @ManyToOne(type => Localisation, {eager:true})
    localisation?: Localisation;

    @OneToMany(type => Licence, licence => licence.mairie)
    licences?: Licence[];


    @OneToOne((type) => Commune, { nullable:false, eager:true})
    @JoinColumn({ name: 'commune_id'})
    commune:Commune;

    @JoinColumn({ name: 'fichier_id' })
    @ManyToOne(type => Fichier)
    image?: Fichier;

    @ManyToMany(type=>Fichier)
    @JoinTable({
        name: 'mairie_images',
        joinColumn: { name: 'mairie_id', referencedColumnName: 'id'},
        inverseJoinColumn: { name: 'fichier_id', referencedColumnName: 'id'},
    })
    images?: Fichier[];
  
}
