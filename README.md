# Sandpit.Dotnet

My playground for playing with the latest dot net features


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