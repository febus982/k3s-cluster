# Preparation

If you don't already have a SSH key please [create a new ssh key pair](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?utm_source=Blog#generating-a-new-ssh-key)

## Note about security

This documentation doesn't cover security practices like:

- Changing the default `pi` user password
- Creating a different user than `pi`
- Changing SSH daemon port

For the sake of installing the system the default settings found on Raspberry Pi OS are used. 

## Raspberry PIs SD Cards

Download the `arm64` version of Raspberry Pi OS [here](https://downloads.raspberrypi.org/raspios_lite_arm64/images/).

For each Raspberry PI card

- Install the downloaded image to the SD card using [Raspberry Pi Imager](https://www.raspberrypi.org/software/)
- Create empty file named `ssh` in the SD card boot partition
- Optional: modify the `config.txt` file in the sd card and customise the PI config (e.g. Disable the bluetooth adapter)

Only for the Load Balancer SD cards:

- Create a `wpa_supplicant.conf` file in the SD card to automatically connect to the Wi-Fi network already on the first
boot, with the following content:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
country=<YOUR_COUNTRY_CODE_HERE>
update_config=1

network={
 ssid="<YOUR_SSID_HERE>"
 psk="<YOUR_PASSWORD_HERE>"
}
```

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

```yaml
--8<-- "./inventory/sample/inventory.yml"
```
