# Preparation

If you don't already have a SSH key please [create a new ssh key pair](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?utm_source=Blog#generating-a-new-ssh-key)

## SD Cards

Download the `arm64` version of Raspberry Pi OS [here](https://downloads.raspberrypi.org/raspios_lite_arm64/images/).
You can also install the normal 32 bit version with architecture `armv7` but the `arm64` architecture is
much more supported for docker images.

For each LB pi card (you can setup all cards at the same time)

- Install the downloaded image to the SD card using Raspberry Pi Imager (https://www.raspberrypi.org/software/)
- Create empty file named `ssh` in the SD card boot partition
- Optional: modify the `config.txt` file in the sd card and customise the PI config (e.g. Disable the bluetooth adapter)

Only for the Load Balancer SD cards:

- Create a `wpa_supplicant.conf` file in the SD card to automatically connect to the WiFi network already on the first
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
