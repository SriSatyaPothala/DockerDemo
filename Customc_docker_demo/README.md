## Custom NGINX docker project 
This project builds a custom NGINX docker image that serves a local html file content and uses a bind mount at '/var/opt/nginx' inside the container.

## Project Structure
- Dockerfile
- docker-compose.yml
- index.html

## Dockerfile
The Dockerfile is based on nginx light weight image and copies a html file from local into the container.

## docker compose
The docker compose runs a single container which is nginx and has a volume bind from the local to '/var/opt/nginx'

## How to Run
- Make sure Docker and Docker- compose are installed .
- Use docker-compose up --build -d to run the project
- App is accessible at http://localhost:8080