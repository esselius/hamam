{ inputs, config, ... }:
{
  flake.modules.nixos.starbuck = {
    username = "peteresselius";

    nixpkgs.hostPlatform = "aarch64-linux";
    system.stateVersion = "25.05";

    networking.hostName = "starbuck";
    networking.hostId = "9c8031a8";

    microvm.vms.prometheus.config = {
      networking.firewall.enable = false;
      services.prometheus.enable = true;
      networking.hostName = "prometheus";
      system.stateVersion = "25.05";
      microvm.shares = [
        {
          source = "/nix/store";
          mountPoint = "/nix/.ro-store";
          tag = "ro-store";
          proto = "virtiofs";
        }
      ];
      microvm.interfaces = [
        {
          type = "tap";
          id = "vm-prometheus";
          mac = "02:00:00:00:00:01";
        }
      ];
      systemd.network.enable = true;

      systemd.network.networks."20-lan" = {
        matchConfig.Type = "ether";
        networkConfig = {
          Address = [
            "192.168.50.102/24"
          ];
          Gateway = "192.168.50.1";
          DNS = [ "192.168.50.1" ];
          DHCP = "no";
        };
      };
    };
    microvm.autostart = [ "prometheus" ];
  };

  flake.nixosConfigurations.starbuck = config.flake.lib.loadNixosSystemForRpiHost "starbuck" [
    "microvm-host"
    "rpi5"
    "sshd"
    "user"
    "zfs"
    "nix"
  ];
}
