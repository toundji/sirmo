import {
  BadRequestException,
  HttpException,
  HttpStatus,
  Injectable,
  UnauthorizedException,
} from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import { compare } from "bcrypt";
import { LoginDto } from "src/auth/dto/login.dto";
import { User } from "src/principale/entities/user.entity";
import { UserService } from "src/principale/services/user.service";
import { PayloadDto } from "./../../dto/payload.dto";
import * as admin from 'firebase-admin';


@Injectable()
export class AuthService {
  constructor(
    private readonly userService: UserService,
    private readonly jwtService: JwtService,
  ) {}

  async valideUser({ pseudo }: any) {
    const user = await this.userService.findOneByPseudo(pseudo);
    if (!user) {
      throw new HttpException("Invalid token", HttpStatus.UNAUTHORIZED);
    }
    return user;
  }

  async notifyUser(token:string, data:any){
    const messaging = admin.messaging();    
    const message = {
      notification: {
        title: 'Connexion',
        body: 'Vous êtes connecté avec',
      },
      token: token
    };
    
    console.log(token);
   
    return await messaging.send(message)
      .then((response) => {
        console.log('Successfully sent message:', response);
      }).catch((error) => {
        console.log('Error sending message:', error);
        throw new BadRequestException("Nous ne parvenons pas à notifyer à l'utilisteur",error.message);
      });
  }
  async login(body: LoginDto) {
    const user = await this.userService.findOneByPseudo(body.username);

    if (!user) {
      throw new UnauthorizedException(
        "Numéro de téléphone ou mot de passe invalide",
      );
    }

    const areEqual = await compare(body.password, user.password);
    if (!areEqual) {
      throw new HttpException(
        "Nom d'utilisateur ou mot de passe invalide ",
        HttpStatus.UNAUTHORIZED,
      );
    }

    if(body.token && user.token != body.token){
      user.token = body.token;
      await User.save(user);
    }
     await this.notifyUser(user.token, {});

    // return user;
    const payload = { pseudo: user.phone, sub: user.id };
    const token = this.jwtService.sign(payload);
    return { user: user, token: token };
  }

  logout({ pseudo, sub }: PayloadDto) {
    const payload = { pseudo, sub };
    this.valideUser(payload);
  }
}
