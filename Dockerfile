# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
# This builds the JAR and skips tests to save time on the free tier
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:17-jdk-slim
WORKDIR /app
# Copy the built JAR from the first stage
COPY --from=build /app/target/*.jar app.jar
# Expose the port your app runs on
EXPOSE 8081
# Command to start the app
ENTRYPOINT ["java", "-jar", "app.jar"]
