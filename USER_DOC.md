# User Documentation (USER_DOC)

Welcome to the Inception project! This guide will explain, in simple terms, how to use and manage your new web infrastructure.

---

## 1. Services Provided by the Stack

This infrastructure provides a fully functional, secure, and isolated web environment. It consists of three main services working together:

* **The Web Server (NGINX):** This is the "front door" of the website. It securely receives your browser's requests using HTTPS (encrypted connection) and delivers the website's pages to you.
* **The Application (WordPress):** This is the website itself. It processes the content, manages the blog, and builds the pages you see on your screen.
* **The Database (MariaDB):** This is the hidden "vault." It safely stores all the website's text, posts, user accounts, and settings. It is completely isolated from the internet for security.

---

## 2. Starting and Stopping the Project

You don't need to be a Docker expert to run this project. Everything is simplified using a `Makefile` located in the main folder.

* **To Start the Project:** Open your terminal in the project folder and type:
  * bash
  * make 

Wait a few moments. The system will automatically build the environment and start all services in the background.

To Stop the Project: When you are done and want to safely turn off the services without losing your data, type:
* make down

## 3. Accessing the Website and Administration Panel

Once the project is running, you can access your website through any standard web browser.

    Public Website:
    Navigate to: 👉 https://login.42.fr
    (Note: Your browser might warn you that the certificate is self-signed. You can safely click "Advanced" and "Proceed" to view the site).

    Administration Panel:
    To manage the website, write new posts, or approve comments, navigate to: 👉 https://login.42.fr/wp-admin

## 4. Locating and Managing Credentials

To log into the administration panel, you will need the credentials configured during the setup.

    Where to find them: All usernames, emails, and structural settings are defined in the .env file located inside the srcs/ directory.

    Passwords: For security reasons, passwords might be stored in a separate secrets/ folder (if configured by the developer) or inside the .env file.

    Default Users: The system automatically creates two users for you:

        An Administrator (capable of changing site settings and themes).

        A standard User/Author (capable of writing and publishing posts).

## 5. Checking that Services are Running Correctly

If the website is not loading, you can easily check the health of the infrastructure.

    Open your terminal in the project folder.

    Type the following command:

* docker ps

    What to look for: You should see a list of three containers (nginx, wordpress, and mariadb). Look at the STATUS column. If it says Up (e.g., Up 5 minutes), the services are running perfectly. If any service says Restarting or is missing from the list, there might be an initialization error.