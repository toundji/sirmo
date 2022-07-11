/* eslint-disable prettier/prettier */
import { IsDateString, IsEmail, IsEnum, IsNotEmpty, IsNumberString, IsObject, IsOptional, IsPhoneNumber, IsPositive, IsString, MinLength, ValidateNested } from "class-validator";
import { ApiProperty } from "@nestjs/swagger";
import { CreateUserDto } from './create-user.dto';
import { Type } from "class-transformer";
import { IsNumber } from 'class-validator';
import { Genre } from "src/enums/genre";
import { Conducteur } from './../entities/conducteur.entity';

export class CreateUserConducteurCptDto {

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  @MinLength(13, {message: "Ifu invalide, Ifu trop court"})
  ifu: string;

  @MinLength(14, {message: "cip invalide, cip trop court"})
  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  cip: string;

  @MinLength(10, {message: "nip invalide, nip trop court"})
  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  nip: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  permis: string;

  @ApiProperty()
  @IsDateString({message:"Vous devez spécifier la date d'obtention de votre permis"})
  date_optention_permis: Date;

  @ApiProperty()
  @IsDateString({message:"Vous devez spécifier la date délivrance de votre ifu"})
  date_delivrance_ifu:Date;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  @IsOptional()
  idCarde: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message:"Seules les chiffres sont valides"})
  ancienIdentifiant: string;

  @ApiProperty({required:true})
  @IsNumberString({},{message : "Mairie non valide"})
  mairie_id:number;

  get conducteur(){
    return {
      ifu:this.ifu,nip: this.nip, cip:this.cip, permis:this.permis,
      date_optention_permis: this.date_optention_permis,
      date_delivrance_ifu: this.date_delivrance_ifu, idCarde: this.idCarde,
      ancienIdentifiant: this.ancienIdentifiant
    };
  }


  @ApiProperty({required:true})
  @IsString()
  @IsNotEmpty()
  nom: string;

  @ApiProperty({required:true})
  @IsString()
  @IsNotEmpty()
  prenom: string;

  @ApiProperty({required:true, default:Genre.MASCULIN})
  @IsEnum(Genre)
  genre: Genre;

  @ApiProperty({required:true})
  @IsString()
  @IsNotEmpty()
  password: string;


  @ApiProperty()
  @IsString()
  date_naiss: Date;

  @ApiProperty({required:true})
  @IsPhoneNumber("BJ")
  phone: string;

  @ApiProperty({required:true})
  @IsString()
  arrondissement: string;

  get user(){
    return {nom: this.nom, prenom: this.prenom, genre:this.genre, 
      password: this.password,date_naiss: this.date_naiss, phone:this.phone,
       arrondissement: this.arrondissement}
  }



}
