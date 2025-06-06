# Usa una imagen oficial de Maven para compilar
FROM maven:3.8.5-openjdk-17 AS builder

WORKDIR /app

# Copia el proyecto y compílalo
COPY . .
RUN mvn clean package -DskipTests

# Usa una imagen mínima para ejecutar la app
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copia el JAR desde la etapa anterior
COPY --from=builder /app/target/mini-project-0.1-SNAPSHOT.jar app.jar

# Puerto (opcional)
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "app.jar"]
