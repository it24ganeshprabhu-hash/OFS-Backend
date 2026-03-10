# Stage 1: Build the application using Maven and Temurin JDK 17
FROM maven:3.8.5-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
# Build the JAR and skip tests to save time and memory on Render
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the application using the lightweight Temurin JRE 17
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Copy the built JAR from the first stage
COPY --from=build /app/target/*.jar app.jar
# Expose the port your app runs on
EXPOSE 8081
# Command to start the app
ENTRYPOINT ["java", "-jar", "app.jar"]
