# Sandpit.Dotnet

My playground for playing with the latest dot net features

## Whats next

- [ ] CI Pipeline in docker

## How we got here
(as build documentation)

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
