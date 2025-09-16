# Stage 1: Build the app with Maven
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
 
# Copy pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B
 
# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests
 
# Stage 2: Create runtime image
FROM eclipse-temurin:17-jdk
WORKDIR /app
 
# Copy built jar from builder stage
COPY --from=build /app/target/java-cicd-app-1.0.0.jar app.jar
 
# Expose port
EXPOSE 8080
 
# Run app
ENTRYPOINT ["java", "-jar", "app.jar"]