import { Global, Module } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import * as admin from 'firebase-admin'
import * as path from 'path';



@Global()
@Module({})
export class ApiFirebaseModule {
    constructor(configService: ConfigService) {
        admin.initializeApp({
          credential: admin.credential.cert(path.join(__dirname, '../firebase.json')),
          databaseURL: configService.get<string>('FIREBASE_DABASE_URL'),
        })
      }
}
