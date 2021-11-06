{ pkgs }:

let
  nix-tools = with pkgs; [
    nix-index
    nix-prefetch
    nix-prefetch-scripts
    nixos-shell
  ];

  shells = with pkgs; [
    bashInteractive
    fish
    oil
    zsh
  ];

  misc-tools = with pkgs; [
    # drm_info
    # pdf2djvu
    tree
    aspell
    aspellDicts.pt_BR
    bashmount
    bat
    bc
    cksfv
    direnv
    exa
    fd
    file
    fzf
    gnupg
    graphicsmagick-imagemagick-compat
    grc
    jq
    lzip
    mc
    pandoc
    pinentry-curses
    poppler_utils
    procs
    pv
    rhash
    ripgrep
    rlwrap
    rsclock
    rsync
    screen
    silver-searcher
    tty-clock
    unar
    unzip
    which
    with-shell
    z-lua
    zip
  ];
in
[]
++ nix-tools
++ misc-tools
++ shells
