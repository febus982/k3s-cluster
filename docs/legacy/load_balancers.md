# Legacy documentation - Load Balancer PI setup
 
???+ error "Legacy documentation"
    This the legacy documentation. [Click here for the updated one](/)

## PI Network setup

We need to do these operations by turning on one PI at a time, otherwise the `raspberrypi.local` name will collide.

_PLEASE: If you know of a way of customising the PI hostname automatically in Raspberry OS let me know so I can add it
to this guide_

Start the first PI, it will become available on `raspberrypi.local` hostname (default pi user password is `raspberry`). Run:

```bash
ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null pi@raspberrypi.local
```

then:

```bash
pipenv run lb_bootstrap_pi -e new_hostname=lb1
```

Note that the reboot task will fail, this is expected because the hostname will be changed to `lb1.local`.

Start the second PI, and run:

```bash
ssh-copy-id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null pi@raspberrypi.local
```

then:

```bash
pipenv run lb_bootstrap_pi -e new_hostname=lb2
```

Now the PIs are available using `lb1.local` and `lb2.local` hostnames

## Load Balancer PIs provisioning

Run:

```bash
pipenv run ansible-requirements
```

then:

```bash
pipenv run lb_install
```

Haproxy statistics are now accessible at [http://192.168.50.150:1936/stats](http://192.168.50.150:1936/stats)

### Notes

- While it's technically possible to provision the load balancer without LAN connection, some services (e.g. consul) won't work properly until the LAN is connected.
- the step `TASK [apt_dependencies : Run apt dist-upgrade]` might take a while (~10-15 minutes if system is not up to date)
