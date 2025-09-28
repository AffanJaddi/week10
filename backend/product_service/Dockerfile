# syntax=docker/dockerfile:1

# ===== Build stage =====
FROM maven:3.9.7-eclipse-temurin-21 AS build
WORKDIR /app

# Copy Maven wrapper + pom first to cache deps
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./

# Cache dependencies (offline)
RUN ./mvnw -q -B -DskipTests dependency:go-offline

# Copy source and build
COPY src ./src
RUN ./mvnw -q -B -DskipTests package

# ===== Runtime (slim JRE) =====
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy the built jar (adjust if your jar name is fixed)
COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 8080

# Health endpoint — change if your app exposes something else
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD curl -fsS http://localhost:8080/health || exit 1

ENTRYPOINT ["java","-jar","/app/app.jar"]
