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
import { Vehicule } from './entities/vehicule.entity';
import { ProprietaireVehicule } from './entities/proprietaire-vehicule.entity';
import { TypeAmande } from './entities/type-amande.entity';
import { Conducteur } from './entities/conducteur.entity';
import { TypeAmandeService } from './services/type-amande.service';
import { ArrondissementService } from './services/arrondissement.service';
import { CommuneService } from './services/commune.service';
import { LicenceService } from './services/licence.service';
import { MairieService } from './services/mairie.service';
import { DepartementService } from './services/departement.service';
import { RoleService } from './services/roles.service';
import { ProprietaireVehiculesService } from './services/proprietaire-vehicule.service';
import { VehiculeService } from './services/vehicule.service';
import { UserController } from './controllers/user.controller';
import { RolesController } from './controllers/roles.controller';
import { ArrondissementController } from './controllers/arrondissement.controller';
import { CommuneController } from './controllers/commune.controller';
import { LicenceController } from './controllers/licence.controller';
import { MairieController } from './controllers/mairie.controller';
import { DepartementController } from './controllers/departement.controller';
import { TypeAmandeController } from './controllers/type-amande.controller';
import { ConducteurService } from './services/conducteur.service';
import { ConducteurController } from './controllers/conducteur.controller';
import { Amande } from './entities/amande.entity';
import { Appreciation } from './entities/appreciation.entity';
import { Compte } from './entities/compte.entity';
import { Fichier } from './entities/fichier.entity';
import { Localisation } from './entities/localisation.entity';
import { Payement } from './entities/payement.entity';
import { Police } from './entities/police.entity';
import { ConducteurVehicule } from './entities/conducteur-vehicule.entity';
import { ConducteurVehiculeService } from './services/conducteur-vehicule.service';
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
import { ConducteurVehiculeController } from './controllers/conducteur-vehicule.controller';
import { AppreciationService } from './services/appreciation.service';
import { CompteService } from './services/compte.service';

import { AuthModule } from './../auth/auth.module';
import { SeederService } from './services/seeder.service';
import { SeedController } from './controllers/seeder.controller';
import { MulterModule } from '@nestjs/platform-express';
import { CompteController } from './controllers/compte.controller';
import { Constante } from './entities/constante.entity';
import { ConstanteService } from './services/constante.service';
import { ProprietaireVehiculesController } from './controllers/proprietaire-vehicule.controller';
import { VehiculeController } from './controllers/vehicule.controller';
import { VehiculeAdminService } from './admin/services/vehicule-admin.service';
import { UserAdminService } from './admin/services/user-admin.service';
import { UserAdminController } from './admin/controllers/user-admin-controller.dto';
import { ConducteurAdminController } from './admin/controllers/conducteur-admin.controller';
import { VehiculeAdminController } from './admin/controllers/vehicule-admin.controller.dto';
import { ConducteurAdminService } from './admin/services/conducteur-admin.service';
import { LicenceVehiculeService } from './services/licence-vehicule.service';
import { LicenceVehiculeController } from './controllers/licence-vehicule.controller';
import { LicenceVehicule } from './entities/licence-vehicule.entity';
import { ConstanteController } from './controllers/constante.controller';



@Module({
  imports: [
    MulterModule.register({dest: './files'}),
    forwardRef(() =>AuthModule),
    TypeOrmModule.forFeature([
      User,
      Arrondissement,
      Commune,
      Licence,
      Mairie,
      Departement,
      Vehicule,
      ProprietaireVehicule,
      TypeAmande,
      Conducteur,
      Amande,
      Appreciation,
      Compte,
      Fichier,
      Localisation,
      LicenceVehicule,
      Payement,
      Police,
      ConducteurVehicule,
      Constante,
    ]),
  ],
  exports: [
    UserService,
    ArrondissementService,
    CommuneService,
    LicenceService,
    MairieService,
    DepartementService,
    VehiculeService,
    ProprietaireVehiculesService,
    TypeAmandeService,
    ConducteurService,
    PrincipaleService,
    ConducteurVehiculeService,
    LocalisationService,
    FichierService,
    PoliceService,
    AmandeService,
    PayementService,
    CompteService,
    AppreciationService,
    ConstanteService,
    LicenceVehiculeService,
  ],
  controllers: [
    PrincipaleController,
    UserController,
      // LicenceController,
      MairieController,
      VehiculeController,
      ProprietaireVehiculesController,
      TypeAmandeController,
      ConducteurController,
      AmandeController,
      AppreciationController,
      FichierController,
      LocalisationController,
      PayementController,
      PoliceController,
      ConducteurVehiculeController,
      CompteController,
      UserAdminController,
      ConducteurAdminController,
      VehiculeAdminController,
      LicenceVehiculeController,
      ArrondissementController,
      CommuneController,
      DepartementController,
      SeedController,
      RolesController,
      ConstanteController,

  ],
  providers: [
    SeederService,
    PrincipaleService,
    UserService,
    UserAdminService,
    ArrondissementService,
    CommuneService,
    LicenceService,
    LicenceVehiculeService,
    MairieService,
    DepartementService,
    VehiculeService,
    VehiculeAdminService,
    ProprietaireVehiculesService,
    TypeAmandeService,
    ConducteurService,
    PrincipaleService,
    ConducteurVehiculeService,
    LocalisationService,
    FichierService,
    PoliceService,
    AmandeService,
    PayementService,
    AppreciationService,
    CompteService,
    ConstanteService,
    ConducteurAdminService
  ],
})
export class PrincipaleModule {}
