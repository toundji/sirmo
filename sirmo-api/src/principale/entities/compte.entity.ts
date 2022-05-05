/* eslint-disable prettier/prettier */
import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryColumn,
  RelationId,
} from 'typeorm';
import { Zem } from './zem.entity';
import { OneToOne } from 'typeorm';


@Entity("comptes")
export class Compte {
  static  entityName  = "comptes";


  @OneToOne((type) => Zem, {primary:true, nullable:false})
  @JoinColumn({ name: 'id'})
  zem: Zem;

  @PrimaryColumn()
  @RelationId((compte: Compte) => compte.zem)
  id: number;

  @Column()
  montant:number;

  @Column({ nullable: false, unique: true })
  cip: string;

  constructor(icompte?:iCompte){
    this.montant = icompte?.montant ?? 0;
    this.zem = icompte?.zem;
    this.cip = icompte?.zem?.cip;
  }

}

export interface iCompte{
  zem?: Zem;

  montant?:number;

}
