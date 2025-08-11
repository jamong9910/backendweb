# 1) 빌드 스테이지
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /workspace
COPY pom.xml .
COPY src ./src
# 테스트는 생략하고 빌드
RUN mvn -B -DskipTests package

# 2) 런타임 스테이지
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# 위에서 만든 jar만 복사
COPY --from=build /workspace/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
