/* eslint-disable prettier/prettier */
import { ValidationError, ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';
import { BadRequestException } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix("/api")
  app.useGlobalPipes(
    new ValidationPipe({
      exceptionFactory: (errors: ValidationError[]) => new BadRequestException(errors),
    })
  )
 
  // eslint-disable-next-line prettier/prettier
  const config = new DocumentBuilder()
                .setTitle("SIRMO API")
                .setDescription("Système d'Identification RFID Mobile des conducteurs motos(Zems) au Bénin")
                .setVersion("1.0")
                .addTag("cast")
                .build();
    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup("/api/documentation",app, document);
  await app.listen(process.env.PORT || 3000, '0.0.0.0');
}
bootstrap();
