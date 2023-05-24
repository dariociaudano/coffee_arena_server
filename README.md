# Coffee Arena Server


## DATA POPULATIONS

---

1. Create a MySQL database: Make sure you have MySQL installed and running. Create a new database where you want to import the SQL configuration.

2. Import SQL configuration: Use the mysql command-line tool to import the SQL configuration file into the database. Open a terminal or command prompt and execute the following command:

```shell
mysql -u <username> -p <database_name> < config/db_config.sql
```

## BUILD PROCEDURE

1. The repo contains executable and docker build directives to specify the target os, architecture and the docker image tag through the Makefile variables **os**, **arch** and **version**
   
   | VAR     | DEFAULT |
   | ------- | ------- |
   | os      | linux   |
   | arch    | amd64   |
   | version | 0.0.0   |

2. To build the executable for the host machine just type on a shell:
   
   ```shell
   make build
   ```

3. To build docker image, it is necessary to follow both these steps:
   
   - Start qemu for docker cross-compiling:
     
     ```shell
     docker run --privileged --rm tonistiigi/binfmt --install all
     ```
   
   - Build docker image:
     
     ```shell
     # arm64
     make docker
     ```

## CONTAINERIZATION

---

1. To start up the service using docker, use the following command:
   
   ```shell
   # amd64
   docker run coffee-arena-server:0.0.0
   ```
2. This command with the param --help will promp all the possible setting to use in order to access the host and the database
3. 
   ```shell
   # amd64
   docker run coffee-arena-server:0.0.0 --help
   ```
   
   ```shell
   # amd64
   Usage of /coffee_arena_server:
     -DB_HOST string
         DB service host (default "localhost")
     -DB_NAME string
         DB service name (default "coffee_arena_db")
     -DB_PORT int
         DB service port (default 3306)
     -DB_PWD string
         DB service password (default "secret")
     -DB_USER string
         DB service username (default "coffee_arena_admin")
     -address string
         REST service base address (default "localhost")
     -help
         Show help
     -port int
         REST service port (default 8080)
   ```
   
   
   
