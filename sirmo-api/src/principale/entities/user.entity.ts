/* eslint-disable prettier/prettier */
import { Arrondissement } from "src/principale/entities/arrondissement.entity";
import { BeforeInsert, Column, Entity, Index, JoinColumn, JoinTable, ManyToMany, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { hash } from 'bcrypt';
import { Fichier } from 'src/principale/entities/fichier.entity';
import { Audit } from "./audit";
import { Genre } from 'src/enums/genre';
import { Exclude } from 'class-transformer';
import { RoleName } from 'src/enums/role-name';


@Entity("users")
export class User extends Audit{
  static entityName  = "users";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false })
  nom: string;

  @Column({ nullable: false })
  prenom: string;

  @Column({ nullable: true })
  token: string;

  @Column({nullable:true})
  genre: Genre;

  @Exclude()
  @Column({ nullable: false })
  password: string;

  @Column({nullable:true})
  @Index({ unique: true, where: "email IS NOT NULL" })
  email: string;

  @Column({nullable:true})
  date_naiss: Date;

  @Column({unique:true, nullable:false})
  phone: string;

  @Column({nullable:true})
  idCarde: string;

  @Column({ nullable: false, unique: true })
  code?: string;

  @Column({nullable:true})
  profile_image: string;

  @Column({ nullable: true,  unique:false  })
  idCarde_image: string;

  @Column("simple-array",{default: [RoleName.USER]})
  roles?: RoleName[];

  @JoinColumn({ name: 'arrondissement_id' , })
  @ManyToOne(type => Arrondissement, {nullable:false, eager:true})
  arrondissement: Arrondissement;

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
    this.phone = this.phone?.trim();
    this.password = await hash(this.password, 10);
    this.code = Date.now() + "";
  }

  
}
