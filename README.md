# Inception - 42 Project

## 📖 Overview
This project is an introduction to system administration and virtualization using **Docker**. The goal is to broaden our knowledge of system architecture by setting up a small personal infrastructure composed of different services running in independent containers.

All services are built from scratch using Debian as a base image, and the entire infrastructure is deployed using `docker compose`.

## 🏗️ Architecture
The infrastructure runs on a single Virtual Machine and is composed of three main interconnected containers, operating on a custom Docker network:

1. **NGINX**: The only entry point to the infrastructure. It acts as a web server, configured to only accept secure connections (HTTPS using TLSv1.2 or TLSv1.3) on port 443.
2. **WordPress + PHP-FPM**: The backend application. It listens on port 9000 to process PHP requests forwarded by NGINX. It doesn't have direct web access.
3. **MariaDB**: The database server. It securely stores WordPress data and is completely isolated from the outside world. It only communicates with the WordPress container.

### 💾 Storage (Volumes)
To ensure data persistence even if containers are destroyed, the project uses two Docker volumes mapped to the host machine:
* **WordPress Volume**: Stores the website files (`/home/login/data/wordpress`).
* **MariaDB Volume**: Stores the database records (`/home/login/data/mariadb`).

## ⚙️ Prerequisites
Before running this project, ensure you have the following installed on your host machine:
* `make`
* `docker`
* `docker-compose` (or `docker compose` plugin)

**Important**: You must modify your `/etc/hosts` file to point the domain `login.42.fr` to your local IP address `127.0.0.1`.

## 🚀 How to Run

This project includes a `Makefile` to easily manage the containers.

* **`make`** or **`make all`**: Builds the images, creates the directories for the volumes, and starts the containers in detached mode.
* **`make down`**: Stops and removes the containers and network.
* **`make clean`**: Stops the containers and removes the images.
* **`make fclean`**: Performs a full cleanup. Stops containers, removes images, deletes the Docker volumes, and removes the physical data folders on the host.
* **`make re`**: Executes `fclean` followed by `all`, effectively rebuilding the infrastructure from scratch.

Once the containers are up and running, access the website via your browser at:
👉 **https://miafonso.42.fr**