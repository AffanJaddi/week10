# syntax=docker/dockerfile:1

FROM maven:3.9.7-eclipse-temurin-21 AS build
WORKDIR /app

COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./
RUN ./mvnw -q -B -DskipTests dependency:go-offline

COPY src ./src
RUN ./mvnw -q -B -DskipTests package

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 8081
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD curl -fsS http://localhost:8081/health || exit 1

ENTRYPOINT ["java","-jar","/app/app.jar"]
