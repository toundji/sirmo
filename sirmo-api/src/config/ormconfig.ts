/* eslint-disable prettier/prettier */
import 'dotenv/config'
import { PostgresConnectionOptions } from 'typeorm/driver/postgres/PostgresConnectionOptions';



const ormConfig:PostgresConnectionOptions = {
    type: 'postgres',
    url: process.env.DB_URL,
    ssl: {
        rejectUnauthorized: false
    },
    // host: process.env.DATABASE_HOST,
    // port: (process.env.DATABASE_PORT as any) as number,
    // username: process.env.DATABASE_USER,
    // password: process.env.DATABASE_PASSWORD,
    // database: process.env.DATABASE_NAME,
    entities: ["dist/**/*.entity{.ts,.js}"],

    synchronize: false,
    migrations: ["dist/migrations/*.js"],
    cli: {
        migrationsDir: "src/migrations",
        entitiesDir: "src/**/*"
    }
};

export default ormConfig;