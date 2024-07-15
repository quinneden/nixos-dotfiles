{
  pkgs,
  lib,
  inputs,
  outputs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["eza" "zsh-navigation-tools"];
    };
    shellAliases = {
      cdnix = "cd ${dotdir}";
      code = "codium";
      commit = "git add . && git commit -a --allow-empty-message --no-edit";
      df = "df -h";
      du = "du -h";
      flake-tree = "eza -aT ${dotdir} -I '.git*|.vscode*'";
      flake-update = "sudo nix flake update ${dotdir}";
      fuck = "sudo rm -rf";
      gsur = "git submodule update --init --recursive";
      l = "eza -la --group-directories-first";
      ll = "eza -glAh --octal-permissions --group-directories-first";
      ls = "eza -A";
      mi = "micro";
      nix-clean = "sudo nix store gc && nix store gc && sudo nix-collect-garbage -d && sudo rm -rf /nix/var/nix/gcroots/auto/* && nix-collect-garbage -d";
      nix-switch = "sudo nixos-rebuild switch --impure --flake ${dotdir}#macmini";
      push = "git push";
      py = "python";
      rf = "rm -rf";
      tree = "eza -aT --ignore-glob .git";
    };
    sessionVariables = {
      BAT_THEME = "Dracula";
      dotdir = "$HOME/.dotfiles";
      EDITOR = "micro";
      EZA_ICON_SPACING = "2";
      MICRO_TRUECOLOR = "1";
      workdir = "$HOME/workdir";
    };
    initExtra = ''
      autoload -U promptinit; promptinit
      prompt pure

      for f (~/.scripts/zsh/[^plugins]**/*(.)) source $f

      # for f (~/.scripts/zsh/plugins/**/*.plugin.zsh); do source $f; done
    '';
  };
}
