
FROM gradle:7.6.2-jdk17 AS build

WORKDIR /app

COPY . .

RUN gradle build -x test

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
