/* eslint-disable prettier/prettier */
import { ValidationError, ValidationPipe } from '@nestjs/common';
import { NestFactory, Reflector } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';
import { BadRequestException } from '@nestjs/common';
import { writeFileSync } from 'fs';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { AppValidationError } from './principale/utilis/api-validation-error';


async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.setGlobalPrefix("/api")
  app.useGlobalPipes(
    new ValidationPipe({
      exceptionFactory: (errors: ValidationError[]) => {
        const erreur:AppValidationError = new AppValidationError();
        erreur.type = "VALIDATION";
        erreur.statusCode = 400;
        erreur.message="Les données ne sont pas celle espérer";
        erreur.validations = {};
        console.log("ok here");
       errors.forEach((error)=>{
        erreur.validations[error.property] = Object.values(error.constraints);
       });
       return new BadRequestException(erreur);
      }
    })
  );
  app.enableCors({ origin: true });
  const config = new DocumentBuilder()
                .setTitle("SIRMO API")
                .setDescription("Système d'Identification RFID Mobile des conducteurs motos(Zems) au Bénin")
                .setVersion("1.0")
                .addTag("cast")
                .addBearerAuth(
                  {
                    type: 'http',
                    scheme: 'bearer',
                    bearerFormat: 'JWT',
                    name: 'JWT',
                    description: 'Enter JWT token',
                    in: 'header',
                  },
                  'token', // This name here is important for matching up with @ApiBearerAuth() in your controller!
                ).build();
    const document = SwaggerModule.createDocument(app, config);
    const reflector = app.get(Reflector);
    app.useGlobalGuards(new JwtAuthGuard(reflector));
    SwaggerModule.setup("/api/doc",app, document);
    writeFileSync('./swagger.json', JSON.stringify(document));
  await app.listen(process.env.PORT || 3000);
}
bootstrap();
