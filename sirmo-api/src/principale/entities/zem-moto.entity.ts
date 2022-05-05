/* eslint-disable prettier/prettier */
import { Moto } from "src/principale/entities/moto.entity";
import { Column, CreateDateColumn, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from "typeorm";
import { Entity } from "typeorm/decorator/entity/Entity";
import { Audit } from "./audit";
import { User } from "./user.entity";
import { Zem } from "./zem.entity";


@Entity()
export class ZemMoto extends Audit{
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false , default: ()=>'NOW()'})
  date_debut: Date ;

  @Column()
  date_fin: Date;

  @ManyToOne((type) => Zem, {nullable:false})
  @JoinColumn({ name: 'zem_id'})
  zem:Zem;

  @ManyToOne((type) => Moto,  {nullable:false})
  @JoinColumn({ name: 'moto_id' })
  moto:Moto;

  


  static fromMap({zem, moto, date_debut, date_fin, ...res }):ZemMoto{
    const zm: ZemMoto= new ZemMoto();
    zm.date_debut = date_debut;
    zm.date_fin = date_fin,
    zm.zem = zem;
    zm.moto = moto;
    zm.createur_id = res["createur_id"];
    zm.editeur_id = res["editeur_id"];
    return zm;
  }

}
