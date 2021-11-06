################################################################################
# To install it, copy the whole dir to ~/.config and run the command below:
#   $> nix profile install ~/.config/house/
#
# After that, use the command below in future invocations/updates:
#   $> nix profile upgrade '.*'
#
# Indeed you can use the command below instead:
#   $> HB
#
{
  description = "House, a user-home manager written in Nix (with Flakes)!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = inputs: {
    defaultPackage.x86_64-linux =
      let
        pkgs = (import (inputs.nixpkgs) {
          system = "x86_64-linux";
          overlays = [ ];
          config.allowUnfree = false;
        });
      in
        pkgs.buildEnv {
          name = "house-environment";
          extraOutputsToInstall = [
            "out"
            "bin"
            "lib"
            "man"
          ];

          paths =
            (import ./package-sets { inherit pkgs; }) ++
            []; # empty list just because I like the layout
        };
  };
}
