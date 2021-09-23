# K3S Nodes PI setup

## PI Network setup

Same as we did for load balancers we setup one PI at a time. The PIs have to be connected to the ethernet interface so
that they will receive an IP address from the load balancers.

Start the PI, it will become available on `raspberrypi.local` hostname
```
ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
 -o ProxyCommand="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -W %h:%p -q pi@192.168.50.150" \
 pi@raspberrypi.local

pipenv run k3s_bootstrap -e new_hostname=master1
```

Repeat the same for `master2` and all nodes defined in the ansible inventory

Note: The `ssh-copy-id` command has different options from the ones in the load balancer setup.

## K3S Nodes PIs provisioning

Run:
```bash
pipenv run k3s_install
```

### Notes

- the step `TASK [apt_dependencies : Run apt dist-upgrade]` might take a while (~10-15 minutes if system is not up to date)
- the step `TASK [k3s_script : Install K3S]` might take a while (~3-5 minutes on PI4)

## K3S Nodes PIs uninstall

This command will uninstall only the K3S binary and config:

```bash
pipenv run k3s_uninstall
```

This will leave the PI ready for the installation of other software (or reinstallation of K3S).
