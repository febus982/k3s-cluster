# Introduction

## The project

Build a highly available Kubernetes cluster using K3S, in an isolated subnet using Raspberry PIs.
The goal is easily install everything necessary using Ansible.

This project takes inspiration from the Ansible playbooks provided in [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible)
GitHub repository.

The provided script has been tested on `arm64` Raspberry Pi OS using:

- Raspberry PI 3B
- Raspberry PI 4B

## The hardware requirements:

### HA Setup

The ideal setup would be composed of 5 different Raspberry PIs:

- 2 Raspberry PI would serve the function of Gateway and Load Balancer
- 3 Raspberry PI would serve the function of Kubernetes masters, holding the control plane AND additional load.

It is possible to still run an HA setup using only 2 masters, but an [external datastore](https://rancher.com/docs/k3s/latest/en/installation/datastore)
would be necessary.

### Non HA Setup

It is possible to run the playbooks using only one Kubernetes master.

It _should_ also be possible to run against a single Load Balancer, but this setup has not been tested.

## Core software

* [MetalLB](https://metallb.universe.tf/): We use MetalLB instead of Klipper, the Load Balancer implementation provided
in K3S, because it gives us more flexibility by giving a separate IP to each Service.
* [Consul](https://www.consul.io/): We use the Service Discovery functionality of Consul because:
    * it allows an easy monitoring of both kubernetes nodes and additional hardware nodes health
    * it synchronise automatically services between kubernetes and the internal network
* [Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/): We use it instead of the controller provided
by K3S so that we have more control over the installation process. Coupled with [MetalLB](https://metallb.universe.tf/)
we can give a specific IP address to the Service so that the HAProxy Load Balancer knows where to forward ingress requests.
