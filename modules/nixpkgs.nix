{
  inputs,
  flake-parts-lib,
  ...
}:

let
  inherit (flake-parts-lib) mkPerSystemOption;
in
{
  options.perSystem = mkPerSystemOption (
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
      };
    }
  );
}
