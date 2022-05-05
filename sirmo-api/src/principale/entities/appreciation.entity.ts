/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { User } from './user.entity';
import { Zem } from './zem.entity';
import { TypeAppreciation } from 'src/enums/type-appreciation';
import { Fichier } from './fichier.entity';

@Entity("appreciations")
export class Appreciation {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({nullable: false})
  typeAppreciation: TypeAppreciation;

  @Column({nullable:true})
  message:string;

  @Column({nullable:false})
  phone:string;

  @JoinColumn({ name: 'zem_id',  })
  @ManyToOne((type) => Zem, {nullable:false, eager:true})
  zem: Zem;

  @JoinColumn({ name: 'fichier_id' })
  @ManyToOne((type) => Fichier, {eager:true})
  fichier: Fichier;


  @Column({nullable:true})
  createur_id:number;

  
  @Column({nullable:true})
  editeur_id: number;

  @CreateDateColumn()
  create_at:Date;

  @UpdateDateColumn()
  update_at:Date;

}
