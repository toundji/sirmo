/* eslint-disable prettier/prettier */
import { EtatVehicule } from 'src/enums/etat-vehicule';
import { User } from 'src/principale/entities/user.entity';
import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  JoinColumn,
  ManyToOne,
  ManyToMany,
  JoinTable
} from 'typeorm';
import { Conducteur } from './conducteur.entity';
import { TypeAmande } from './type-amande.entity';
import { Police } from './police.entity';
import { Payement } from './payement.entity';
import { Audit } from './audit';
import { v4 as uuidv4 } from 'uuid';

@Entity("amandes")
export class Amande extends Audit{

  static  entityName  = "amandes";

  @PrimaryGeneratedColumn()
  id: number;
  
  @Column({nullable:true})
  message: string;

  @Column()
  montant:number;

  @Column({ nullable: true, unique: true })
  code?: string = uuidv4();

  @Column()
  date_limite:Date;

  @Column()
  restant:number;

  @ManyToMany(type=>TypeAmande, {eager:true})
  @JoinTable({
    name: 'amande_types',
    joinColumn: { name: 'amande_id', referencedColumnName: 'id'},
    inverseJoinColumn: { name: 'type_amande_id', referencedColumnName: 'id'},
  })
  typeAmndes?: TypeAmande[];

  @ManyToMany(type=>Payement, {eager:true})
  @JoinTable({
    name: 'amandes_payements',
    joinColumn: { name: 'amande_id', referencedColumnName: 'id'},
    inverseJoinColumn: { name: 'payement_id', referencedColumnName: 'id'},
  })
  payements: Payement[];


  @ManyToOne((type) => Police,{eager:true})
  @JoinColumn({ name: 'police_id' })
  police: Police;

  @ManyToOne((type) => Conducteur, {nullable:false,eager:true})
  @JoinColumn({ name: 'conducteur_id' })
  conducteur: Conducteur;

  }
