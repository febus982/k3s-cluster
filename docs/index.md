# Introduction

## The project

Build a highly available Kubernetes cluster using K3S, in an isolated subnet served by an highly available load balancer.
The goal is easily install a Kubernetes cluster in an isolated network, using Ansible.

This project takes inspiration from the Ansible playbooks provided in [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible) GitHub repository.

The provided script has been tested on:

- Raspberry PI 3B
- Raspberry PI 4B

## The hardware requirements:

The minimum ideal setup would be composed of 4 different Raspberry PIs:

- 2 Raspberry PI would serve the function of Gateway and Load Balancer
- 2 Raspberry PI would serve the function of Kubernetes masters, holding the control plane

The provided ansible playbooks should be able to run against a minimal system of 1 Load Balancer and 1 Kubernetes master,
sacrificing the High Availability, but this setup has not been tested. The documentation will consider an HA setup.

## Additional requirements

- A datastore for K3S control plane. K3S does currently support [PostgresSQL, MySQL, or etcd](https://rancher.com/docs/k3s/latest/en/installation/datastore)

Note: K3S does support high availability with embedded datastore, but this has not been implemented yet.
