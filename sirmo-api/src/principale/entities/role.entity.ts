/* eslint-disable prettier/prettier */
import { ApiProperty } from "@nestjs/swagger/dist/decorators";
import { timeStamp } from "console";
import { RoleName } from "src/enums/role-name";
import { Column, CreateDateColumn, Entity, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Audit } from "./audit";
import { User } from "./user.entity";

@Entity("roles")
export class Role extends Audit{
  static entityName  = "roles";

    @PrimaryGeneratedColumn()
    id: number;
  
    @Column({ nullable: false, unique:true})
    nom: RoleName;

    
}
