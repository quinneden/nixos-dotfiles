{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Fix boot log spam.
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  services.displayManager.enable = true;
}
