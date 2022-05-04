/* eslint-disable prettier/prettier */
import { StatutZem } from 'src/enums/statut-zem';
import { BeforeInsert, Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, OneToMany, OneToOne, PrimaryColumn, PrimaryGeneratedColumn, RelationId, UpdateDateColumn } from 'typeorm';
import { Licence } from './licence.entity';
import { Moto } from './moto.entity';
import { Appreciation } from './appreciation.entity';
import { Amande } from './amande.entity';
import { ZemMoto } from './zem-moto.entity';
import { User } from './user.entity';
import { v4 as uuidv4 } from 'uuid';
import { Transform } from 'class-transformer';
import { Commune } from './commune.entity';



@Entity()
export class Zem {
  @OneToOne((type) => User, { nullable:false, eager:true , primary:true})
  @JoinColumn({ name: 'id'})
  user:User;
  
  @PrimaryColumn()
  @RelationId((zem: Zem) => zem.user)
  id: number;

  @Column({ nullable: false, unique: true })
  ifu: string;

  @Column({ nullable: false, unique: true })
  cip: string;

  @Column({ nullable: false, unique: true, })
  nip: string;

  @Column({ nullable: false, unique: true })
  niz: string;

  @Column({ unique: true })
  compteEcobank: string;

  @Column({ unique: true })
  compteFedapay: string;

  @Column({ unique: true })
  certificatRoute: string;

  @Column()
  statut: StatutZem;

  @Column({ nullable: false })
  ancienIdentifiant: string;

  //licence en cours
  @ManyToOne((type) => Licence,
   { nullable:true, eager:true })
  @JoinColumn({ name: 'licence_id'})
  licence?:Licence;

  @ManyToOne((type) => Moto, { nullable:true})
  @JoinColumn({ name: 'moto_id'})
  moto?:Moto;

  @OneToMany(type => Licence, licence => licence.zem)
  licences?: Licence[];

  // List des anciens motos conduit
  @OneToMany(type => ZemMoto, zemMoto => zemMoto.zem)
  zemMotos?: ZemMoto[];

  // @OneToOne(type => Compte, compte => compte.zem,{eager:false})
  // compte: Compte;


  @OneToMany(type => Appreciation, appreciation  => appreciation.zem)
  appreciations?: Appreciation[];

  @OneToMany(type => Amande, amande  => amande.zem )
  amandes?: Amande[];

  @CreateDateColumn()
  create_at:Date;

  @UpdateDateColumn()
  update_at:Date;


  
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

