# Coffee Arena Server


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
