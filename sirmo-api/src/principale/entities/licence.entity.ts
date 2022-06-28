/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { Mairie } from './mairie.entity';
import { User } from './user.entity';
import { Zem } from './zem.entity';
import { Payement } from './payement.entity';
import { Audit } from './audit';

@Entity("licences")
export class Licence extends Audit{
  static  entityName  = "licences";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({nullable:false,})
  montant:number;

  @Column({nullable:false,
  default: () => 'NOW()',})
  date_debut:Date;

  @Column()
  date_fin:Date;

  @JoinColumn({ name: 'zem_id'})
  @ManyToOne((type) => Zem)
  zem: Zem;

  @JoinColumn({ name: 'marie' })
  @ManyToOne((type) => Mairie, {nullable:false, eager:true})
  mairie: Mairie;

  @JoinColumn({ name: 'payement' })
  @ManyToOne((type) => Payement, {eager: true})
  payement: Payement;



}
