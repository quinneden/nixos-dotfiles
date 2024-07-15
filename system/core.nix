{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-apple-silicon.nixosModules.default
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = lib.mkForce false;
  };

  hardware.asahi = {
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
    setupAsahiSound = true;
    withRust = true;
  };

  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  nixpkgs = {
    overlays = [inputs.nixos-apple-silicon.overlays.default];
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "";
      nix-path = config.nix.nixPath;
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 4d";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };

  users.users = {
    quinn = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };

  programs = {
    dconf.enable = true;
    home-manager.enable = true;
    openssh.enable = true;
    zsh.enable = true;
  };

  services = {
    blueman.enable = true;
    dbus.enable = true;
    fstrim.enable = true;
    pipewire = {
      enable = true;
      wireplumber.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    asahi-bless
    asahi-btsync
    bat
    btrfs-progs
    cliphist
    eza
    fzf
    floorp
    gcc
    git
    glxinfo
    gnumake
    go
    gparted
    hdrop
    imv
    jq
    just
    libvlc
    lima
    man-pages
    mdcat
    micro
    ncdu
    nodejs
    ripgrep
    ruby
    rustup
    vlc
    wget
    wl-clipboard
    xdg-utils
    yarn
    zoxide
  ];

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "24.11";
}
