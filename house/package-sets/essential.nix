{ pkgs }:

[
  pkgs.nixUnstable
  pkgs.cacert

  (pkgs.writeTextFile {
    name = "HB";
    destination = "/bin/HB";
    executable = true;
    text = ''
      #!${pkgs.runtimeShell}

      nix profile upgrade '.*'
    '';
  })

  # TODO: Use this file for more info
  (pkgs.writeTextFile {
    name = "nixpkgs-version";
    destination = "/nixpkgs-version";
    text = pkgs.lib.version;
  })
]
