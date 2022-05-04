import { HttpException, HttpStatus, Injectable, Logger } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import { compare } from "bcrypt";
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
    Logger.log(pseudo);
    const user = await this.userService.findOneByPseudo(pseudo);
    if (!user) {
      throw new HttpException("Invalid token", HttpStatus.UNAUTHORIZED);
    }
    return user;
  }
  async login({ username, password }: any) {
    const user = await this.userService.findOneByPseudo(username);

    if (!user) {
      throw new HttpException(
        "Impossible de trouver l'utilisateur avec le pseudo",
        HttpStatus.UNAUTHORIZED,
      );
    }

    const areEqual = await compare(password, user.password);
    if (!areEqual) {
      throw new HttpException(
        "Nom d'utilisateur ou mot de passe invalide ",
        HttpStatus.UNAUTHORIZED,
      );
    }

    // return user;
    const payload = { pseudo: user.tel, sub: user.id };
    const token = this.jwtService.sign(payload);
    return { user: user, token: token };
  }

  logout({ pseudo, sub }: PayloadDto) {
    const payload = { pseudo, sub };
    this.valideUser(payload);
  }
}
