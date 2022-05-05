/* eslint-disable prettier/prettier */
import { BadRequestException, forwardRef, Inject, Injectable, UploadedFile } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateMotoDto } from '../createDto/create-moto.dto';
import { Moto } from '../entities/moto.entity';
import { User } from '../entities/user.entity';
import { Zem } from '../entities/zem.entity';
import { UserService } from './user.service';
import { ZemService } from './zem.service';
import { ProprietaireMoto } from './../entities/proprietaire-moto.entity';
import { ProprietaireMotosService } from './proprietaire-motos.service';
import { ZemMotoService } from './zem-moto.service';
import { ZemMoto } from './../entities/zem-moto.entity';
import { NotFoundException } from '@nestjs/common';
import { FichierService } from './fichier.service';
import { Fichier } from '../entities/fichier.entity';

@Injectable()
export class MotoService {
  constructor(
    @InjectRepository(Moto) private motoRepository: Repository<Moto>,
    private readonly userService:UserService,
    @Inject(forwardRef(() => ZemService))
    private readonly zemService:ZemService,
    @Inject(forwardRef(() => ProprietaireMotosService))
    private readonly proprietaireMotosService: ProprietaireMotosService,
    @Inject(forwardRef(() => ZemMotoService))
    private readonly zemMotoService:ZemMotoService,
    private readonly fichierService: FichierService,

  ) {}

  async create(createMotoDto: CreateMotoDto): Promise<Moto> {
    let moto: Moto = new Moto();
    Object.keys(createMotoDto).forEach((cle) => {
      moto[cle] = createMotoDto[cle];
    });
    const owner: User = await this.userService.findOne(createMotoDto.proprietaire.proprietaireId)
    moto.proprietaire = owner;

    const zem: Zem = await this.zemService.findOne(createMotoDto.zem.zem_id)
    moto.zem = zem;

    try {
      moto =await  this.motoRepository.save(moto);

    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    
    }
     

     //update ZemMoto if zem.moto is not null
    zem.moto = moto;
    
    this.zemService.update(zem.id,zem);
    let proprietaireMoto:ProprietaireMoto =  ProprietaireMoto.fromMap({proprietaire: owner, moto:moto, date_debut:createMotoDto.proprietaire.date_debut, date_fin:createMotoDto.proprietaire.date_fin})
     proprietaireMoto = await this.proprietaireMotosService.createValidProprietaireMoto(proprietaireMoto);
     proprietaireMoto.moto = null;

    const zemMoto: ZemMoto = ZemMoto.fromMap({zem: zem, moto:moto, date_debut:createMotoDto.zem.date_debut, date_fin:createMotoDto.zem.date_fin})
    
      await this.zemMotoService.createValidZemMoto(zemMoto);
    zemMoto.moto = null;
    moto.zem.moto = null;
    return moto;
    

    

  }



  findAll(): Promise<Moto[]> {
    return this.motoRepository.find();
  }

  findOne(id: number): Promise<Moto> {
    try{return this.motoRepository.findOne(id);}catch(e){
      console.log(e);
      throw new NotFoundException("Le payement spécifié n'existe pas");
        }
  }

  edit(id: number, moto: Moto) {
    this.findOne(id);
    moto.id = id;
    return this.motoRepository.save(moto);
  }

  async updateImage(id: number, @UploadedFile() profile, user:User){
    const moto: Moto = await this.findOne(id);
    const image: Fichier = await this.fichierService.createOneWith(
      profile,
      Moto.entityName,
      id,
      user
    );
    moto.image = image;
    moto.images ??= [];
    moto.images.push(image)
    try {
      return await this.motoRepository.save(moto);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le payement spécifié n'existe pas");
    
    }
  }

  update(id: number, moto: Moto) {
    try {
      return this.motoRepository.update(id, moto );

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le payement spécifié n'existe pas");
    
    }
  }

  remove(id: number) {
    try {
      return this.motoRepository.delete(id);

    } catch (error) {
      console.log(error);
      throw new NotFoundException("Le payement spécifié n'existe pas");
    
    }
  }
}
