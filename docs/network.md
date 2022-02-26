# Network design

The system is designed to create and use an isolated subnet, providing service discovery and routing to the external network.

Example configuration:

``` mermaid
graph TD
    INTERNET([INTERNET])
    LAN(["192.168.100.1"<br />LAN GATEWAY])
    ROUTER(["192.168.100.100<br />10.10.0.1"<br />INTERNAL ROUTER])
    MASTER1["10.10.0.11"<br />MASTER1]
    MASTER2["10.10.0.12"<br />MASTER2]
    MASTER3["10.10.0.13"<br />MASTER3]
    NODE1["10.10.0.30 (DHCP)"<br />NODE1]
    INTERNAL_NAS[("10.10.0.50"<br />NFS STORAGE)]
    KUBE_API{{"10.10.0.2 (Floating IP)<br />" K3S API Service}}
    KUBE_SVC{{"10.10.1.1"<br />K3S Ingress Service}}
    INTERNET <==> LAN
    LAN <==> ROUTER
    ROUTER <==> |port 6443| KUBE_API
    ROUTER <==> |port 80, 443| KUBE_SVC
    KUBE_API <==> MASTER1 & MASTER2 & MASTER3
    KUBE_SVC <==> NODE1
    ROUTER <==> |port 111,2049| INTERNAL_NAS
```

## IP Ranges setup explained

The example uses a dedicated router to keep the internal network separate from the external one,
isolating the internal network from the external one. _(The implementation does not cover the
isolation of the network, which is entirely optional.)_

The internal network uses the CIDR `10.10.0.0/16` and the following range design can be implemented
using the playbooks:

- `10.10.0.1`: Router internal IP, used as gateway and DNS resolver.
- `10.10.0.2`: Control plane floating IP, the router forwards port 6443 to this address.
- `10.10.0.3 - 10.10.0.254`: reserved for static IP addresses assigned to physical machines (e.g. an NFS storage)
- `10.10.1.1 - 10.10.1.254`: reserved for K3S services of type LoadBalancer (e.g. the Ingress controller service)
- `10.10.2.1 - 10.10.255.254`: DHCP range for physical machines
