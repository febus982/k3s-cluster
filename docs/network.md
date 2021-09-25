# Network design

The system is designed to run in an independent subnet.

## Load balancers

The Load Balancer PIs will use the WiFi interface for internet connectivity, while the ethernet network is used
for communication over the internal subnet.

The Load Balancers will use the following IP addresses on the WiFi interface:

1. IP address for each Load Balancer PI, assigned by the DHCP server present on the WiFi network
3. A floating IP address for both Load Balancers, manually configured in the ansible inventory

## Internal IP Ranges setup

The internal network uses the CIDR `10.0.0.0/16` and the following range design is used in the ansible implementation:

- `10.0.0.1`: Load Balancer internal floating IP, used as gateway and DNS resolver
- `10.0.0.2 - 10.0.0.254`: reserved for static IP addresses assigned to physical machines in the internal network (e.g. Load Balancer IPs)
- `10.0.1.1 - 10.0.1.254`: reserved for K3S services of type LoadBalancer
- `10.0.2.1 - 10.0.255.254`: DHCP range served over the ethernet interface

Theoretically the DHCP server will serve IP addresses to any other machine connected to the ethernet network, so
adding new machines will be extremely simple.
