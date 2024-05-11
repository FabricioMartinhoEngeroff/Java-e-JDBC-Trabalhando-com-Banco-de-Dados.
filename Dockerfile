# Use the official OpenJDK 17 image as base image
FROM openjdk:17 as build
# Set the working directory in the container
WORKDIR /workspace
# Copy the Maven pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
# Download dependencies
RUN ./mvnw dependency:go-offline
# Copy the rest of the application
COPY src src
# Package the application
RUN ./mvnw package -DskipTests
# Start with a base image containing Java runtime
FROM openjdk:17-jdk-slim
# Make port 8083 available to the world outside this container
EXPOSE 8083
# Set the working directory in the container
WORKDIR /app
# Copy the jar file from the build stage
COPY --from=build /workspace/target/*.jar app.jar
# Run the jar file
ENTRYPOINT ["java","-jar","/app/app.jar"]
