# Preparation

If you don't already have a SSH key please [create a new ssh key pair](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?utm_source=Blog#generating-a-new-ssh-key)

## Note about security

This documentation doesn't cover security practices like:

- Changing the default `pi` user password
- Creating a different user than `pi`
- Changing SSH daemon port

For the sake of installing the system the default settings found on Raspberry Pi OS are used. 

## Initialise Raspberry PIs SD Cards

???+ warning "About the disk"
    An SSD hard disk with a USB adapter would achieve a much better performance than a SD Card,
    and it would be much more reliable. It is better to avoid NVMe disks, because of the higher
    energy requirement (especially if you power your PIs using PoE) and the limited speed improvement
    over an SSD

* Download the latest [Raspberry Pi Imager](https://www.raspberrypi.org/software/) version and open it.
* Choose the OS:
    * **(strongly recommended)** `Ubuntu Server 22.04.2 LTS (64-bit)` under `Other general-purpose OS`/`Ubuntu`
    * `Raspberry Pi OS Lite (64-bit)` under `Raspberry Pi OS (other)`

???+ warning "Why should you use Ubuntu?"
    There is an open [issue](https://github.com/raspberrypi/linux/issues/4375) in Raspberry Pi OS
    for a kernel setting that makes impossible to run Envoy. While the setting makes sense
    in a generic Raspberry PI context, Envoy is widely used in kubernetes applications.
    
    It will be likely you'll encounter this issue. **This is the reason why I recommend using Ubuntu Server**

For each Raspberry PI card 

* Customise the installation process by clicking the cog-shaped button:
    * Setup the hostname, e.g. `master1`, `node1`, etc.  _(This is very important so that the ansible playbook can target via the hostname)_
    * Enable SSH with public-key authentication _(Your SSH key is already precompiled!)_
    * Set a password for the `pi` user (or any username you want to use)
    * Set the locale
* Optional: modify the `config.txt` file in the sd card and customise the PI config (e.g. Disable the wifi and bluetooth adapter)

## Download source code and setup ansible inventory

Clone the [git repository](https://github.com/febus982/k3s-cluster) to your local machine.

```bash
git clone https://github.com/febus982/k3s-cluster.git
cd k3s-cluster
```

Copy the sample inventory and customise it, if necessary:

```bash
cp ./inventory/sample/inventory.yml ./inventory/inventory.yml
```

### Using Flux CD

The ansible scripts are supposed to work in pair with FluxCD and [this sample repository](https://github.com/febus982/k3s-cluster-flux-sample)

To use Flux CD make sure you:

* Fork or copy the content of the repository (you need write access to the repository setup in the ansible inventory)
* Create a personal token for Flux bootstrap. Check necessary permissions [here](https://fluxcd.io/docs/installation/#github-and-github-enterprise)

Currently only GitHub repositories are supported by this ansible playbook but it should be easy enough to use a different provider by altering
[this file](https://github.com/febus982/k3s-cluster/blob/master/roles/fluxcd/tasks/main.yml) and the inventory variables.
(Pull requests implementing other providers support are appreciated)

### Without Flux CD

If you don't want to use Flux CD you can manually install the core apps using [Helm](https://helm.sh).

The core applications contained in the sample repository are:

* coredns
    * Helm repository: `https://github.com/coredns/helm/tree/master/charts/coredns`
    * [Helm chart values](https://github.com/febus982/k3s-cluster-flux-sample/blob/cda3613b5c85d2322faa64f52b2c4fc5d3d1d75f/infrastructure/coredns/release.yaml#L20)
* ingress-nginx
    * Helm repository: `https://kubernetes.github.io/ingress-nginx`
    * [Helm chart values](https://github.com/febus982/k3s-cluster-flux-sample/blob/2db6d87ce4ba23ef8fce5ce8022dfc508f7d72be/system-applications/ingress-nginx/release.yaml#L20)
* K3S auto-updater
    * Refer to [this page](https://rancher.com/docs/k3s/latest/en/upgrades/automated/) for the installation documentation

### Ansible inventory defaults

```yaml
--8<-- "./inventory/sample/inventory.yml"
```
