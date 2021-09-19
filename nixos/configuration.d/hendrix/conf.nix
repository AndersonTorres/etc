{ config
, lib
, pkgs
, modulesPath
, options
, ...
}:

{
  ###
  boot = {
    kernel.sysctl."kernel.sysrq" = 1;

    kernelParams = [
      "pci=nommconf"
      # "pci=noaer" # Advanced Error Report
      # "pci=nomsi" # MSI interrupts
      "pcie_aspm=off" # Active State Power Management
      # "iommu=1"
      # "amd_iommu=on"
      "idle=nomwait"
    ];

    loader.timeout = 30;
    loader.efi.canTouchEfiVariables = false;

    loader.grub = {
      enable = true;
      forceInstall = false;

      copyKernels = true;
      devices = [ "nodev" ];
      efiInstallAsRemovable = true;
      efiSupport = true;
      fsIdentifier = "label";
      # splashImage = "/etc/nixos/share/boot-backgrounds/dummy.png";
      splashMode = "stretch";

      backgroundColor = "#000000";

      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
     '';
    };
  };

  ###
  # console.font = "latarcyrheb-sun32";
  console.keyMap = "us-acentos";

  ###
  documentation = {
    enable = true;
    dev.enable = true;
    doc.enable = true;
    info.enable = true;
    man.enable = true;
    nixos.enable = true;
  };

  ###
  hardware = {
    cpu.amd.updateMicrocode = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ ]; # Trocar em breve!
      driSupport = true;
    };
  };

  ###
  networking = {
    hostName = "hendrix";
    networkmanager = {
      enable = true;
      enableStrongSwan = false;
    };

    firewall.enable = false;
  };

  ###
  nix = {
    package = pkgs.nixUnstable;
    settings = {
      cores = 6;
      extra-sandbox-paths = [ "/dev" "/proc" "/sys" ];
      max-jobs  = 4; # pkgs.lib.mkForce 4;
      sandbox = true; # pkgs.lib.mkForce true;
      substituters = [ ];
    };

    nrBuildUsers = 10;
    readOnlyStore = true;

    extraOptions = ''
      binary-caches-parallel-connections = 10
      build-keep-log = true
      build-use-substitutes = true
      experimental-features = nix-command flakes
      gc-keep-derivations = true
      gc-keep-outputs = true
    '';

    sshServe.enable = false;

    gc.automatic = false;
    gc.dates = "12:00";

    # remember to set nixPath and registry too
  };

  nixpkgs.overlays = [ ];

  system.nixos.tags = [
    "hendrix"
    "flake"
  ];
  
  # sound conflict with pipewire
  sound.enable = false;

  security = {
    # rtkit is optional for pipewire, but recommended
    rtkit.enable = true;

    sudo = {
      enable = false;
      wheelNeedsPassword = false;
    };

    doas = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  ###
  services.gpm.enable = false;
  services.gpm.protocol = "imps/2";
  services.ntp.enable = false;
  services.openssh.enable = false;
  services.upower.enable = true;

  services.kmscon = {
    enable = true;
    # hwRender = true;
    extraConfig = ''
      # font-name = Inconsolata
      font-size = 14
      term = xterm-256color
      sb-size = 2500
      xkb-layout = us
      xkb-variant = intl
      xkb-model = abnt
      xkb-repeat-delay = 250
      xkb-repeat-rate = 50
      drm = on
    '';
  };

  services.printing = {
    enable = false;
    tempDir = "/tmp/cups";
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    #media-session.enable = true;

    config.pipewire = {
      "context.properties" = {
        #"link.max-buffers" = 64;
        "link.max-buffers" = 16; # version < 3 clients can't handle more than this
        "log.level" = 2; # https://docs.pipewire.org/#Logging
        #"default.clock.rate" = 48000;
        #"default.clock.quantum" = 1024;
        #"default.clock.min-quantum" = 32;
        #"default.clock.max-quantum" = 8192;
      };
      "context.objects" = [
        {
          # A default dummy driver. This handles nodes marked with the "node.always-driver"
          # properyty when no other driver is currently active. JACK clients need this.
          factory = "spa-node-factory";
          args = {
            "factory.name"     = "support.node.driver";
            "node.name"        = "Dummy-Driver";
            "priority.driver"  = 8000;
          };
        }
        {
          factory = "adapter";
          args = {
            "factory.name"     = "support.null-audio-sink";
            "node.name"        = "Microphone-Proxy";
            "node.description" = "Microphone";
            "media.class"      = "Audio/Source/Virtual";
            "audio.position"   = "MONO";
          };
        }
        {
          factory = "adapter";
          args = {
            "factory.name"     = "support.null-audio-sink";
            "node.name"        = "Main-Output-Proxy";
            "node.description" = "Main Output";
            "media.class"      = "Audio/Sink";
            "audio.position"   = "FL,FR";
          };
        }
      ];
    };
  };

  services.xserver = {
    enable = true;
    autorun = false;

    enableCtrlAltBackspace = true;
    layout = "us";
    #   xkbOptions = "eurosign:e";
    xkbModel = "pc104";
    xkbVariant = "intl";
    useGlamor = true;
    exportConfiguration = true;
    videoDrivers =  [
      "amdgpu"
      # "ati"
      # "radeon"
      # "vesa"
      # "cirrus"
      # "modesetting"
      # "fbdev"
    ];

    # Touchpad support.
    libinput = {
      enable = true; # incompatible with synaptics
      mouse = {
        accelProfile = "adaptive";
        accelSpeed = "0.050";
        buttonMapping = "1 2 3";
        disableWhileTyping = true;
      };
    };

    synaptics = {
      enable = false; # incompatible with libinput
      accelFactor = "0.050";
      buttonsMap = [ 1 2 3 ];
      fingersMap = [ 1 3 2 ];
      horizontalScroll = true;
      minSpeed = "0.5";
      maxSpeed = "1.5";
      tapButtons = true;
      twoFingerScroll = true;
      vertEdgeScroll = true;
      palmDetect = true;
    };

    #   displayManager.lightdm.enable = false;
    displayManager.startx.enable = true;
    # displayManager.sx.enable = false;

    desktopManager = {
      enlightenment.enable = false;
      gnome.enable = false;
      lumina.enable = false;
      lxqt.enable = false;
      mate.enable = false;
      plasma5.enable = false;
      xfce.enable = true;
      xterm.enable = true;
    };

    windowManager = {
      # cwm.enable = true;
      # jwm.enable = true;
      # matchbox.enable = true;
      # metacity.enable = true;
      # mwm.enable = true;
      # oroborus.enable = true;
      # pekwm.enable = true;
      # qtile.enable = true;
      # sawfish.enable = true;
      # twm.enable = true;
      # wmii.enable = true;
      evilwm.enable = false;
      fluxbox.enable = true;
      icewm.enable = true;
      notion.enable = false;
      openbox.enable = true;
      ratpoison.enable = true;
      spectrwm.enable = false;
      stumpwm.enable = false;
      windowlab.enable = false;
      windowmaker.enable = true;
    };
  };

  time.timeZone = "America/Sao_Paulo";

  ###
  users = {
    mutableUsers = true;
    enforceIdUniqueness = true;
    defaultUserShell = "/run/current-system/sw/bin/bash";
    users."visita" = {
      description = "Visita";
      isNormalUser = true;
      password = "";
    };
  };

  ###
  virtualisation = {
    virtualbox = {
      guest.enable = false;
      host = {
        enable = true;
        enableHardening = true;
        addNetworkInterface = true;
        headless = false;
      };
    };

    libvirtd = {
      enable = false;
      qemu.package = pkgs.qemu_kvm;
    };
  };  

  ###
  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = true;
    fontconfig = {
      enable = true;
      hinting.enable = true;
      includeUserConf = true;
    };

    fonts = with pkgs; [
      # monoid
      anonymousPro
      dina-font
      fantasque-sans-mono
      fira-code
      fira-code-symbols
      hack-font
      junicode
      liberation_ttf
      # mplus-outline-fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      profont
      proggyfonts
      recursive
      roboto
      roboto-mono
      roboto-slab
      source-code-pro
    ];
  };

  ### System packages
  environment.systemPackages = let
    emacsWithPackages = (pkgs.emacsPackagesFor pkgs.emacs-nox).emacsWithPackages;
    custom-emacs = emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
      # Useful for editing Nix files! :)
      nix-mode
    ]));
  in
    with pkgs; [
      # xorg.xdpyinfo xcompmgr
      # sway weston
      curl
      custom-emacs
      dmidecode
      elinks
      exfat
      f2fs-tools
      fontconfig
      gitMinimal
      gparted
      jfsutils
      micro
      nix-diff
      nix-du
      nix-index
      nix-prefetch
      nix-prefetch-scripts
      nix-tour
      nix-universal-prefetch
      pciutils
      rsync zsync
      wget
      xfsprogs
    ];
}
