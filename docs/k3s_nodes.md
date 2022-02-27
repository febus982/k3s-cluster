# K3S Nodes setup

## Bootstrap PIs

First thing we want to do is bootstrap the PIs:

```bash
pipenv run ansible-requirements
pipenv run k3s_bootstrap
```

This currently does only the file-system expansion.

## Master nodes PI network setup

This step is necessary if you use the default setup: Highly available control plane without an external datastore.

In this scenario K3S will create an highly available etcd setup, and **this needs your master nodes
having a static IP address**. (K3S documentation doesn't specify this)

The best way of doing this is actually in your router _(in this way should you need
to reinstall the nodes from scratch they will get the same IP address without additional actions)_

If you can't do this, you can still setup the networking using the
[raspi-config](https://www.raspberrypi.com/documentation/computers/configuration.html#the-raspi-config-tool)
tool provided by raspbian.

## K3S Nodes PIs provisioning

Run:
```bash
pipenv run k3s_install
pipenv run k3s_install_apps -e app=all
```

As soon as the first master node is running a `kubeconfig.yml` file will be generated in the root directory of
the project, ready to be used by `kubectl` command.

??? warning "K3S Reinstallation"
    The installation process creates also a file named `node-token`, together with the `kubeconfig.yml` file.
    If you need to reinstall K3S from scratch, after having uninstalled all nodes, **make sure you
    delete the file** so that the next installation knows it needs to initialise a new cluster.

??? "Application installation"
    We install the apps separately, so we are able to reinstall or update them without having
    tear down the whole cluster. The possible options for the `app` parameter are:

    * `all`: This tries to install all the applications
    * `coredns`: This tries to install coredns
    * `fluxcd`: This tries to install coredns
    * `kube-vip`: This tries to install kube-vip
    * `vertical_autoscaler`: This tries to install coredns

    The installed applications is still driven by the inventory setup. e.g. if fluxcd is disabled
    it will not be installed, even if explicitely specified. _(This will prevent accidental conflicting apps)_


### Notes

- the step `TASK [apt_dependencies : Run apt dist-upgrade]` might take a while (~10-15 minutes if system is very outdated date)
- the step `TASK [k3s_script : Install K3S]` might take a while (~3-5 minutes on PI4)

## K3S Nodes PIs uninstall

This command will uninstall only the K3S binary and config:

```bash
pipenv run k3s_uninstall
```

This will leave the PI ready for the installation of other software (or reinstallation of K3S).
