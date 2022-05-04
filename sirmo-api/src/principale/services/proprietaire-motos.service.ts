/* eslint-disable prettier/prettier */
import { Inject, Injectable } from '@nestjs/common';
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

    return this.proprietaireMotoRepository.save(proprietaireMoto);
  }

  createValidProprietaireMoto(
    moto: ProprietaireMoto,
  ): Promise<ProprietaireMoto> {
    return this.proprietaireMotoRepository.save(moto);
  }

  findOneByProprietaireAndMoto(proprietaire_id: number, moto_id: number): Promise<ProprietaireMoto> {
    const moto:Moto =new Moto(); moto.id = moto_id;
    const proprietaire:User = new User(); proprietaire.id = proprietaire_id;
    return this.proprietaireMotoRepository.findOne( {
      where:{
        moto: moto,
        proprietaire: proprietaire
      },
      order:{
        create_at: "DESC"
      },
    });
  }

  findAll(): Promise<ProprietaireMoto[]> {
    return this.proprietaireMotoRepository.find({
      relations: ['moto', 'propprietaire'],
    });
  }

  findOne(id: number): Promise<ProprietaireMoto> {
    return this.proprietaireMotoRepository.findOne(id, {
      relations:['moto', 'propprietaire'],
    });
  }

  update(id: number, updateProprietaireMotoDto: UpdateProprietaireMotoDto) {
    return this.proprietaireMotoRepository.update(
      id,
      updateProprietaireMotoDto,
    );
  }

  patch(id: number, updateProprietaireMotoDto: UpdateProprietaireMotoDto) {
    return this.proprietaireMotoRepository.update(
      id,
      updateProprietaireMotoDto,
    );
  }

  remove(id: number) {
    return this.proprietaireMotoRepository.delete(id);
  }
}
