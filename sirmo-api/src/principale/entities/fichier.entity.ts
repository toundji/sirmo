/* eslint-disable prettier/prettier */
import { Column, CreateDateColumn, Entity, JoinColumn, ManyToOne, PrimaryGeneratedColumn, UpdateDateColumn } from 'typeorm';
import { User } from './user.entity';

@Entity()
export class Fichier {
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

  @Column()
  entity: string;

  @Column()
  entityId: number;

  @Column()
  createur_id:number;

  
  @Column()
  editeur_id: number;

  @CreateDateColumn()
  create_at:Date;

  @UpdateDateColumn()
  update_at:Date;

  get createur(){
    return null;
  };

  set createur(editeur: User){
    this.editeur_id=editeur.id;
  }

  get diteur(){
    return null;
  };

  set editeur(editeur: User){
    this.editeur_id=editeur.id;
  }


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
