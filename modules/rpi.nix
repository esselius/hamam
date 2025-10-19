{ inputs, ... }:

{ inputs, ... }:
{
  flake.modules.nixos.rpi5 = {
    imports = [
      inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
      inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.bluetooth
      inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.page-size-16k
    ];
  };
}
