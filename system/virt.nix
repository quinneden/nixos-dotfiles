{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };

    oci-containers = {
      backend = "podman";
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  users.users.${username}.extraGroups = ["qemu-libvirtd" "libvirtd" "docker"];

  environment.systemPackages = with pkgs; [
    podman-tui
    podman-compose
    spice
    spice-gtk
    spice-protocol
    vagrant
    virt-viewer
  ];

  programs.virt-manager.enable = true;

  home-manager.users.${username} = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
