/* eslint-disable prettier/prettier */
import { BadRequestException, Injectable, NotFoundException, UploadedFile, UploadedFiles } from "@nestjs/common";
import { InjectRepository } from "@nestjs/typeorm";
import { Repository } from "typeorm/repository/Repository";
import { Fichier } from "../entities/fichier.entity";
import { User } from "../entities/user.entity";
import { Express } from 'multer';
import { Zem } from "../entities/zem.entity";
import { In } from "typeorm";


@Injectable()
export class FichierService {
  constructor(
    @InjectRepository(Fichier) private fichierRepository: Repository<Fichier>,
  ) {}

  create(createFichierDto: Fichier) {
 
      return this.fichierRepository.save(createFichierDto).catch((error)=>{
        console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");

      });

   
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


  async createZemFiles(id:number, @UploadedFiles() files: Array<Express.Multer.File>, user:User) {
    const zem:Zem = await Zem.findOneOrFail(id).catch((error)=>{
      console.log("error");
      throw new BadRequestException("L'e zem indique n'existe pas");
    });
    const fichiers: Fichier[] = [];
    Object.keys(files).forEach((cle)=>{
      const fichier: Express.Multer.File = files[cle][0];
    const file: Fichier = Fichier.create({
      nom: cle,
      path: fichier.path,
      mimetype: fichier.mimetype,
      size: fichier.size,
      entity: "zems",
      entityId: id,
      createur_id:user?.id,
    });
    fichiers.push(file);
    });
    
    return await this.fichierRepository.save(fichiers).catch((error)=>{
      console.log(error);
      throw new BadRequestException(" Erreur est pendant la sauvegarde des fichiers. Veillez contacter un administrateur si cella persiste")
    });
  
}

async getZemFiles(id:number):Promise<Fichier[]> {
  return await this.fichierRepository.find({where: {
    nom: In(["ifu", "cip", "nip", "idCarde", "ancienIdentifiant"]),
    entityId: id,
    entity: "zems"
  }}).catch((error)=>{
    console.log(error);
    throw new BadRequestException(" Erreur pendant la récuperation des fichiers. Veillez contacter un administrateur si cela persiste")
  });

}


  findOne(id: number) {

      return this.fichierRepository.findOne(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le fichier spécifié n'existe pas");
      
      });

  
  }

  edit(id: number, fichier: Fichier) {
    this.findOne(id);
    fichier.id = id;

    
      return this.fichierRepository.save(fichier).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le fichier spécifié n'existe pas");
  
      });
  
  }

  update(id: number, fichier: Fichier) {
 
      return this.fichierRepository.update(id, fichier).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le fichier spécifié n'existe pas");
  
      });
  }


  remove(id: number) {
   
      return this.fichierRepository.delete(id).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le fichier spécifié n'existe pas");
  
      });
    
  }
}
