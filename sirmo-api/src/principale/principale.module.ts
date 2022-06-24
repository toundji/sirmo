/* eslint-disable prettier/prettier */
import { forwardRef, Module } from '@nestjs/common';
import { PrincipaleService } from './principale.service';
import { PrincipaleController } from './principale.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UserService } from './services/user.service';
import { User } from './entities/user.entity';
import { Role } from './entities/role.entity';
import { Commune } from './entities/commune.entity';
import { Arrondissement } from './entities/arrondissement.entity';
import { Licence } from './entities/licence.entity';
import { Mairie } from './entities/mairie.entity';
import { Departement } from './entities/departement.entity';
import { Moto } from './entities/moto.entity';
import { ProprietaireMoto } from './entities/proprietaire-moto.entity';
import { TypeAmande } from './entities/type-amande.entity';
import { Zem } from './entities/zem.entity';
import { TypeAmandeService } from './services/type-amande.service';
import { ArrondissementService } from './services/arrondissement.service';
import { CommuneService } from './services/commune.service';
import { LicenceService } from './services/licence.service';
import { MairieService } from './services/mairie.service';
import { DepartementService } from './services/departement.service';
import { RoleService } from './services/roles.service';
import { ProprietaireMotosService } from './services/proprietaire-motos.service';
import { MotoService } from './services/moto.service';
import { UserController } from './controllers/user.controller';
import { RolesController } from './controllers/roles.controller';
import { ArrondissementController } from './controllers/arrondissement.controller';
import { CommuneController } from './controllers/commune.controller';
import { LicenceController } from './controllers/licence.controller';
import { MairieController } from './controllers/mairie.controller';
import { DepartementController } from './controllers/departement.controller';
import { ProprietaireMotosController } from './controllers/proprietaire-motos.controller';
import { TypeAmandeController } from './controllers/type-amande.controller';
import { MotoController } from './controllers/motos.controller';
import { ZemService } from './services/zem.service';
import { ZemController } from './controllers/zem.controller';
import { Amande } from './entities/amande.entity';
import { Appreciation } from './entities/appreciation.entity';
import { Compte } from './entities/compte.entity';
import { Fichier } from './entities/fichier.entity';
import { Localisation } from './entities/localisation.entity';
import { Payement } from './entities/payement.entity';
import { Police } from './entities/police.entity';
import { ZemMoto } from './entities/zem-moto.entity';
import { ZemMotoService } from './services/zem-moto.service';
import { LocalisationService } from './services/localisation.service';
import { FichierService } from './services/fichier.service';
import { PoliceService } from './services/police.service';
import { AmandeService } from './services/amande.service';
import { PayementService } from './services/payement.service';
import { AmandeController } from './controllers/amande.controller';
import { AppreciationController } from './controllers/appreciation.controller';
import { FichierController } from './controllers/fichier.controller';
import { LocalisationController } from './controllers/localisation.controller';
import { PayementController } from './controllers/payement.controller';
import { PoliceController } from './controllers/police.controller';
import { ZemMotoController } from './controllers/zem-moto.controller';
import { AppreciationService } from './services/appreciation.service';
import { CompteService } from './services/compte.service';

import { AuthModule } from './../auth/auth.module';
import { SeederService } from './services/seeder.service';
import { SeedController } from './controllers/seeder.controller';
import { MulterModule } from '@nestjs/platform-express';
import { CompteController } from './controllers/compte.controller';



@Module({
  imports: [
    MulterModule.register({dest: './files'}),
    forwardRef(() =>AuthModule),
  TypeOrmModule.forFeature([
      User,
      Role,
      Arrondissement,
      Commune,
      Licence,
      Mairie,
      Departement,
      Moto,
      ProprietaireMoto,
      TypeAmande,
      Zem,
      Amande,
      Appreciation,
      Compte,
      Fichier,
      Localisation,
      Payement,
      Police,
      ZemMoto,
    ]),
  ],
  exports: [
    UserService,
    RoleService,
    ArrondissementService,
    CommuneService,
    LicenceService,
    MairieService,
    DepartementService,
    MotoService,
    ProprietaireMotosService,
    TypeAmandeService,
    ZemService,
    PrincipaleService,
    ZemMotoService,
    LocalisationService,
    FichierService,
    PoliceService,
    AmandeService,
    PayementService,
    CompteService,
    AppreciationService
  ],
  controllers: [
    PrincipaleController,
    UserController,
      RolesController,
      ArrondissementController,
      CommuneController,
      LicenceController,
      MairieController,
      DepartementController,
      MotoController,
      ProprietaireMotosController,
      TypeAmandeController,
      ZemController,
      AmandeController,
      AppreciationController,
      FichierController,
      LocalisationController,
      PayementController,
      PoliceController,
      ZemMotoController,
      SeedController,
      CompteController,
  ],
  providers: [
    SeederService,
    PrincipaleService,
    UserService,
    RoleService,
    ArrondissementService,
    CommuneService,
    LicenceService,
    MairieService,
    DepartementService,
    MotoService,
    ProprietaireMotosService,
    TypeAmandeService,
    ZemService,
    PrincipaleService,
    ZemMotoService,
    LocalisationService,
    FichierService,
    PoliceService,
    AmandeService,
    PayementService,
    AppreciationService,
    CompteService,
  ],
})
export class PrincipaleModule {}
