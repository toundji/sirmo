/* eslint-disable prettier/prettier */
import { Arrondissement } from "src/principale/entities/arrondissement.entity";
import { BeforeInsert, Column, Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { v4 as uuidv4 } from 'uuid';
import { Role } from './role.entity';
import { hash } from 'bcrypt';
import { Fichier } from 'src/principale/entities/fichier.entity';
import { Audit } from "./audit";
import { Genre } from 'src/enums/genre';
import { Exclude } from 'class-transformer';
import { Commune } from './commune.entity';
import { ApiProperty } from "@nestjs/swagger";


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
  genre: Genre;

  @Exclude()
  @Column({ nullable: false })
  password: string;

  @Column({nullable:true})
  // @Index({ unique: true, where: "email IS NOT NULL" })
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
  @ManyToOne(type => Fichier)
  profile: Fichier;

//   @ApiProperty()
//   get departement():string{
//     return this.arrondissement?.commune?.departement?.nom;
//   }
// 
//   @ApiProperty()
//   get commune():string{
//     return this.arrondissement?.commune?.nom;
//   }

  @ManyToMany(type=>Fichier)
  @JoinTable({
    name: 'users_profiles',
    joinColumn: { name: 'user_id', referencedColumnName: 'id'},
    inverseJoinColumn: { name: 'fichier_id', referencedColumnName: 'id'},
  })
  profiles?: Fichier[];

  @BeforeInsert()  async hashPassword() {
    this.email = this.email?.toLowerCase()?.trim();
    this.phone = this.phone.trim();
    this.password = await hash(this.password, 10);  
  }
}
