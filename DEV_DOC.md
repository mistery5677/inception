# Developer Documentation (DEV_DOC)

This document provides the necessary instructions for developers to set up, build, and manage the Inception infrastructure from scratch.

---

## 1. Environment Setup

To run this project, you need a Debian/Ubuntu-based Virtual Machine.

### Prerequisites
Ensure the following tools are installed on your system:
* `make`
* `docker`
* `docker-compose`

**Host Configuration:** You must route the project's domain to your localhost. Open your `/etc/hosts` file (`sudo nano /etc/hosts`) and add the following line:

127.0.0.1    login.42.fr

---

## 2. Configuration file

The environment variables are managed through a .env file located in the srcs/ directory. This file should contain non-sensitive structural data. Example:

* DOMAIN_NAME=login.42.fr
* MYSQL_DATABASE=wordpress
* MYSQL_USER=user
* WP_TITLE=Inception
* WP_ADMIN_USER=super_miafonso
* # Add the remaining email and user variables here

---

## 3. Secrets Management

Passwords and highly sensitive data must not be exposed in the .env file or pushed to the repository.

* Create a secrets/ folder at the root of the project.

* Inside, create text files containing only the raw passwords (e.g., db_password.txt and db_root_password.txt).

* Ensure the secrets/ folder is added to your .gitignore.
* Docker Compose will inject these secrets securely into the containers at runtime.

## 4. Build and Launch

The entire infrastructure is automated and managed via the Makefile located at the root of the repository, which acts as a wrapper for Docker Compose.

### To build and start the project: Run make or make all.

        What it does: Creates the necessary local directories for data persistence, builds the Docker images from the provided Dockerfiles, and launches the containers in the background (docker-compose up -d --build).

### To stop the project: Run make down.

        What it does: Gracefully stops and removes the containers and the custom Docker network.

### To completely reset: Run make fclean.

        What it does: Stops everything, removes all images, deletes the Docker volumes, and permanently wipes the physical data folders on the host machine.

## 5. Container and Volume Management

Once the infrastructure is up, developers can use the following Docker commands to manage and debug the system:

* Check container status: docker ps (Ensure nginx, wordpress, and mariadb show as 'Up').

* Read application logs: docker logs [container_name] (e.g., docker logs wordpress is highly useful to debug PHP-FPM or WP-CLI installation steps).

* Enter a running container: docker exec -it [container_name] sh (Allows you to inspect internal files and configurations).

* List active volumes: docker volume ls.

* Inspect the custom network: docker network inspect inception_network.

## 6. Data Storage and Persistence

To ensure that the database records and website files survive container restarts, rebuilds, or crashes, the project uses Docker named volumes bound to specific local paths on the host machine.

### Database Persistence:

        Host Path: /home/login/data/mariadb

        Container Path: /var/lib/mysql

        Description: Stores all MariaDB schemas, tables, and user privileges.

### Website Persistence:

        Host Path: /home/login/data/wordpress

        Container Path: /var/www/html

        Description: Stores the downloaded WordPress core files, wp-config.php, uploaded media, and themes.

Even if the containers are destroyed using docker-compose down, the data remains intact in these host directories. Only running make fclean or manually deleting the folders (e.g., sudo rm -rf /home/login/data) will result in permanent data loss.
