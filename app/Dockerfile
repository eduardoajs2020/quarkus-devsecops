# Etapa 1: build nativo usando imagem com suporte ao GraalVM
FROM quay.io/quarkus/ubi-quarkus-native-image:22.3-java17 AS build
COPY . /project
WORKDIR /project
RUN ./mvnw clean package -Pnative -DskipTests

# Etapa 2: imagem final minimalista com binário nativo
FROM scratch
COPY --from=build /project/target/*-runner /app
EXPOSE 8080
ENTRYPOINT ["/app"]
