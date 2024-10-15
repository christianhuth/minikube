# Using Backstage with the coder plugin

## Create the Kubernetes cluster with minikube

```bash
minikube start
```

## Enable the Ingress controller

```bash
minikube addons enable ingress
```

## Enable the Kubernetes dashboard

```bash
minikube addons enable dashboard
```

## Install the Backstage Helm Chart

```bash
./install-backstage.sh
```

### Or upgrade the running instance

```bash
./upgrade-backstage.sh
```

## Access the application

```bash
minikube tunnel
```

Open in Browser: http://backstage.127.0.0.1.nip.io
