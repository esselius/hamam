{
  flake.modules.nixos.sshd = {
    services.sshd.enable = true;
  };
}
