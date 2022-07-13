/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { Audit } from './audit';
import { User } from './user.entity';

@Entity("fichiers")
export class Fichier extends Audit {
  static  entityName  = "fichiers";

  @PrimaryGeneratedColumn()
  id: number;

  @Column({ nullable: true})
  nom: string;

  @Column({ nullable: false, unique: true })
  path: string;

  @Column({ nullable: true})
  mimetype: string;

  @Column({ nullable: true})
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
