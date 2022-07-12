/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import ormConfig from './config/ormconfig';

import { PrincipaleModule } from './principale/principale.module';
import { AuthModule } from './auth/auth.module';




@Module({
  imports: [
    TypeOrmModule.forRoot(ormConfig),
    PrincipaleModule,
    AuthModule,
  ],
  controllers: [AppController],
  providers: [
    AppService
  ],
})
export class AppModule {}
