FROM maven:latest AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -DskipTests

FROM openjdk:8-jdk-alpine
COPY --from=build /home/app/target/*.jar application.jar
ENTRYPOINT ["java", "-Dserver.port=8090", "-jar", "application.jar"]