{ lib, flake-parts-lib, ... }:

let
  inherit (flake-parts-lib) mkPerSystemOption;
in
{
  options.perSystem = mkPerSystemOption (
    { config, pkgs, ... }:
    let
      cfg = config.taskfile;
    in
    {
      options.taskfile = {
        config = {
          version = lib.mkOption {
            type = lib.types.str;
            default = "3";
          };
          tasks = lib.mkOption {
            type = lib.types.attrsOf (
              lib.types.submodule {
                options = {
                  cmd = lib.mkOption { type = lib.types.str; };
                  desc = lib.mkOption { type = lib.types.str; };
                };
              }
            );
          };
        };

        runner = {
          name = lib.mkOption {
            type = lib.types.str;
          };
          config = lib.mkOption {
            type = lib.types.pathInStore;
            readOnly = true;
            default = pkgs.writers.writeYAML "taskfile.yaml" cfg.config;
          };
          exec = lib.mkOption {
            type = lib.types.package;
            readOnly = true;
            default = pkgs.writeShellApplication {
              inherit (cfg.runner) name;
              runtimeInputs = [ pkgs.go-task ];
              text = ''
                task --taskfile "${cfg.runner.config}" "$@"
              '';
            };
          };
        };
      };
    }
  );
}
