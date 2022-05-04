/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { Mairie } from './mairie.entity';
import { User } from './user.entity';
import { Zem } from './zem.entity';
import { Payement } from './payement.entity';

@Entity()
export class Licence {
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

  @JoinColumn({ name: 'payement' })
  @ManyToOne((type) => Payement, {eager: true})
  payement: Payement;



}
