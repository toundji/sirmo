/* eslint-disable prettier/prettier */
import 'dotenv/config'
import { PostgresConnectionOptions } from 'typeorm/driver/postgres/PostgresConnectionOptions';



const ormConfig:PostgresConnectionOptions = {
    type: 'postgres',
    url: process.env.DB_URL,
    ssl: { rejectUnauthorized: false },
    
    entities: ["dist/**/*.entity{.ts,.js}"],

    synchronize: true,
    migrations: ["dist/migrations/*.js"],
    cli: {
        migrationsDir: "src/migrations",
        entitiesDir: "src/**/*"
    }
};

export default ormConfig;