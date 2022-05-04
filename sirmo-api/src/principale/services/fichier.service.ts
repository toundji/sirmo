/* eslint-disable prettier/prettier */
import { Injectable, UploadedFile } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm/repository/Repository";
import { Fichier } from "../entities/fichier.entity";
import { User } from "../entities/user.entity";

@Injectable()
export class FichierService {
  constructor(
    @InjectRepository(Fichier) private fichierRepository: Repository<Fichier>,
  ) {}

  create(createFichierDto: Fichier) {
    return this.fichierRepository.save(createFichierDto);
  }

  findAll() {
    return this.fichierRepository.find();
  }

  async createOneWith(@UploadedFile() fichier,entityName:string, entityId:number, user:User) {
      const name = fichier.originalname.split(".")[0];
      const file: Fichier = Fichier.fromMap({
        nom: name,
        path: fichier.path,
        mimetype: fichier.mimetype,
        size: fichier.size,
        entity: entityName
      });
      file.entityId = entityId;
      fichier.createur = user;
      return await this.create(file);
    
  }

  findOne(id: number) {
    return this.fichierRepository.findOne(id);
  }

  edit(id: number, fichier: Fichier) {
    this.findOne(id);
    fichier.id = id;

    return this.fichierRepository.save(fichier);
  }

  update(id: number, fichier: Fichier) {
    return this.fichierRepository.update(id, fichier);
  }

  remove(id: number) {
    return this.fichierRepository.delete(id);
  }
}
