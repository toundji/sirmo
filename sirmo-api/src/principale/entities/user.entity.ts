/* eslint-disable prettier/prettier */
import { Arrondissement } from "src/principale/entities/arrondissement.entity";
import { BeforeInsert, BeforeUpdate, Column, CreateDateColumn, Entity, JoinColumn, JoinTable, ManyToMany, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { v4 as uuidv4 } from 'uuid';
import { Role } from './role.entity';
import { UpdateDateColumn } from 'typeorm';
import { hash } from 'bcrypt';
import { Fichier } from 'src/principale/entities/fichier.entity';


@Entity()
export class User {
  static entityName  = "user";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  nom: string;

  @Column({ nullable: false })
  prenom: string;

  @Column()
  genre: boolean;

  @Column({ nullable: false })
  password: string;

  @Column()
  email: string;

  @Column()
  date_naiss: Date;

  @Column({unique:true, nullable:false})
  tel: string;


  @Column({ nullable: false, unique: true })
  code?: string = uuidv4();

  @CreateDateColumn()
  create_at:Date;

  @UpdateDateColumn()
  update_at:Date;

  @ManyToMany(type=>Role, {eager:true})
  @JoinTable({
    name: 'users_roles',
    joinColumn: { name: 'user_id', referencedColumnName: 'id'},
    inverseJoinColumn: { name: 'role_id', referencedColumnName: 'id'},
  })
  roles?: Role[];

  @JoinColumn({ name: 'arrondissement_id' , })
  @ManyToOne(type => Arrondissement, {nullable:false, eager:true})
  arrondissement: Arrondissement;

  @JoinColumn({ name: 'fichier_id' , })
  @ManyToOne(type => Fichier, {eager:true})
  profile: Fichier;

  @ManyToMany(type=>Fichier)
  @JoinTable({
    name: 'users_profiles',
    joinColumn: { name: 'user_id', referencedColumnName: 'id'},
    inverseJoinColumn: { name: 'fichier_id', referencedColumnName: 'id'},
  })
  profiles?: Fichier[];


  
  @BeforeInsert()  async hashPassword() {
    this.password = await hash(this.password, 10);  
  }
}
