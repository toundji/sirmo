/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger/dist/decorators";
import { timeStamp } from "console";
import { RoleName } from "src/enums/role-name";
import { Column, CreateDateColumn, Entity, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { User } from "./user.entity";

@Entity()
export class Role {
    @PrimaryGeneratedColumn()
    id: number;
  
    @Column({ nullable: false, unique:true})
    nom: RoleName;

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

}
