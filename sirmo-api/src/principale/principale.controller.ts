import { Controller } from '@nestjs/common';
import { PrincipaleService } from './principale.service';

@Controller('principale')
export class PrincipaleController {
  constructor(private readonly principaleService: PrincipaleService) {}
}
