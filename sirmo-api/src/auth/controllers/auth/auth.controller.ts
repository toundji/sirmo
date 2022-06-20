import { Body, Controller, Get, Post, Req, UseGuards } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { ApiTags } from "@nestjs/swagger";
import { Public } from "src/auth/public-decore";
import { AuthService } from "src/auth/services/auth/auth.service";
import { LoginDto } from "./../../dto/login.dto";
import { LoginRespo } from "./../../dto/login-respo.dto";

@ApiTags("Auth")
@Controller("auth")
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post("login")
  @Public()
  login(@Body() body: LoginDto): Promise<LoginRespo> {
    return this.authService.login(body);
  }
}
