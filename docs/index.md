# Introduction

Welcome to the revamped implementation to install a HA kubernetes cluster. If you're interested in the
reasons and in the list of improvements since the  first version just go to the [relevant section](improvements_since_first_version.md).

The legacy implementation is still available in the `legacy` branch in the git repository,
and the documentation is still available [here](legacy/index.md).

## The project

The goal is being able to easily install highly available Kubernetes cluster using K3S on Raspberry PIs
using Ansible, literally a couple of commands.

This project takes inspiration from the Ansible playbooks provided in [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible)
GitHub repository.

The provided script has been tested on `arm64` Raspberry Pi OS using Raspberry PI 4B machines.

## The hardware requirements:

### HA Setup

The ideal minimal setup would be composed of 4 different Raspberry PIs:

- 3 Raspberry PI (2GB RAM minimum) would serve the function of Kubernetes masters, running only the control plane.
- 1+ Raspberry PI (8GB RAM suggested) as node, to run your pods.

It is possible to still run an HA setup using only 2 masters, but an [external datastore](https://rancher.com/docs/k3s/latest/en/installation/datastore)
would be necessary.

It is also possible to enable pod scheduling on the masters, removing the taints from
the control plane PIs in the ansible inventory. _(Running loads on Kubernetes masters is
a bad practice that can make your cluster unresponsive. You'll also need more than 2GB of
RAM if you still want to proceed in this way)_

### Non HA Setup

It is possible to run the playbooks using only one Kubernetes master.

## Core software

* [Kube-vip](https://kube-vip.chipzoller.dev/): We use kube-vip instead of Klipper, the LoadBalancer implementation 
  provided in K3S, because it provides 2 functionalities:
    * assigns a separate IP to each Kubernetes Service. _(Klipper uses host ports, sharing the same IP
      addresses between services, which can cause clashes if the same port is used on different Kubernetes Services)._
    * provides a floating IP to the control plane, load balancing the requests to all the master nodes.
* [Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/): We use it instead of the controller provided
by K3S so that we have more control over the installation process. Coupled with [Kube-vip](https://kube-vip.chipzoller.dev/)
we can give a specific IP address to the Service so that we know where to forward the 80 and 443 ports.
