FROM openjdk:21-jdk-slim

WORKDIR /app

COPY pom.xml ./

RUN apt-get update && \
    apt-get install -y maven && \
    mvn dependency:go-offline && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY src ./src

RUN mvn -B -DskipTests clean package

CMD ["java", "-jar", "target/movie-picker-1.0-SNAPSHOT.jar"]
