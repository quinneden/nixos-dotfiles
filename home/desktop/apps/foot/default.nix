pkgs: let
  colors = import ./colors.nix;
in {
  enable = true;
  package = pkgs.foot;
  server.enable = true;
  settings = {
    main = {
      term = "xterm-256color";
      font = "FiraCodeMonoNerdFont:size=12";
      notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
    };

    cursor = {
      style = "beam";
      beam-thickness = 2;
    };

    bell = {
      urgent = "yes";
      notify = "yes";
      command = "notify-send bell";
      command-focused = "no";
    };

    mouse.hide-when-typing = "yes";
    key-bindings = {
      scrollback-up-page = "Page_Up";
      scrollback-down-page = "Page_Down";

      clipboard-copy = "Meta+c";
      clipboard-paste = "Meta+v";

      search-start = "Control+f";
    };

    # search-bindings = { };

    colors = colors.poimandres;
  };
}
