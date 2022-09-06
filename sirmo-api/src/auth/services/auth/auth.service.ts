import {
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
