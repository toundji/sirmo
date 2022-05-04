/* eslint-disable prettier/prettier */
import { forwardRef, Inject, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreateZemMotoDto } from '../createDto/create-zem-moto.dto';
import { Moto } from '../entities/moto.entity';
import { User } from '../entities/user.entity';
import { ZemMoto } from '../entities/zem-moto.entity';
import { Zem } from '../entities/zem.entity';
import { MotoService } from './moto.service';
import { ZemService } from './zem.service';

@Injectable()
export class ZemMotoService {
  constructor(
    @InjectRepository(ZemMoto)
    private zemMotoRepository: Repository<ZemMoto>,
    private readonly zemService: ZemService,
    @Inject(forwardRef(() => MotoService))
    private readonly motoService: MotoService,

  ) {}

  async create(
    createZemMotoDto: CreateZemMotoDto,
  ): Promise<ZemMoto> {
    const zemMoto: ZemMoto = new ZemMoto();
    Object.keys(createZemMotoDto).forEach((cle) => {
      zemMoto[cle] = createZemMotoDto[cle];
    });
    const zem: Zem = await this.zemService.findOne(createZemMotoDto.zem_id)
    zemMoto.zem = zem;
    if(zem.moto){}

    const moto: Moto = await this.motoService.findOne(createZemMotoDto.moto_id);
    if(moto.zem){}
    zemMoto.moto = moto;

    moto.zem = zem;
    await this.motoService.edit(moto.id, moto);

    zem.moto = moto;
    await this.zemService.changed(zem.id, zem);

    return this.zemMotoRepository.save(zemMoto);
  }

  createValidZemMoto(
    zemMoto: ZemMoto,
  ): Promise<ZemMoto> {
    return this.zemMotoRepository.save(zemMoto);
  }

  findAll(): Promise<ZemMoto[]> {
    return this.zemMotoRepository.find({
      relations: ['moto', 'propprietaire'],
    });
  }

  findOne(id: number): Promise<ZemMoto> {
    return this.zemMotoRepository.findOne(id, {
      relations:['moto', 'propprietaire'],
    });
  }

  findOneByZemAndMoto(zem_id: number, moto_id: number): Promise<ZemMoto> {
    const moto:Moto =new Moto(); moto.id = moto_id;
    const zem:Zem = new Zem(); zem.id = zem_id;
    return this.zemMotoRepository.findOne( {
      where:{
        moto:moto,
        zem:zem
      },
      order:{
        create_at: "DESC"
      },
    });
  }

  update(id: number, updateZemMotoDto: ZemMoto) {
    return this.zemMotoRepository.update(
      id,
      updateZemMotoDto,
    );
  }

  patch(id: number, updateZemMotoDto: ZemMoto) {
    return this.zemMotoRepository.update(
      id,
      updateZemMotoDto,
    );
  }

  remove(id: number) {
    return this.zemMotoRepository.delete(id);
  }
}
