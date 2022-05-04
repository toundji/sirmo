import { Test, TestingModule } from "@nestjs/testing";
import { PrincipaleService } from "./principale.service";

describe("PrincipaleService", () => {
  let service: PrincipaleService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PrincipaleService],
    }).compile();

    service = module.get<PrincipaleService>(PrincipaleService);
  });

  it("should be defined", () => {
    expect(service).toBeDefined();
  });
});
