/* eslint-disable prettier/prettier */
import { StatutZem } from 'src/enums/statut-zem';
import { BeforeInsert, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId, UpdateDateColumn } from 'typeorm';
import { Licence } from './licence.entity';
import { Moto } from './moto.entity';
import { Appreciation } from './appreciation.entity';
import { Amande } from './amande.entity';
import { ZemMoto } from './zem-moto.entity';
import { User } from './user.entity';
import { Audit } from './audit';



@Entity("zems")
export class Zem extends Audit {
  static entityName  = "zems";

  @PrimaryGeneratedColumn()
  id: number;

  @OneToOne((type) => User, { nullable:false, eager:true})
  @JoinColumn({ name: 'zem_id'})
  user:User;

  @Column({ nullable: false })
  ifu: string;

  @Column({ nullable: false,})
  cip: string;

  @Column({ nullable: false,  })
  nip: string;

  @Column({ nullable: false, unique: true })
  niz: string;

  @Column()
  idCarde: string;

  @Column({ unique: true })
  certificatRoute: string;

  @Column({ default: StatutZem.ACTIF, nullable: false })
  statut: StatutZem;

  @Column({ nullable: false })
  ancienIdentifiant: string;

  //licence en cours
  @ManyToOne((type) => Licence,
   { nullable:true, eager:true })
  @JoinColumn({ name: 'licence_id'})
  licence?:Licence;

  @ManyToOne((type) => Moto, moto=>moto.zem, { nullable:true})
  @JoinColumn({ name: 'moto_id'})
  moto?:Moto;

  @OneToMany(type => Licence, licence => licence.zem)
  licences?: Licence[];

  // List des anciens motos conduit
  @OneToMany(type => ZemMoto, zemMoto => zemMoto.zem)
  zemMotos?: ZemMoto[];


  @OneToMany(type => Appreciation, appreciation  => appreciation.zem)
  appreciations?: Appreciation[];

  @OneToMany(type => Amande, amande  => amande.zem )
  amandes?: Amande[];

 


  
  @BeforeInsert()  async generateNiz() {
    const t = new Date();
    const date = ('0' + t.getDate()).slice(-2);
    const month = ('0' + (t.getMonth() + 1)).slice(-2);
    const year = (''+t.getFullYear()).slice(-2);
    const hours = ('0' + t.getHours()).slice(-2);
    const minutes = ('0' + t.getMinutes()).slice(-2);
    const seconds = ('0' + t.getSeconds()).slice(-2);
    const dif = ("0"+Math.floor(Math.random() * (99 + 1))).slice(-2);
    const time = `${dif}${seconds}${minutes}${hours}${date}${month}${year}`;
    this.niz = time;
  }

}

