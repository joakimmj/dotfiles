{ config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
  ];

  # Packages that should be installed to the user profile.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    spotify
    slack

    # CLI tools
    fzf # fuzzy finder
    neovim # Editor
    lynx # Web browser
    yazi # File manager
    tmux # Terminal mutliplexer

    # Dev
    nodejs_22 # npm
    temurin-bin-20 # java
    maven
    go
  ];

  programs.htop = {
    enable = true;
    settings = {
      tree_view = 1;
    };
  };

  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      font_family = "JetBrains Mono";
      font_size = 13;
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      background = "#2E3434";
      foreground = "#c5c8c6";
    };
  };

  home = {
    username = "joakimmj";
    homeDirectory = "/home/joakimmj";
    stateVersion = "24.05";
  };
}

