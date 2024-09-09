# Using minikube with nip.io on WSL2

## Create the Kubernetes cluster with minikube

```bash
minikube start
```

## Enable the Ingress controller

```bash
minikube addons enable ingress
```

## Deploy a demo application

```bash
kubectl create deployment hello --image=gcr.io/google-samples/hello-app:1.0
kubectl expose deployment hello --port=8080
kubectl apply -f ingress.yaml
```

## Access the application

```bash
minikube tunnel
```

Open in Browser: http://hello.127.0.0.1.nip.io
