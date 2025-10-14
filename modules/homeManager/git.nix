{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      userName = "Peter Esselius";
      userEmail = "pepp@me.com";
    };
  };
}
