{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs);
in {
  programs = {
    foot = import ./foot pkgs;
  };

  home.packages = with pkgs;
  with gnome; [
    nautilus # File Manager
    gnome-calculator
    easyeffects # Equalizer
    pavucontrol # Audio/Volume control
    neovide # Cool neovim GUI client
  ];
}
