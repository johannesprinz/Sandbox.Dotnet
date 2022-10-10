# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.2/containers/dotnet/.devcontainer/base.Dockerfile

# [Choice] .NET version: 6.0, 3.1, 6.0-bullseye, 3.1-bullseye, 6.0-focal, 3.1-focal
ARG VARIANT="6.0-bullseye-slim"
ARG VERSION="6.0-alpine3.16"
# https://learn.microsoft.com/en-us/dotnet/core/rid-catalog
ARG CONFIGURATION="Release"

FROM mcr.microsoft.com/vscode/devcontainers/dotnet:0-${VARIANT} AS development

FROM mcr.microsoft.com/dotnet/sdk:$VERSION AS build
WORKDIR /code

## Build Application Project
COPY src/Application/packages.lock.json src/Application/packages.lock.json
COPY src/Application/Application.csproj src/Application/Application.csproj
RUN dotnet restore \
    src/Application/Application.csproj \
    --locked-mode

COPY src/Application/. src/Application/
RUN dotnet build \
    src/Application/Application.csproj \
    --configuration $CONFIGURATION \
    --no-restore

## Build Application.UnitTest Project
COPY tests/Application.UnitTests/packages.lock.json tests/Application.UnitTests/packages.lock.json
COPY tests/Application.UnitTests/Application.UnitTests.csproj tests/Application.UnitTests/Application.UnitTests.csproj
RUN dotnet restore \
    tests/Application.UnitTests/Application.UnitTests.csproj \
    --locked-mode

COPY tests/Application.UnitTests/. tests/Application.UnitTests/
RUN dotnet build \
    tests/Application.UnitTests/Application.UnitTests.csproj \
    --configuration $CONFIGURATION \
    --no-restore

FROM build AS test

RUN dotnet test \
    tests/Application.UnitTests/Application.UnitTests.csproj \
    --configuration $CONFIGURATION \
    --no-restore \
    --no-build \
    --logger "trx;logfilename=testResults.trx" \
    --collect:"XPlat Code Coverage"

FROM test as publish

RUN dotnet publish \
    ./src/Application/Application.csproj \
    --configuration $CONFIGURATION \
    --no-restore \
    --no-build \
    --output published

# Finalize image
FROM mcr.microsoft.com/dotnet/aspnet:$VERSION AS run

#RUN apk add --no-cache icu-libs
#RUN apk add --no-cache libgdiplus --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

WORKDIR /app
COPY --from=build /app/src/published ./

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false
ENV DOTNET_RUNNING_IN_CONTAINER=true
ENV ASPNETCORE_URLS=http://+:5000
ENV COMPlus_EnableDiagnostics=0
EXPOSE 5000

RUN addgroup -S applicationRunners && adduser -S applicationRunner -G applicationRunners
USER applicationRunner

ENTRYPOINT ["dotnet", "Application.dll"]
