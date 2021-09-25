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
