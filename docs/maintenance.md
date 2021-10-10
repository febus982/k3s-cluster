# Maintenance operations

## Replace a Load Balancer unit

If you need to replace one of the Raspberry PIs and you need to reinstall the system (e.g. you can't reuse the SD card
because it broke) run the following command (change lb1 to the host you're replacing):

```bash
pipenv run k3s_install --limit lb1
```

This will make sure you target only the host you want to reinstall (`--limit lb1`)

## Replace a K3S node unit

If you need to replace one of the K3S nodes and you need to reinstall the system (e.g. you can't reuse the SD card
because it broke) run the following command (change master1 to the host you're replacing):

```bash
pipenv run k3s_install -e k3s_reinstall=true --limit master1
```

This will make sure:

* You target only the host you want to reinstall (`--limit master1`)
* The node will not try to initialise a new K3S cluster (`-e k3s_reinstall=true`)
