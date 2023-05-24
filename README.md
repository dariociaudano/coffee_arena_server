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

2. To start using k3s, follow these steps:
   
   1. Install k3s:
      
      ```shell
      curl -sfL https://get.k3s.io | sh -
      ```
   2. Install helm:
      
      ```shell
      curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
      chmod 700 get_helm.sh
      ./get_helm.sh
      ```
   3. Install k9s:
      
      ```shell
      curl -sS https://webinstall.dev/k9s | bash
      ```
   4. Save docker image to .tar file:
      
      ```shell
      # amd64
      docker save coffee-arena-server:0.0.0 -o images/coffee-arena-server-amd64.tar
      ```
   5. Import image to k3s:
      
      ```shell
      # amd64
      k3s ctr images import images/coffee-arena-server-amd64.tar
      ```
   6. Deploy the chart:
      
      ```shell
      # Set permission for kubeconfig file
      sudo chmod +r /etc/rancher/k3s/k3s.yaml
      # Deploy chart
      helm install coffeearenaserver-service chart/ --kubeconfig /etc/rancher/k3s/k3s.yaml
      ```
   7. Check the service is working correctly through k9s:
      
      ```shell
      k9s --kubeconfig /etc/rancher/k3s/k3s.yaml
      ```
