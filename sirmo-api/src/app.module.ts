/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import ormConfig from './config/ormconfig';

import { PrincipaleModule } from './principale/principale.module';
import { AuthModule } from './auth/auth.module';
import { ApiFirebaseModule } from './firebase/api-firebase.module';
import { ConfigModule } from '@nestjs/config';




@Module({
  imports: [
    TypeOrmModule.forRoot(ormConfig),
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    
    ApiFirebaseModule,

    PrincipaleModule,
    AuthModule,
  ],
  controllers: [AppController],
  providers: [
    AppService
  ],
})
export class AppModule {}
