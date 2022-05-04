import { forwardRef, Module } from "@nestjs/common";
import { JwtModule } from "@nestjs/jwt";
import { PassportModule } from "@nestjs/passport";
import { PrincipaleModule } from "src/principale/principale.module";
import { AuthService } from "./services/auth/auth.service";
import { JwtStrategy } from "./services/jwt.strategy";
import { AuthController } from "./controllers/auth/auth.controller";
import "dotenv/config";

@Module({
  imports: [
    forwardRef(() => PrincipaleModule),
    PassportModule.register({
      defaultStrategy: "jwt",
      property: "user",
      session: false,
    }),
    JwtModule.register({
      secret: process.env.JWT_SECRET,
      signOptions: { expiresIn: "1d" },
    }),
  ],
  providers: [AuthService, JwtStrategy],
  exports: [PassportModule, JwtModule],
  controllers: [AuthController],
})
export class AuthModule {}
