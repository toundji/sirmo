/* eslint-disable prettier/prettier */
import { EtatMoto } from 'src/enums/etat-moto';
import { User } from 'src/principale/entities/user.entity';
import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  JoinColumn,
  ManyToOne,
  ManyToMany,
  JoinTable,
  OneToMany,
  CreateDateColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Zem } from './zem.entity';
import { TypeAmande } from './type-amande.entity';
import { Police } from './police.entity';
import { Payement } from './payement.entity';

@Entity("amandes")
export class Amande {
  @PrimaryGeneratedColumn()
  id: number;
  
  @Column({nullable:true})
  message: string;

  @Column()
  montant:number;

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

  @ManyToOne((type) => Zem, {nullable:false,eager:true})
  @JoinColumn({ name: 'zem_id' })
  zem: Zem;

 
  @Column()
  editeur_id: number;

  @CreateDateColumn()
  create_at:Date;

  @UpdateDateColumn()
  update_at:Date;
}
