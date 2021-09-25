# Load Balancer PI setup

## PI Network setup

We need to do these operations by turning on one PI at a time, otherwise the `raspberrypi.local` name will collide.

Start the first PI, it will become available on `raspberrypi.local` hostname (default pi user password is `raspberry`). Run:

```bash
ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null pi@raspberrypi.local
```

then:

```bash
pipenv run lb_bootstrap_pi -e new_hostname=lb1
```

Note that the reboot task will fail, this is expected because the hostname will be changed to `lb1.local`.

Start the second PI, and run these command

```bash
ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null pi@raspberrypi.local

pipenv run lb_bootstrap_pi -e new_hostname=lb2
```

Now the PIs are available using `lb1.local` and `lb2.local` hostnames

## Load Balancer PIs provisioning

Run:
```bash
pipenv run ansible-requirements

pipenv run lb_install
```

### Notes

- While it's technically possible to provision the load balancer without LAN connection, some services (e.g. consul) won't work properly until the LAN is connected.
- the step `TASK [apt_dependencies : Run apt dist-upgrade]` might take a while (~10-15 minutes if system is not up to date)

## Applications

You should be able to access the following addresses:

- http://192.168.50.150:8500 - Consul UI
- http://192.168.50.150:1936/stats - Haproxy statistics