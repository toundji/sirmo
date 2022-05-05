import {MigrationInterface, QueryRunner} from "typeorm";

export class all1651747047902 implements MigrationInterface {
    name = 'all1651747047902'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "constantes" ("createur_id" integer NOT NULL, "editeur_id" integer NOT NULL, "create_at" TIMESTAMP NOT NULL DEFAULT now(), "update_at" TIMESTAMP NOT NULL DEFAULT now(), "id" SERIAL NOT NULL, "nom" character varying NOT NULL, "valeur" character varying NOT NULL, "description" character varying NOT NULL, CONSTRAINT "UQ_4e02b0084ff595edc6977113ed8" UNIQUE ("valeur"), CONSTRAINT "PK_30c7f1335efeff645b9676298be" PRIMARY KEY ("id"))`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP TABLE "constantes"`);
    }

}
