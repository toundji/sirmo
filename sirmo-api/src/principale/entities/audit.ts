/* eslint-disable prettier/prettier */
import { BaseEntity, Column, CreateDateColumn, UpdateDateColumn } from "typeorm";

export abstract class  Audit extends BaseEntity {
  @Column({nullable: true})
  createur_id: number;

  @Column({nullable: true})
  editeur_id: number;

  @CreateDateColumn()
  create_at: Date;

  @UpdateDateColumn()
  update_at: Date;
}
