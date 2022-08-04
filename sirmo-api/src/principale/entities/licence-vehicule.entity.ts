/* eslint-disable prettier/prettier */
import { BeforeInsert, Column, Entity, Index, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { Mairie } from './mairie.entity';
import { Conducteur } from './conducteur.entity';
import { Audit } from './audit';
import { StatusLicence } from 'src/enums/status-licence';
import { Expose } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';
import { Vehicule } from './vehicule.entity';
import { TypePayementLicence } from 'src/enums/type-payement';


@Entity("licence_vehicule")
export class LicenceVehicule extends Audit{
  static  entityName  = "licence_vehicule";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({nullable:false,})
  montant:number;

  @Column({nullable:true})
  solde_mairie:number;

  @Column({nullable:true})
  type_payement:TypePayementLicence;

  @Column({nullable:true})
  @Index({ unique: true, where: "transaction_id IS NOT NULL" })
  transaction_id:string;

  @Column({nullable:true})
  transaction_info:string;

  @Column({nullable:false,
  default: () => 'NOW()',})
  date_debut:Date;

  @Column()
  date_fin:Date;

  @Column()
  code?: string;
  

  @Expose()
  @ApiProperty({enum: StatusLicence})
 public get status(): StatusLicence{
    if( this.date_fin == null){
      return StatusLicence.DESACTIVEE;
    }
    const now: Date = new Date();
    return now > this.date_fin ? StatusLicence.DESACTIVEE: StatusLicence.ACTIVEE;
  }

  @JoinColumn({ name: 'conducteur_id'})
  @ManyToOne((type) => Conducteur)
  conducteur: Conducteur;

  @JoinColumn({ name: 'vehicule_id'})
  @ManyToOne((type) => Vehicule)
  vehicule: Vehicule;

  @JoinColumn({ name: 'marie' })
  @ManyToOne((type) => Mairie, {nullable:false, eager:true})
  mairie: Mairie;

  @BeforeInsert()  async hashPassword() {
    this.code = Date.now() + "";
  }
}
