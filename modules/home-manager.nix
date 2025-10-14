{
  config,
  inputs,
  withSystem,
  ...
}:
{
  imports = [ inputs.home-manager.flakeModules.default ];

  flake.lib.loadHmModuleForUser =
    username: modules:
    withSystem "aarch64-darwin" (
      { pkgs, ... }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          config.flake.modules.homeManager.${username}
        ]
        ++ builtins.map (module: config.flake.modules.homeManager.${module}) modules;
      }
    );
}
