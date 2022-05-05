/* eslint-disable prettier/prettier */
import { Arrondissement } from "src/principale/entities/arrondissement.entity";
import { BeforeInsert, Column, Entity, JoinColumn, JoinTable, ManyToMany, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { v4 as uuidv4 } from 'uuid';
import { Role } from './role.entity';
import { hash } from 'bcrypt';
import { Fichier } from 'src/principale/entities/fichier.entity';
import { Audit } from "./audit";


@Entity("users")
export class User extends Audit{
  static entityName  = "users";

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

  @Column({nullable:true})
  email: string;

  @Column({nullable:true})
  date_naiss: Date;

  @Column({unique:true, nullable:false})
  phone: string;


  @Column({ nullable: false, unique: true })
  code?: string = uuidv4();

  

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
