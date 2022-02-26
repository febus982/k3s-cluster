# Improvements since the first version

Some improvements have been added to this new version:

* The new Raspbian Bullseye, coupled with the recent Raspberry PI Imager, allows
  to set up the Raspberry PI hostname and the locale when flashing the SD Card / Hard Disk,
  giving a huge speed boost to the installation process. _(It's not necessary anymore
  to initialise the PIs one by one to set up the hostname)_
* The Raspberry PIs that were used as Gateway and Load Balancers have been removed.
    * This allows to set up the cluster in both an isolated network and in a LAN.
    * Two fewer machines to run and to monitor.
    * The Raspberry PIs 3B networking speed was limited.
* Consul has been removed.
    * I was not satisfied of the Kubernetes setup. You need to run the consul
      masters twice in the kubernetes nodes, as a Pod and as a DaemonSet, having
      to deal with port conflicts (in addition to double resources usage).
    * Not having Load Balancers (or other non-kubernetes machines) to monitor
      it was not really necessary anymore.
* Kube-vip has been introduced in place of:
    * Metallb to assign IPs to LoadBalancer services
    * HAProxy+Keepalived to provide a Floating IP to the control plane.