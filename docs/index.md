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
- 3 Raspberry PI would serve the function of Kubernetes masters, holding the control plane and additional load. _(Running
loads on Kubernetes masters is a bad practice that can make your cluster unresponsive. Depending on your hardware setup,
you will be able to add the necessary taints to the master nodes in the ansible inventory, as documented in the
[K3S documentation](https://rancher.com/docs/k3s/latest/en/advanced/#node-labels-and-taints))_

It is possible to still run an HA setup using only 2 masters, but an [external datastore](https://rancher.com/docs/k3s/latest/en/installation/datastore)
would be necessary.

### Non HA Setup

It is possible to run the playbooks using only one Kubernetes master.

It _should_ also be possible to run against a single Load Balancer, but this setup has not been tested.

Note: We need at least 3 nodes between Load Balancers and Kubernetes masters, to be able to bootstrap Consul.

## Core software

* [MetalLB](https://metallb.universe.tf/): We use MetalLB instead of Klipper, the Load Balancer implementation provided
in K3S, because it assigns a separate IP to each Kubernetes Service. _(Klipper uses host ports, sharing the same IP
addresses between services, which can cause clashes if the same port is used on different Kubernetes Services)._
* [Consul](https://www.consul.io/): We use the Service Discovery functionality of Consul because:
    * it allows an easy monitoring of both kubernetes nodes and additional hardware nodes health
    * it exposes kubernetes services on the internal network via DNS
    * it exposes network services to kubernetes, creating Services of type ExternalService. _Note: this has not
yet been completely configured._
    * it can provide Service Mesh functionality.
* [Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/): We use it instead of the controller provided
by K3S so that we have more control over the installation process. Coupled with [MetalLB](https://metallb.universe.tf/)
we can give a specific IP address to the Service so that the HAProxy Load Balancer knows where to forward ingress requests.
