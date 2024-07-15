{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./vscodium.nix
    ./zsh.nix
  ];

  home = {
    username = "quinn";
    homeDirectory = "/home/quinn";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.11";
}
