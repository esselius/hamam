{ inputs, ... }:

{
  flake.modules.nixos.microvm-host = {
    imports = [
      inputs.microvm.nixosModules.host
    ];

    networking.useNetworkd = true;

    systemd.network.networks."10-lan" = {
      matchConfig.Name = [
        "end0"
        "vm-*"
      ];
      networkConfig = {
        Bridge = "br0";
      };
    };

    systemd.network.netdevs."br0" = {
      netdevConfig = {
        Name = "br0";
        Kind = "bridge";
      };
    };

    systemd.network.networks."10-lan-bridge" = {
      matchConfig.Name = "br0";
      networkConfig = {
        Address = [
          "192.168.50.101/24"
        ];
        Gateway = "192.168.50.1";
        DNS = [ "192.168.50.1" ];
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };
}
