/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryColumn, UpdateDateColumn } from 'typeorm';
import { User } from './user.entity';
import { RelationId } from 'typeorm';
import { OneToOne } from 'typeorm';
import { Audit } from './audit';

@Entity()
export class Police extends Audit {
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

  
}
