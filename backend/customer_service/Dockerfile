# syntax=docker/dockerfile:1

# ===== Build stage =====
FROM maven:3.9.7-eclipse-temurin-21 AS build
WORKDIR /app

# Copy Maven wrapper + pom first to cache dependencies
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./

# Download dependencies (offline cache)
RUN ./mvnw -q -B -DskipTests dependency:go-offline

# Copy source and build the jar
COPY src ./src
RUN ./mvnw -q -B -DskipTests package

# ===== Runtime stage (slim JRE) =====
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy built artifact (adjust if your jar name is fixed)
COPY --from=build /app/target/*.jar /app/app.jar

# Service port (change if your app uses a different one)
EXPOSE 8082

# Healthcheck (change path if needed)
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD curl -fsS http://localhost:8082/health || exit 1

ENTRYPOINT ["java","-jar","/app/app.jar"]
