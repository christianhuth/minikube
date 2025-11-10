# KubeVirt Demo

This small demo project shows how to run a Virtual Machine on a Kubernetes Cluster using KubeVirt and the KubeVirt Manager.

## Start a Minikube Cluster

```bash
./00-start-minikube.sh
```

## Install KubeVirt

```bash
./01-install-kubevirt.sh
```

## Check KubeVirt Installation

```bash
kubectl get all -n kubevirt
```

## Install the KubeVirt Manager

```bash
./02-install-kubevirt-manager.sh
```

## Access the KubeVirt Manager

```bash
minikube tunnel
```

Open https://kubevirt.127.0.0.1.nip.io in your Browser.
