##Requirements

- Install Docker 18.09 or higher (20.10 or higher is recommended)
- amd64 or arm64 system.
- If using WSL complete these steps first
- Don’t forget to follow this step to manage Docker as a non-root user.
 

## To start the minikube service using the docker driver

```
minikube start --driver=docker
```

## To make docker the default driver:

```
minikube config set driver docker

```


## Start your cluster

```
minikube start
```
