/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { Audit } from './audit';
import { User } from './user.entity';

@Entity()
export class Fichier extends Audit {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: false})
  nom: string;

  @Column({ nullable: false, unique: true })
  path: string;

  @Column({ nullable: false})
  mimetype: string;

  @Column({ nullable: false})
  size: string;

  @Column({nullable:true})
  entity: string;

  @Column({nullable:true})
  entityId: number;

  


  static  fromMap({nom, path, mimetype,size, entity}):Fichier{
    const fichier:Fichier = new Fichier();
    fichier.nom = nom;
    fichier.path = path;
    fichier.mimetype = mimetype;
    fichier.size = size;
    fichier.entity=entity;
    return fichier;
  }
}
