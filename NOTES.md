## Install

### Raspberry Pi 5

rpi5 installer image

```shell
nix build github:nvmd/nixos-raspberrypi/main#installerImages.rpi5
```

### After installer image boot

```shell
nix run nixos-anywhere -- --flake .#starbuck --target-host 192.168.50.157
```

### Deploy updates

```shell
nixos-rebuild switch --flake .#starbuck --target-host 192.168.50.157  --use-remote-sudo --fast
```

## Troubleshooting

### SD card boot failure with "Missing or bad public key"

Reset the EEPROM to factory settings:

  1. Download the [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
  2. Select "Misc utility images" -> "Bootloader" -> "Reset to factory defaults"
  3. Write to an SD card and boot the Raspberry Pi with it inserted
