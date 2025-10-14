{
  config,
  ...
}:
{
  flake.modules.homeManager.pepp = {
    home = {
      stateVersion = "24.05";
      username = "pepp";
      homeDirectory = "/Users/pepp";
    };
  };

  flake.homeConfigurations.pepp = config.flake.lib.loadHmModuleForUser "pepp" [ "git-work" ];
}
