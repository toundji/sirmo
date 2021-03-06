import { BadRequestException, forwardRef, Inject, Injectable, InternalServerErrorException, UploadedFile } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Vehicule } from '../../entities/vehicule.entity';
import { User } from '../../entities/user.entity';
import { Conducteur } from '../../entities/conducteur.entity';
import { UserService } from '../../services/user.service';
import { ProprietaireVehicule } from '../../entities/proprietaire-vehicule.entity';
import { ConducteurVehicule } from '../../entities/conducteur-vehicule.entity';
import { NotFoundException } from '@nestjs/common';
import { FichierService } from '../../services/fichier.service';
import { Fichier } from '../../entities/fichier.entity';
import { ConducteurService } from '../../services/conducteur.service';
import { ProprietaireVehiculesService } from '../../services/proprietaire-vehicule.service';
import { ConducteurVehiculeService } from '../../services/conducteur-vehicule.service';
import { CreateVehiculeDto } from '../../createDto/vehicule.dto';
import { TypePayementLicence } from 'src/enums/type-payement';
import { LicenceVehicule } from 'src/principale/entities/licence-vehicule.entity';
import { CreateVehiculeByConducteurDto } from 'src/principale/createDto/vehicule-by-conducteur.dto';
import { ConstanteService } from 'src/principale/services/constante.service';
import { Constante } from 'src/principale/entities/constante.entity';
import { LicenceProperty } from 'src/enums/licence-property';

@Injectable()
export class VehiculeAdminService {
  constructor(
    @InjectRepository(Vehicule) private vehiculeRepository: Repository<Vehicule>,
    private readonly userService:UserService,
    @Inject(forwardRef(() => ConducteurService))
    private readonly conducteurService:ConducteurService,
    @Inject(forwardRef(() => ProprietaireVehiculesService))
    private readonly proprietaireVehiculesService: ProprietaireVehiculesService,
    @Inject(forwardRef(() => ConducteurVehiculeService))
    private readonly conducteurVehiculeService:ConducteurVehiculeService,
    private readonly fichierService: FichierService,
    private readonly constanteService: ConstanteService,


  ) {}

  async create(createVehiculeDto: CreateVehiculeDto): Promise<Vehicule> {
    let vehicule: Vehicule = new Vehicule();
    Object.keys(createVehiculeDto).forEach((cle) => {
      vehicule[cle] = createVehiculeDto[cle];
    });
    const owner: User = await this.userService.findOne(createVehiculeDto.proprietaire.proprietaireId)
    vehicule.proprietaire = owner;

    const conducteur: Conducteur = await this.conducteurService.findOne(createVehiculeDto.conducteur.conducteur_id)
    vehicule.conducteur = conducteur;

      vehicule =await  this.vehiculeRepository.save(vehicule).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Les donn??es que nous avons r????ues ne sont celles que  nous esp??rons");
      });

     //update ConducteurVehicule if conducteur.vehicule is not null
    conducteur.vehicule = vehicule;
    
    this.conducteurService.update(conducteur.id,conducteur);
    let proprietaireVehicule:ProprietaireVehicule =  ProprietaireVehicule.fromMap({proprietaire: owner, vehicule:vehicule, date_debut:createVehiculeDto.proprietaire.date_debut, date_fin:createVehiculeDto.proprietaire.date_fin})
     proprietaireVehicule = await this.proprietaireVehiculesService.createValidProprietaireVehicule(proprietaireVehicule);
     proprietaireVehicule.vehicule = null;

    const conducteurVehicule: ConducteurVehicule = ConducteurVehicule.create({
        conducteur: conducteur,
        vehicule:vehicule, 
        date_debut:createVehiculeDto.conducteur.date_debut,
        date_fin:createVehiculeDto.conducteur.date_fin
      })
    
      await this.conducteurVehiculeService.createValidConducteurVehicule(conducteurVehicule);
    conducteurVehicule.vehicule = null;
    vehicule.conducteur.vehicule = null;
    return vehicule;

  }

  async createByConducteur(motDto: CreateVehiculeByConducteurDto): Promise<Vehicule> {
    let vehicule: Vehicule = new Vehicule();
    Object.keys(motDto).forEach((cle) => {
      vehicule[cle] = motDto[cle];
    });

    const licencePrice:Constante = await this.constanteService.searchFirst({nom: LicenceProperty.PRIX_LICENCE}).catch((error)=>{
      throw new InternalServerErrorException("Une errerur au prix de la licence s'est produit");
    })
    const licenceDuration:Constante = await this.constanteService.searchFirst({nom: LicenceProperty.DUREE_DUREE}).catch((error)=>{
      throw new InternalServerErrorException("Une errerur li??e ?? la dur??e de la licence s'est produit");
    })
    const conducteur: Conducteur = await this.conducteurService.findOne(+motDto.conducteur_id)
    vehicule.conducteur = conducteur;
      vehicule =await  this.vehiculeRepository.save(vehicule).catch((error)=>{
        console.log(error);
        throw new BadRequestException("Mise ?? jour de la vehicule. Donn??es invalides");
      });

     //update ConducteurVehicule if conducteur.vehicule is not null
    conducteur.vehicule = vehicule;
    this.conducteurService.update(conducteur.id,conducteur);

    let owner: User;
    if(motDto.proprietaire_id)
    {
      owner = await this.userService.findOne(motDto.proprietaire_id)
      vehicule.proprietaire = owner;
    }else{
      owner = conducteur.user;
      vehicule.proprietaire = owner;
    } 

    let proprietaireVehicule:ProprietaireVehicule =  ProprietaireVehicule.create({
      proprietaire: {id:owner.id},
      vehicule:{id:vehicule.id},
      date_debut: new Date(),
    });
     proprietaireVehicule = await ProprietaireVehicule.save(proprietaireVehicule).catch((error)=>{
      console.log(error);
      throw new InternalServerErrorException("Erreur pendant la sauvegarde du propri??taire de la vehicule");
     });let conducteurVehicule: ConducteurVehicule = ConducteurVehicule.create({
      conducteur: {id:conducteur.id},
      vehicule:{id:vehicule.id},
      date_debut: new Date(),
    });
    conducteurVehicule =   await ConducteurVehicule.save(conducteurVehicule).catch((error)=>{
        throw new InternalServerErrorException("Erreur pendant la sauvegarde de l'association (conducteur et vehicule)");

      })

    proprietaireVehicule.vehicule = null;
    conducteurVehicule.vehicule = null;

    vehicule.proprietaireVehicules = [proprietaireVehicule]
    vehicule.conducteurVehicules = [conducteurVehicule];

    vehicule.conducteur.vehicule = null;

    const now = new Date();

    const licenceTmp:LicenceVehicule = LicenceVehicule.create({
      montant: +licencePrice.valeur,
      solde_mairie: conducteur.mairie.solde,
      date_fin: new Date(now.getFullYear(), +licenceDuration.valeur+now.getMonth(), now.getDate(), now.getHours(), now.getMinutes(), now.getSeconds(), now.getMilliseconds()),
      conducteur: conducteur,
      vehicule: vehicule,
      mairie: conducteur.mairie,
      type_payement: TypePayementLicence.MANUEL
    });

    const licence: LicenceVehicule =   await LicenceVehicule.save(licenceTmp).catch((error)=>{
      console.log(error);
      throw "Erreur de cr??ation de la licence";
    });
    licence.vehicule = null;
    licence.mairie = null;
    licence.conducteur =null;
    
    vehicule.licence = licence;
    vehicule = await Vehicule.save(vehicule);
   

    return vehicule;

  }



  findByCi_er(ci_er: string) :Promise<Vehicule> {
    return this.vehiculeRepository.find({where:{ci_er: ci_er}}).then((list:Vehicule[])=>{
      if(list.length>0){ return list[0]; }
    }).catch((error)=>{
      console.log(error);
      throw new NotFoundException("Le payement sp??cifi?? n'existe pas");
    });
  }
  update(id: number, vehicule: Vehicule) {
    
      return this.vehiculeRepository.update(id, vehicule ).catch((error)=>{
        console.log(error);
        throw new NotFoundException("Le payement sp??cifi?? n'existe pas");
      });

    
  }

  remove(id: number) {
   
      return this.vehiculeRepository.delete(id).catch((error) =>{
        console.log(error);
        throw new NotFoundException("Le payement sp??cifi?? n'existe pas");
      
      });

    }
}
