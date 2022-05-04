/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { RoleService } from './roles.service';
import { DepartementService } from './departement.service';
import { TypeAmandeService } from './type-amande.service';
import { UserService } from 'src/principale/services/user.service';

@Injectable()
export class SeederService {
    constructor(private readonly roleService: RoleService, 
        private readonly departementService: DepartementService,
        private readonly typeAmandeService : TypeAmandeService, 
        private readonly userService : UserService, 

        ){}

    async seed(){
       await this.roleService.init();
       await this.departementService.initDepComAr();
       await this.typeAmandeService.init();
       await this.userService.initOneAdmin();
    }

    async grantAll(){
        await this.userService.grandAllRole();
     }

    

//     @Post('upload')
//   @UseInterceptors(FileInterceptor('file'))
//   uploadSingleFileWithPost(@UploadedFile() file, @Body() body) {
//     console.log(file);
//     console.log(body.firstName);
//     console.log(body.favoriteColor);
//   }
}
