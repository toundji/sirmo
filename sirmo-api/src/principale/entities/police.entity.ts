/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn, UpdateDateColumn } from 'typeorm';
import { User } from './user.entity';
import { RelationId } from 'typeorm';
import { OneToOne } from 'typeorm';

@Entity()
export class Police {
  @OneToOne((type) => User, {primary:true, nullable:false, eager:true})
  @JoinColumn({ name: 'id' })
  user: User;

  @PrimaryColumn()
  @RelationId((police:Police)=>police.user)
  id: number;

  @Column({ nullable: false, unique: true })
  ifu: string;

  @Column({ nullable: false, unique: true })
  identifiant: string;

  @Column()
  createur_id:number;

  
  @Column()
  editeur_id: number;

  @CreateDateColumn()
  create_at:Date;

  @UpdateDateColumn()
  update_at:Date;

  
}
