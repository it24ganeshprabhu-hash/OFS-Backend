# Stage 1: Build the application using Maven and Temurin JDK 17
FROM maven:3.8.5-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .

# FIX: Grant execute permission to the Maven wrapper
# This prevents the "Permission denied" (exit code: 126) error
RUN chmod +x mvnw

# Build the JAR and skip tests to save time and memory on Render
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the application using the lightweight Temurin JRE 17
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy the built JAR from the first stage
# Note: target/*.jar will grab the final compiled file
COPY --from=build /app/target/*.jar app.jar

# Expose the port your app runs on
EXPOSE 8081

# Command to start the app
# Use the PORT environment variable provided by Render
ENTRYPOINT ["java", "-jar", "app.jar"]
