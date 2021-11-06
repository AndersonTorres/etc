{ pkgs }:

[] # this empty list is just because I like the uniform layout below
++ (import ./essential.nix { inherit pkgs; })
# ++ (import ./arcan.nix { inherit pkgs; })
++ (import ./emacs.nix { inherit pkgs; })
++ (import ./graphics.nix { inherit pkgs; })
++ (import ./misc.nix { inherit pkgs; })
++ (import ./multimedia.nix { inherit pkgs; })
++ (import ./networking.nix { inherit pkgs; })
++ (import ./tools.nix { inherit pkgs; })
++ (import ./vcs.nix { inherit pkgs; })
++ (import ./virtual-machines.nix { inherit pkgs; })
++ (import ./wayland.nix { inherit pkgs; })
