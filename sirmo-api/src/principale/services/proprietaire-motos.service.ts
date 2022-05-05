/* eslint-disable prettier/prettier */
import { BadRequestException, Inject, Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateProprietaireMotoDto } from '../createDto/create-proprietaire-moto.dto';
import { Moto } from '../entities/moto.entity';
import { ProprietaireMoto } from '../entities/proprietaire-moto.entity';
import { User } from '../entities/user.entity';
import { UpdateProprietaireMotoDto } from '../updateDto/update-proprietaire-moto.dto';
import { MotoService } from './moto.service';
import { UserService } from './user.service';
import { forwardRef } from '@nestjs/common';

@Injectable()
export class ProprietaireMotosService {
  constructor(
    @InjectRepository(ProprietaireMoto)
    private proprietaireMotoRepository: Repository<ProprietaireMoto>,
    @Inject(forwardRef(() => MotoService))
    private readonly motoService: MotoService,
    private readonly userService: UserService,
  ) {}

  async create(
    createProprietaireMotoDto: CreateProprietaireMotoDto,
  ): Promise<ProprietaireMoto> {
    const proprietaireMoto: ProprietaireMoto = new ProprietaireMoto();
    Object.keys(createProprietaireMotoDto).forEach((cle) => {
      proprietaireMoto[cle] = createProprietaireMotoDto[cle];
    });
    const user: User = await this.userService.findOne(createProprietaireMotoDto.proprietaireId)
    proprietaireMoto.proprietaire = user;

    const moto: Moto = await this.motoService.findOne(createProprietaireMotoDto.motoId);
    
    if(moto.proprietaire){}
    proprietaireMoto.moto = moto;

    moto.proprietaire = user;
    await this.motoService.edit(moto.id, moto);

    try {
      return this.proprietaireMotoRepository.save(proprietaireMoto);
    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    
    }

  }

  createValidProprietaireMoto(
    moto: ProprietaireMoto,
  ): Promise<ProprietaireMoto> {
    try {
      return this.proprietaireMotoRepository.save(moto);

    } catch (error) {
      console.log(error);
      throw new BadRequestException("Les données que nous avons réçues ne sont celles que  nous espérons");
    
    }
  }

  findOneByProprietaireAndMoto(proprietaire_id: number, moto_id: number): Promise<ProprietaireMoto> {
    const moto:Moto =new Moto(); moto.id = moto_id;
    const proprietaire:User = new User(); proprietaire.id = proprietaire_id;
    try {
      return this.proprietaireMotoRepository.findOne( {
        where:{
          moto: moto,
          proprietaire: proprietaire
        },
        order:{
          create_at: "DESC"
        },
      });
    } catch (error) {
      console.log(error);
      throw new NotFoundException(
            "La réssource démander est introuvable est introuvable",
          );
    }
    
  }

  findAll(): Promise<ProprietaireMoto[]> {
    try {
      return this.proprietaireMotoRepository.find({
        relations: ['moto', 'propprietaire'],
      });
    } catch (error) {
      console.log(error);
      throw new NotFoundException(
            "La réssource démander est introuvable est introuvable",
          );
    }
   
  }

  findOne(id: number): Promise<ProprietaireMoto> {
    try {
      return this.proprietaireMotoRepository.findOne(id, {
        relations:['moto', 'propprietaire'],
      });
    } catch (error) {
      console.log(error);
      throw new NotFoundException(
            "La réssource démander est introuvable est introuvable",
          );
    }
    
  }

  update(id: number, updateProprietaireMotoDto: UpdateProprietaireMotoDto) {
    try {
      return this.proprietaireMotoRepository.update(
        id,
        updateProprietaireMotoDto,
      );
    } catch (error) {
      console.log(error);
      throw new NotFoundException(
            "La réssource démander est introuvable est introuvable",
          );
    }
   
  }

  patch(id: number, updateProprietaireMotoDto: UpdateProprietaireMotoDto) {
    try {
      return this.proprietaireMotoRepository.update(
        id,
        updateProprietaireMotoDto,
      );
    } catch (error) {
      console.log(error);
      throw new NotFoundException(
            "La réssource démander est introuvable est introuvable",
          );
    }
    
  }

  remove(id: number) {
    try {
      return this.proprietaireMotoRepository.delete(id);

    } catch (error) {
      console.log(error);
      throw new NotFoundException(
            "La réssource démander est introuvable est introuvable",
          );
    }
  }
}
