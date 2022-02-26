# Maintenance operations

## Replace a K3S node unit

If you need to replace one of the K3S nodes and you need to reinstall the system (e.g. you can't reuse the SD card
because it broke) run the following command (change master1 to the host you're replacing):

```bash
pipenv run k3s_install --limit master1
```

This will make sure you target only the host you want to reinstall (`--limit master1`)
