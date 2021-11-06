# How to find Emacs packages:
# nix-env -f "<nixpkgs>" -qaP -A emacsPackages

# These commands work too:
# nix-env -f "<nixpkgs>" -qaP -A emacsPackages.elpaPackages
# nix-env -f "<nixpkgs>" -qaP -A emacsPackages.melpaPackages
# nix-env -f "<nixpkgs>" -qaP -A emacsPackages.melpaStablePackages
# nix-env -f "<nixpkgs>" -qaP -A emacsPackages.orgPackages

{ pkgs }:

let
  emacsPkg = pkgs.emacs.override {
    withGTK2 = false;
    withGTK3 = true;
    withMotif = false;
    toolkit = "gtk3";
  };
  emacsPackagesGen = (pkgs.emacsPackagesFor emacsPkg);
  emacsWithPackages = (emacsPackagesGen.emacsWithPackages);
  my-emacs = emacsWithPackages
    (epkgs: with epkgs;
      let
        epkgs-modes = with epkgs; [
          adoc-mode
          bison-mode
          # bnf-mode - failing
          brainfuck-mode
          # cask-mode - failing
          # cmake-mode
          elvish-mode
          fish-mode
          forth-mode
          frame-mode
          god-mode
          gnu-apl-mode
          hardcore-mode
          haskell-mode
          json-mode
          lua-mode
          markdown-mode
          meson-mode
          ninja-mode
          nix-mode
          rust-mode
          toml-mode
          yaml-mode
          zig-mode
        ];

        epkgs-themes = with epkgs; [
          abyss-theme
          acme-theme
          afternoon-theme
          ahungry-theme
          alect-themes
          almost-mono-themes
          anti-zenburn-theme
          avk-emacs-themes
          badger-theme
          base16-theme
          # basic-theme # buggy
          birds-of-paradise-plus-theme
          borland-blue-theme
          brutalist-theme
          caroline-theme
          cherry-blossom-theme
          chyla-theme
          color-theme
          color-theme-approximate
          color-theme-buffer-local
          color-theme-modern
          color-theme-sanityinc-solarized
          color-theme-sanityinc-tomorrow
          color-theme-x
          colorThemeSolarized
          colorless-themes
          cyberpunk-theme
          cloud-theme
          doom-themes
          dracula-theme
          eink-theme
          # ewal-spacemacs-themes
          faff-theme
          grandshell-theme
          hemisu-theme
          humanoid-themes
          leuven-theme
          material-theme
          # melancholy-theme # broken?
          minimal-theme
          monokai-theme
          nofrils-acme-theme
          nord-theme
          paper-theme
          plan9-theme
          qtcreator-theme
          solarized-theme
          soothe-theme
          spacemacs-theme
          termbright-theme
          toxi-theme
          ubuntu-theme
          vs-light-theme
          vs-dark-theme
          waher-theme
          warm-night-theme
          weyland-yutani-theme
          yoshi-theme
          zweilight-theme
        ];

        epkgs-modelines = with epkgs; [
          airline-themes
          doom-modeline
          powerline
          smart-mode-line
          spaceline
          spaceline-all-the-icons
          telephone-line
        ];

        epkgs-misc = with epkgs; [
          # alsamixer
          # cask - failing
          # company-auctex
          # mpv
          # projectile-direnv # broken
          # w3
          # yasnippet
          # yasnippet-snippets
          # ztree
          ace-window
          aggressive-fill-paragraph
          aggressive-indent
          all-the-icons
          all-the-icons-dired
          amx
          auto-complete
          bar-cursor
          beacon
          beginend
          better-shell
          bind-chord
          bind-key
          bind-map
          blackout
          bongo
          buffer-move
          bug-hunter
          centaur-tabs
          company
          company-lua
          company-math
          company-quickhelp
          company-shell
          consult
          counsel
          crux
          ctrlf
          dash
          dashboard
          delight
          diminish
          dimmer
          direnv
          disable-mouse
          dynamic-ruler
          editorconfig
          eglot
          elscreen
          embark
          emms
          envrc
          esup
          expand-line
          expand-region
          eyebrowse
          fill-column-indicator
          flx
          # flx-ido
          flycheck
          gcmh
          general
          helm
          helm-flx
          highlight-parentheses
          historian
          htmlize
          hungry-delete
          icomplete-vertical
          ivy
          ivy-historian
          leaf
          leaf-convert
          leaf-keywords
          leaf-manager
          leaf-tree
          magit
          marginalia
          meghanada
          meow
          mini-frame
          minimap
          modalka
          multi-vterm
          multiple-cursors
          # multishell
          names
          neotree
          nyan-mode
          no-littering
          number-lock
          orderless
          origami
          outshine
          paperless
          paredit
          paredit-menu
          pdf-tools
          prescient
          prism
          projectile
          rainbow-delimiters
          rg
          ryo-modal
          rmsbolt
          selected
          selectrum
          selectrum-prescient
          setup
          shell-command-plus
          shx
          smartparens
          spacebar
          sr-speedbar
          sunrise-commander
          super-save
          switch-window
          transient
          treemacs
          tuareg
          # undo-fu
          undo-tree
          unfill
          vdiff
          vertico
          visual-fill-column
          vterm
          vterm-toggle
          wanderlust
          weblorg
          which-key
          window-purpose
          yafolding
          yankpad
        ];

        epkgs-org = with epkgs; [
          # org-plus-contrib
          org-contrib
          org-journal
          org-superstar
        ];

        extra = with pkgs; [
          auctex
        ];
      in
        []
        ++ epkgs-misc
        ++ epkgs-modelines
        ++ epkgs-modes
        ++ epkgs-themes
        ++ epkgs-org
        ++ extra
    );
in
[ my-emacs ]
