/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { User } from './user.entity';
import { Conducteur } from './conducteur.entity';
import { TypeAppreciation } from 'src/enums/type-appreciation';
import { Fichier } from './fichier.entity';
import { Audit } from './audit';

@Entity("appreciations")
export class Appreciation extends Audit {
  static  entityName  = "appreciations";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({nullable: false})
  typeAppreciation: TypeAppreciation;

  @Column({nullable:true})
  message:string;

  @Column({nullable:false})
  phone:string;

  @JoinColumn({ name: 'conducteur_id',  })
  @ManyToOne((type) => Conducteur, {nullable:false, eager:true})
  conducteur: Conducteur;

  @JoinColumn({ name: 'fichier_id' })
  @ManyToOne((type) => Fichier, {eager:true})
  fichier: Fichier;


}
