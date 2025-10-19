{ inputs, config, ... }:
{
  flake.modules.nixos.starbuck = {
    username = "peteresselius";

    nixpkgs.hostPlatform = "aarch64-linux";
    system.stateVersion = "25.05";

    networking.hostName = "starbuck";
    networking.hostId = "9c8031a8";
  };

  flake.nixosConfigurations.starbuck = config.flake.lib.loadNixosSystemForRpiHost "starbuck" [
    "rpi5"
    "sshd"
    "user"
    "zfs"
  ];
}
