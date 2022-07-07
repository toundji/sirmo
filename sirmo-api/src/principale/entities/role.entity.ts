/* eslint-disable prettier/prettier */
import { RoleName } from "src/enums/role-name";
import { Column,  Entity, PrimaryGeneratedColumn } from "typeorm";
import { Audit } from "./audit";

@Entity("roles")
export class Role extends Audit{
  static entityName  = "roles";

    @PrimaryGeneratedColumn()
    id: number;
    
    @Column({ nullable: false, unique:true})
    nom: RoleName;

}
