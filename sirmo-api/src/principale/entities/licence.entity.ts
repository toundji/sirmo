/* eslint-disable prettier/prettier */
import { Column, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { Mairie } from './mairie.entity';
import { Conducteur } from './conducteur.entity';
import { Payement } from './payement.entity';
import { Audit } from './audit';
import { StatusLicence } from 'src/enums/status-licence';
import { DateTime } from './../../../node_modules/@types/luxon/src/datetime.d';
import { Expose } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';


@Entity("licences")
export class Licence extends Audit{
  static  entityName  = "licences";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({nullable:false,})
  montant:number;

  @Column({nullable:false,
  default: () => 'NOW()',})
  date_debut:Date;

  @Column()
  date_fin:Date;

  @Expose()
  @ApiProperty({enum: StatusLicence})
 public get status(): StatusLicence{
    if( this.date_fin == null){
      return StatusLicence.DESACTIVEE;
    }
    
    const now: Date = new Date();
    return now > this.date_debut ? StatusLicence.DESACTIVEE: StatusLicence.ACTIVEE;
  }

  @JoinColumn({ name: 'conducteur_id'})
  @ManyToOne((type) => Conducteur)
  conducteur: Conducteur;

  @JoinColumn({ name: 'marie' })
  @ManyToOne((type) => Mairie, {nullable:false, eager:true})
  mairie: Mairie;

  @JoinColumn({ name: 'payement' })
  @ManyToOne((type) => Payement, {eager: true})
  payement: Payement;

}
