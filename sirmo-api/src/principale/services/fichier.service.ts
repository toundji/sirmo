/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException, UploadedFile } from "@nestjs/common";
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
    try {
      return this.fichierRepository.save(createFichierDto);

    } catch (error) {
      console.log(error);
      
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");

    }
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
    try {
      return this.fichierRepository.findOne(id);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le fichier spécifié n'existe pas");
    
    }
  }

  edit(id: number, fichier: Fichier) {
    this.findOne(id);
    fichier.id = id;

    try {
      return this.fichierRepository.save(fichier);
    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le fichier spécifié n'existe pas");

    }
  }

  update(id: number, fichier: Fichier) {
    try {
      return this.fichierRepository.update(id, fichier);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le fichier spécifié n'existe pas");

    }
  }

  remove(id: number) {
    try {
      return this.fichierRepository.delete(id);
    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le fichier spécifié n'existe pas");

    }
  }
}
