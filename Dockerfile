FROM gradle:8.13-jdk23 AS builder
WORKDIR /app
COPY . /app
RUN chmod +x /app/gradlew
RUN /app/gradlew bootJar --no-daemon

FROM openjdk:23
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "/app/app.jar"]
