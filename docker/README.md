# Docker Basics

A quick reference for the Docker commands I use most often.

---

# Check Docker Installation

Show Docker version:

```bash
docker --version
```

Show client and server information:

```bash
docker version
```

Display detailed system information:

```bash
docker info
```

---

# Images

List downloaded images:

```bash
docker images
```

or

```bash
docker image ls
```

Download an image:

```bash
docker pull ubuntu
```

Download a specific version:

```bash
docker pull ubuntu:24.04
```

Remove an image:

```bash
docker rmi ubuntu
```

Remove unused images:

```bash
docker image prune
```

Remove all unused images:

```bash
docker image prune -a
```

---

# Containers

List running containers:

```bash
docker ps
```

List all containers:

```bash
docker ps -a
```

Create and start a container:

```bash
docker run ubuntu
```

Run interactively:

```bash
docker run -it ubuntu bash
```

Run in the background:

```bash
docker run -d nginx
```

Assign a container name:

```bash
docker run -d --name web nginx
```

Automatically remove when stopped:

```bash
docker run --rm ubuntu
```

---

# Starting and Stopping Containers

Start a stopped container:

```bash
docker start web
```

Stop a running container:

```bash
docker stop web
```

Restart a container:

```bash
docker restart web
```

Pause a container:

```bash
docker pause web
```

Resume a container:

```bash
docker unpause web
```

Kill a container immediately:

```bash
docker kill web
```

---

# Removing Containers

Remove a stopped container:

```bash
docker rm web
```

Force removal:

```bash
docker rm -f web
```

Remove all stopped containers:

```bash
docker container prune
```

---

# Logs

View logs:

```bash
docker logs web
```

Follow logs live:

```bash
docker logs -f web
```

Show last 50 lines:

```bash
docker logs --tail 50 web
```

---

# Entering a Container

Open a shell:

```bash
docker exec -it web bash
```

Ubuntu/Debian usually have bash.

Alpine Linux:

```bash
docker exec -it alpine sh
```

Run a single command:

```bash
docker exec web ls /app
```

---

# Inspecting Containers

Inspect details:

```bash
docker inspect web
```

Show running processes:

```bash
docker top web
```

Show resource usage:

```bash
docker stats
```

Monitor one container:

```bash
docker stats web
```

---

# Port Mapping

Expose port 80 as 8080:

```bash
docker run -p 8080:80 nginx
```

Expose multiple ports:

```bash
docker run \
-p 8080:80 \
-p 8443:443 \
nginx
```

---

# Volumes

Create a named volume:

```bash
docker volume create mydata
```

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect mydata
```

Remove a volume:

```bash
docker volume rm mydata
```

Mount a named volume:

```bash
docker run -v mydata:/data ubuntu
```

Mount a host directory:

```bash
docker run -v /home/chris/data:/data ubuntu
```

Windows example:

```powershell
docker run -v C:\Data:/data ubuntu
```

---

# Networks

List networks:

```bash
docker network ls
```

Create a network:

```bash
docker network create mynetwork
```

Inspect a network:

```bash
docker network inspect mynetwork
```

Connect a container:

```bash
docker network connect mynetwork web
```

Disconnect a container:

```bash
docker network disconnect mynetwork web
```

---

# Environment Variables

Pass a variable:

```bash
docker run -e MYSQL_ROOT_PASSWORD=password mysql
```

Use an environment file:

```bash
docker run --env-file .env nginx
```

---

# Copy Files

Copy into a container:

```bash
docker cp config.txt web:/etc/nginx/
```

Copy from a container:

```bash
docker cp web:/etc/nginx/nginx.conf .
```

---

# Building Images

Build using current directory:

```bash
docker build -t myimage .
```

Specify a Dockerfile:

```bash
docker build -f Dockerfile.dev -t myimage .
```

Tag an image:

```bash
docker tag myimage username/myimage:v1
```

---

# Docker Hub

Login:

```bash
docker login
```

Push an image:

```bash
docker push username/myimage:v1
```

Pull an image:

```bash
docker pull username/myimage:v1
```

Logout:

```bash
docker logout
```

---

# Docker Compose

Start services:

```bash
docker compose up
```

Run in background:

```bash
docker compose up -d
```

Stop services:

```bash
docker compose down
```

Rebuild images:

```bash
docker compose up --build
```

Restart containers:

```bash
docker compose restart
```

View logs:

```bash
docker compose logs
```

Follow logs:

```bash
docker compose logs -f
```

List running services:

```bash
docker compose ps
```

Execute a command:

```bash
docker compose exec app bash
```

---

# Cleaning Up

Remove stopped containers:

```bash
docker container prune
```

Remove unused images:

```bash
docker image prune
```

Remove unused volumes:

```bash
docker volume prune
```

Remove unused networks:

```bash
docker network prune
```

Remove everything unused:

```bash
docker system prune
```

Remove absolutely everything unused:

```bash
docker system prune -a
```

---

# Saving and Loading Images

Save an image:

```bash
docker save -o nginx.tar nginx
```

Load an image:

```bash
docker load -i nginx.tar
```

---

# Useful Inspection Commands

Show Docker disk usage:

```bash
docker system df
```

Show image history:

```bash
docker history nginx
```

View image details:

```bash
docker image inspect nginx
```

View container details:

```bash
docker container inspect web
```

---

# Common Troubleshooting

## Container exits immediately

Check logs:

```bash
docker logs container_name
```

Inspect exit code:

```bash
docker inspect container_name
```

---

## Container won't start

View all containers:

```bash
docker ps -a
```

Attempt to restart:

```bash
docker restart container_name
```

---

## Check mapped ports

```bash
docker port container_name
```

---

## Check mounted volumes

```bash
docker inspect container_name
```

Look under:

* Mounts
* Volumes
* Bind mounts

---

## Remove everything and start fresh

```bash
docker system prune -a
docker volume prune
```

---

# Useful Workflow

## Download an image

```bash
docker pull nginx
```

## Run it

```bash
docker run -d \
--name nginx \
-p 8080:80 \
nginx
```

## Verify

```bash
docker ps
```

## View logs

```bash
docker logs nginx
```

## Enter the container

```bash
docker exec -it nginx bash
```

## Stop it

```bash
docker stop nginx
```

## Remove it

```bash
docker rm nginx
```

---

# Tips

* Use **named volumes** for persistent application data.
* Prefer **Docker Compose** for multi-container applications.
* Always pin image versions (e.g., `postgres:17` instead of `latest`) in production.
* Use `docker logs` before assuming an application is broken.
* Use `docker inspect` whenever you're unsure how a container is configured.
* Keep images small by using lightweight base images where practical (e.g., Alpine), but be aware they may not include common tools like `bash`.
* Regularly clean up unused containers, images, and volumes with the `prune` commands to reclaim disk space.

