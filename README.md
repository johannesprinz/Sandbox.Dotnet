# Sandpit.Dotnet

My playground for playing with the latest dot net features

## Getting started

The [Dockerfile](./Dockerfile) is your source of truth for building and running this project.
For a developer quick start here are two options to get up and running and check for any feedback.

### Running on bare metal

Post every change you can run:
``` bash
docker build . --target build
```
to execute the continouse integration pipeline locally.

### Running within development container

1. Connect to the development container
1. Within the container terminal run:
   ```bash
   dotnet watch --project ./tests/Application.UnitTests/Application.UnitTests.csproj -- test
   ```
   to enable live unit testing.

## Whats next

- [ ] CI Pipeline in docker

## How we got here

🚧_as build documentation_🚧

1. Initialise project workspace
   - From WSL in my working directory
     ```bash
     mkdir SandpitDotnet
     cd Sandpit.Dotnet
     git init
     code .
     ```
1. Setup development environment
   - From within VSCode
     1. Initialise remote developmnent container configuration Ctrl + P + > +  Add development container
     1. Select c# > Dotnet 6 default > No additional options
     1. Adjust settings to move docker file to root.
1. Setup solution
   ``` bash
   dotnet new sln
   dotnet new classlib -n Application -o ./src/Application
   dotnet sln add ./src/Application/Application.csproj
   dotnet new xunit -n Application.UnitTests -o ./tests/Application.UnitTests
   dotnet sln add ./tests/Application.UnitTests/Application.UnitTests.csproj
   dotnet add ./tests/Application.UnitTests/Application.UnitTests.csproj reference ./src/Application/Application.csproj 
   dotnet add tests/Application.UnitTests/Application.UnitTests.csproj package Moq
   dotnet add tests/Application.UnitTests/Application.UnitTests.csproj package AutoFixture
   dotnet add tests/Application.UnitTests/Application.UnitTests.csproj package AutoFixture.AutoMoq
   dotnet add tests/Application.UnitTests/Application.UnitTests.csproj package FluentAssertions
   ```
1. Restored dependencies to lock in the versions to the target runtime
   ``` bash
   dotnet restore --use-lock-file --runtime linux-musl-x64
   ```
   