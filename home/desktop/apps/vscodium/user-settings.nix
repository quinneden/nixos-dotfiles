{
  programs.vscode.userSettings = {
    update.mode = "none";

    extensions = {
      autoUpdate = false;
    };

    window = {
      titleBarStyle = "custom";
      menuBarVisibility = "toggle";
    };

    editor = {
      fontSize = 16;
      formatOnType = false;
      fontLigatures = true;
      mouseWheelZoom = false;
      minimap.enabled = false;
      renderControlCharacters = false;
      fontFamily = "'FiraCode Nerd Font', 'SymbolsNerdFont', 'monospace', monospace";

      scrollbar = {
        vertical = "hidden";
        horizontal = "hidden";
        verticalScrollbarSize = 2;
        horizontalScrollbarSize = 2;
      };
    };

    workbench = {
      startupEditor = "none";
      layoutControl.type = "menu";
      iconTheme = "catppuccin-mocha";
      colorTheme = "Catppuccin Mocha";
      editor = {
        limit = {
          enabled = true;
          value = 5;
          perEditorGroup = true;
        };
        # showTabs = "single";
      };
      activityBar.location = "bottom";
      statusBar.visible = true;
      layoutControl.enabled = true;
    };

    explorer = {
      openEditors.visible = 0;
      confirmDragAndDrop = false;
    };

    terminal.integrated.fontFamily = "'FiraCode Nerd Font', 'SymbolsNerdFont'";

    "breadcrumbs.enabled" = true;
    "files.autoSave" = "onWindowChange";
    "vsicons.dontShowNewVersionMessage" = true;

    editor.defaultFormatter = "esbenp.prettier-vscode";
    "[javascript]".editor.defaultFormatter = "esbenp.prettier-vscode";
  };
}
