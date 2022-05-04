import { Test, TestingModule } from '@nestjs/testing';
import { PrincipaleController } from './principale.controller';
import { PrincipaleService } from './principale.service';

describe('PrincipaleController', () => {
  let controller: PrincipaleController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PrincipaleController],
      providers: [PrincipaleService],
    }).compile();

    controller = module.get<PrincipaleController>(PrincipaleController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
