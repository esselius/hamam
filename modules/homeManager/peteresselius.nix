{
  config,
  ...
}:
{
  flake.modules.homeManager.peteresselius = {
    home = {
      stateVersion = "24.05";
      username = "peteresselius";
      homeDirectory = "/Users/peteresselius";
    };
  };

  flake.homeConfigurations.peteresselius = config.flake.lib.loadHmModuleForUser "peteresselius" [ "git" ];
}
