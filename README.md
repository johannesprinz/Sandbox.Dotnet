# Sandpit.Dotnet

My playground for playing with the latest dot net features

## Whats next

- [ ] Build container
- [ ] Init Solution
  - [ ] Init Application.Test project
    - [ ] With XUnit, Moq, FluentAssertions, AllowNullsOff, TreatWarningsAsErrors on
  - [ ] Init Application project
    - [ ] With AllowNullsOff, TreatWarningsAsErrors on
  - [ ] Add ref to Application.Test project form Application project
  - [ ] Add first test
    - CRUD Stuff
      - [ ] Application needs a list of projects
      - [ ] Need to be able to add to that list
      - [ ] Need to be able to retrieve from that list
        - [ ] What is a valid/invalid project 
    - Workflow 
      - [ ] What do we then do with the project?

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