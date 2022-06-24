import {MigrationInterface, QueryRunner} from "typeorm";

export class zemPlus1656072226370 implements MigrationInterface {
    name = 'zemPlus1656072226370'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "comptes" DROP CONSTRAINT "FK_f1e9bf900b9220f91b487aeeefd"`);
        await queryRunner.query(`ALTER TABLE "comptes" DROP CONSTRAINT "UQ_a25da8f2af978f66c38717a8db4"`);
        await queryRunner.query(`ALTER TABLE "comptes" DROP COLUMN "cip"`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD "createur_id" integer`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD "editeur_id" integer`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD "created_at" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD "updated_at" TIMESTAMP NOT NULL DEFAULT now()`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD "deleted_at" TIMESTAMP`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD "total_in" integer NOT NULL`);
        await queryRunner.query(`ALTER TABLE "payements" ADD "info" character varying NOT NULL`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD CONSTRAINT "FK_f1e9bf900b9220f91b487aeeefd" FOREIGN KEY ("id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "comptes" DROP CONSTRAINT "FK_f1e9bf900b9220f91b487aeeefd"`);
        await queryRunner.query(`ALTER TABLE "payements" DROP COLUMN "info"`);
        await queryRunner.query(`ALTER TABLE "comptes" DROP COLUMN "total_in"`);
        await queryRunner.query(`ALTER TABLE "comptes" DROP COLUMN "deleted_at"`);
        await queryRunner.query(`ALTER TABLE "comptes" DROP COLUMN "updated_at"`);
        await queryRunner.query(`ALTER TABLE "comptes" DROP COLUMN "created_at"`);
        await queryRunner.query(`ALTER TABLE "comptes" DROP COLUMN "editeur_id"`);
        await queryRunner.query(`ALTER TABLE "comptes" DROP COLUMN "createur_id"`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD "cip" character varying NOT NULL`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD CONSTRAINT "UQ_a25da8f2af978f66c38717a8db4" UNIQUE ("cip")`);
        await queryRunner.query(`ALTER TABLE "comptes" ADD CONSTRAINT "FK_f1e9bf900b9220f91b487aeeefd" FOREIGN KEY ("id") REFERENCES "zems"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

}
