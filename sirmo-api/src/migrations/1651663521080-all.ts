import {MigrationInterface, QueryRunner} from "typeorm";

export class all1651663521080 implements MigrationInterface {
    name = 'all1651663521080'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "compte" DROP CONSTRAINT "FK_fe8b9e894bf80fbe677b14f9f8c"`);
        await queryRunner.query(`ALTER TABLE "payement" DROP CONSTRAINT "FK_77f9e3ac513490b55c462ef4bcb"`);
        await queryRunner.query(`ALTER TABLE "compte" ADD CONSTRAINT "UQ_fe8b9e894bf80fbe677b14f9f8c" UNIQUE ("id")`);
        await queryRunner.query(`ALTER TABLE "zem" DROP CONSTRAINT "FK_309eaf8e98ac9bfbca4b7ee2ea8"`);
        await queryRunner.query(`ALTER TABLE "licence" DROP CONSTRAINT "FK_3e58fa1214dda608751cb339f4a"`);
        await queryRunner.query(`ALTER TABLE "moto" DROP CONSTRAINT "FK_3b4b027222c3c8e455c25a547c6"`);
        await queryRunner.query(`ALTER TABLE "appreciation" DROP CONSTRAINT "FK_84112a071644374aa4ef5ae1058"`);
        await queryRunner.query(`ALTER TABLE "zem_moto" DROP CONSTRAINT "FK_ae11515b2c670c2f28dc6ea1fef"`);
        await queryRunner.query(`ALTER TABLE "amande" DROP CONSTRAINT "FK_73393aa0ce2d39f2d71a043e8bc"`);
        await queryRunner.query(`ALTER TABLE "zem" ADD CONSTRAINT "UQ_309eaf8e98ac9bfbca4b7ee2ea8" UNIQUE ("id")`);
        await queryRunner.query(`ALTER TABLE "police" DROP CONSTRAINT "FK_c8a3a10755aaad235fd9fbee699"`);
        await queryRunner.query(`ALTER TABLE "amande" DROP CONSTRAINT "FK_a9405e30e98c65fafec669c7893"`);
        await queryRunner.query(`ALTER TABLE "police" ADD CONSTRAINT "UQ_c8a3a10755aaad235fd9fbee699" UNIQUE ("id")`);
        await queryRunner.query(`ALTER TABLE "compte" ADD CONSTRAINT "FK_fe8b9e894bf80fbe677b14f9f8c" FOREIGN KEY ("id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "payement" ADD CONSTRAINT "FK_77f9e3ac513490b55c462ef4bcb" FOREIGN KEY ("compte_id") REFERENCES "compte"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "licence" ADD CONSTRAINT "FK_3e58fa1214dda608751cb339f4a" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "moto" ADD CONSTRAINT "FK_3b4b027222c3c8e455c25a547c6" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "appreciation" ADD CONSTRAINT "FK_84112a071644374aa4ef5ae1058" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "zem_moto" ADD CONSTRAINT "FK_ae11515b2c670c2f28dc6ea1fef" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "zem" ADD CONSTRAINT "FK_309eaf8e98ac9bfbca4b7ee2ea8" FOREIGN KEY ("id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "police" ADD CONSTRAINT "FK_c8a3a10755aaad235fd9fbee699" FOREIGN KEY ("id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "amande" ADD CONSTRAINT "FK_a9405e30e98c65fafec669c7893" FOREIGN KEY ("police_id") REFERENCES "police"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "amande" ADD CONSTRAINT "FK_73393aa0ce2d39f2d71a043e8bc" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "amande" DROP CONSTRAINT "FK_73393aa0ce2d39f2d71a043e8bc"`);
        await queryRunner.query(`ALTER TABLE "amande" DROP CONSTRAINT "FK_a9405e30e98c65fafec669c7893"`);
        await queryRunner.query(`ALTER TABLE "police" DROP CONSTRAINT "FK_c8a3a10755aaad235fd9fbee699"`);
        await queryRunner.query(`ALTER TABLE "zem" DROP CONSTRAINT "FK_309eaf8e98ac9bfbca4b7ee2ea8"`);
        await queryRunner.query(`ALTER TABLE "zem_moto" DROP CONSTRAINT "FK_ae11515b2c670c2f28dc6ea1fef"`);
        await queryRunner.query(`ALTER TABLE "appreciation" DROP CONSTRAINT "FK_84112a071644374aa4ef5ae1058"`);
        await queryRunner.query(`ALTER TABLE "moto" DROP CONSTRAINT "FK_3b4b027222c3c8e455c25a547c6"`);
        await queryRunner.query(`ALTER TABLE "licence" DROP CONSTRAINT "FK_3e58fa1214dda608751cb339f4a"`);
        await queryRunner.query(`ALTER TABLE "payement" DROP CONSTRAINT "FK_77f9e3ac513490b55c462ef4bcb"`);
        await queryRunner.query(`ALTER TABLE "compte" DROP CONSTRAINT "FK_fe8b9e894bf80fbe677b14f9f8c"`);
        await queryRunner.query(`ALTER TABLE "police" DROP CONSTRAINT "UQ_c8a3a10755aaad235fd9fbee699"`);
        await queryRunner.query(`ALTER TABLE "amande" ADD CONSTRAINT "FK_a9405e30e98c65fafec669c7893" FOREIGN KEY ("police_id") REFERENCES "police"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "police" ADD CONSTRAINT "FK_c8a3a10755aaad235fd9fbee699" FOREIGN KEY ("id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "zem" DROP CONSTRAINT "UQ_309eaf8e98ac9bfbca4b7ee2ea8"`);
        await queryRunner.query(`ALTER TABLE "amande" ADD CONSTRAINT "FK_73393aa0ce2d39f2d71a043e8bc" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "zem_moto" ADD CONSTRAINT "FK_ae11515b2c670c2f28dc6ea1fef" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "appreciation" ADD CONSTRAINT "FK_84112a071644374aa4ef5ae1058" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "moto" ADD CONSTRAINT "FK_3b4b027222c3c8e455c25a547c6" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "licence" ADD CONSTRAINT "FK_3e58fa1214dda608751cb339f4a" FOREIGN KEY ("zem_id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "zem" ADD CONSTRAINT "FK_309eaf8e98ac9bfbca4b7ee2ea8" FOREIGN KEY ("id") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "compte" DROP CONSTRAINT "UQ_fe8b9e894bf80fbe677b14f9f8c"`);
        await queryRunner.query(`ALTER TABLE "payement" ADD CONSTRAINT "FK_77f9e3ac513490b55c462ef4bcb" FOREIGN KEY ("compte_id") REFERENCES "compte"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
        await queryRunner.query(`ALTER TABLE "compte" ADD CONSTRAINT "FK_fe8b9e894bf80fbe677b14f9f8c" FOREIGN KEY ("id") REFERENCES "zem"("id") ON DELETE NO ACTION ON UPDATE NO ACTION`);
    }

}
