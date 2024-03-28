{ config, pkgs, ... }:

{
  home.username = "evelyn";
  home.homeDirectory = "/home/evelyn";

  # fonts
  fonts.fontconfig.enable = true;
  
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    zip
    xz
    unzip
    ripgrep
    jq
    eza
    fzf
    which
    tree
    # Common tools
    alacritty
    bitwarden
    bitwarden-cli
    discord
    firefox
    google-chrome
    micromamba
    obsidian
    spotify
    thunderbird
    vscode
    # fonts
    nerdfonts
  ];

  # basic git config
  programs.git = {
    enable = true;
    userName = "Evelyn King";
    userEmail = "evelyn.cameron.king@gmail.com";
  };
  
  # starship
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
    };
  };

  # bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/.local/bin"
    '';
  };

  # kitty
  programs.kitty = {
    enable = true;
    theme = "Nord";
  };

  # neovim
  programs.neovim = {
    enable = true;
  };

  # vim
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins;
    [
      lightline-vim
    ];
    settings = {
      background = "dark";
      expandtab = true;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
    };
    extraConfig = ''
      set nocompatible
      filetype plugin indent on
      syntax enable
      set backspace=indent,eol,start
      set encoding=utf-8
      set nohlsearch
      set incsearch
      set ruler
      set softtabstop=2

      set laststatus=2
      set noshowmode
      let g:lightline = {'colorscheme': "nord"}
    '';
  };

  # tmux
  programs.tmux = {
    enable = true;
  };
    
  home.stateVersion = "23.11";
  # Let home manager install and manage itself
  programs.home-manager.enable = true;
}
