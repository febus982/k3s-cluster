# K3S Nodes PI setup

This requires the Load Balancer PIs to be installed and running. Refer to [Load balancers setup](load_balancers.md).

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
```

As soon as the first master node is running a `kubeconfig.yml` file will be generated in the root directory of
the project, ready to be used by `kubectl` command.

??? warning "K3S Reinstall"
    The installation process creates also a file named `node-token`, together with the `kubeconfig.yml` file.
    If you need to reinstall K3S from scratch, after having uninstalled all nodes, **make sure you
    delete the file** so that the next installation knows it needs to initialise a new cluster.

### Notes

- the step `TASK [apt_dependencies : Run apt dist-upgrade]` might take a while (~10-15 minutes if system is very outdated date)
- the step `TASK [k3s_script : Install K3S]` might take a while (~3-5 minutes on PI4)

## K3S Nodes PIs uninstall

This command will uninstall only the K3S binary and config:

```bash
pipenv run k3s_uninstall
```

This will leave the PI ready for the installation of other software (or reinstallation of K3S).
