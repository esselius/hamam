{
  inputs,
  config,
  ...
}:
{
  flake.lib.loadNixosSystemForHost =
    hostname: modules:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        config.flake.modules.nixos.${hostname}
      ]
      ++ builtins.map (module: config.flake.modules.nixos.${module}) modules;
    };

  flake.lib.loadNixosSystemForRpiHost =
    hostname: modules:
    inputs.nixos-raspberrypi.lib.nixosSystem {
      specialArgs = { inherit (inputs) nixos-raspberrypi; };
      modules = [
        config.flake.modules.nixos.${hostname}

        # Recommended default: https://github.com/nvmd/nixos-raspberrypi/tree/develop#provides-bootloader-infrastructure}
        { boot.loader.raspberryPi.bootloader = "kernel"; }
      ]
      ++ builtins.map (module: config.flake.modules.nixos.${module}) modules;
    };

  flake.nixosModules = config.flake.modules.nixos;
}
