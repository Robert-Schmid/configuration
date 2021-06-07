# NixOS
# https://nixos.org/manual/nixos/stable/
# https://search.nixos.org/packages
# https://search.nixos.org/options
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  # Flakes ─────────────────────────────────────────────────────────────────────

  # Flakes
  # https://nixos.wiki/wiki/Flakes
#  nix = {
#    package = pkgs.nixFlakes;
#    extraOptions = ''
#      experimental-features = nix-command flakes
#    '';
#  };

  # File systems ───────────────────────────────────────────────────────────────

  # boot.supportedFilesystems = [ "zfs" ];

  # Options ────────────────────────────────────────────────────────────────────

  # Page: https://search.nixos.org/options

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Generate the 32-bit host ID of the machine with:
  # head [--bytes -c] 8 /etc/machine-id
#  networking.hostId = "0338c82e";
  # Note: ZFS requires networking.hostId to be set.
#  networking.enableIPv6 = false;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # AdBlock via /etc/hosts
  # https://github.com/StevenBlack/hosts
#  networking.extraHosts = builtins.readFile /home/taupiqueur/repositories/github.com/StevenBlack/hosts/hosts;


  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Location: Konstanz
  # https://google.com/search?q=Konstanz+Coordinates
  location.latitude = 47.6779;
  location.longitude = 9.1732;


  # Security
  # Do not prompt for password
#  security.sudo.wheelNeedsPassword = false;


  # Optimization – Speed-up builds
  # Jobs to run in parallel
#  nix.maxJobs = 1;
  # Use all available cores when set to 0
#  nix.buildCores = 1;


  # Lower the Nix daemon process priority
  # nix.daemonNiceLevel = 19;
  # nix.daemonIONiceLevel = 7;


  # CPU throttling
  # systemd.enableCgroupAccounting = true;
  # systemd.services.nix-daemon.serviceConfig.CPUQuota = "10%";


  # Automatic Upgrades
  # https://nixos.org/manual/nixos/stable#sec-upgrading-automatic
  # system.autoUpgrade.enable = true;


  # Cleaning the Nix Store
  # https://nixos.org/manual/nixos/stable#sec-nix-gc
#  nix.gc.automatic = true;


  # Clean temporary files during boot
#  boot.cleanTmpDir = true;

  # Boot ───────────────────────────────────────────────────────────────────────

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fix Linux slow CPU
  # https://discourse.nixos.org/t/browsers-unbearably-slow-after-update/9414
  boot.kernelParams = [ "intel_pstate=active" ];

  # Users ──────────────────────────────────────────────────────────────────────

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.robert = {
    uid = 1000;
    # Indicates whether this is an account for a real user.
    # In other words, set a bunch of options for us.
    # https://search.nixos.org/options?query=isNormalUser
    isNormalUser = true;
#    shell = pkgs.nushell;
    extraGroups = [
      "audio"
#      "disk"
      "docker"
#      "games"
#      "lxd"
#      "networkmanager"
      "sway"
#      "vboxusers"
#      "video"
      "wheel"
    ];
  };

  users.extraUsers.robert = {
    shell = pkgs.nushell;
  };

  # Services ───────────────────────────────────────────────────────────────────

  # Login
#  services.logind.lidSwitch = "ignore";
#  services.logind.extraConfig = ''
#    HandlePowerKey=hibernate
#    HandleSuspendKey=suspend
#    HandleHibernateKey=hibernate
#  '';


  # Networking
#  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # SSH
#  services.openssh.enable = true;


  # Printing
#  services.printing.enable = true;


  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  # Fonts
  # https://nixos.wiki/wiki/Fonts
  fonts.fonts = with pkgs; [
    terminus # http://terminus-font.sourceforge.net
    dejavu_fonts # https://dejavu-fonts.github.io
    font-awesome # https://fontawesome.com
  ];


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable docker
  virtualisation.docker.enable = true;
  virtualisation.docker.enableNvidia = true;
  hardware.opengl.driSupport32Bit = true;

  # Window Manager ─────────────────────────────────────────────────────────────

 # Wayland / Sway

  # Wayland compositors
  # Sway
  # https://swaywm.org
  # also see: https://nixos.wiki/wiki/Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    extraPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      mako # notification daemon
      alacritty # Alacritty is the default terminal in the config
      wofi
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true ;
  };
 
  # Backlight
#  programs.light.enable = true;

  # Redshift
#  services.redshift.enable = true;
#  services.redshift.package = pkgs.redshift-wlr;

 # Packages ───────────────────────────────────────────────────────────────────

  # Unfree
  # Discord, Chrome, etc
  nixpkgs.config = {
    allowUnfree = true;

    # create an alias for the unstable channel
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };

  # https://search.nixos.org/packages

  environment.systemPackages = with pkgs; [

    # Terminals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    alacritty # https://github.com/alacritty/alacritty

    # Terminal multiplexers
    # zellij
    # https://zellij.dev
    # tab-rs
    # https://github.com/austinjones/tab-rs
    pueue # https://github.com/Nukesor/pueue
    tmux
    tmux-xpanes #https://github.com/greymd/tmux-xpanes

    # Fuzzy finders
    fzf # https://github.com/junegunn/fzf

    # Terminal tools
    tldr # man – https://tldr.sh
    glow # Markdown – https://github.com/charmbracelet/glow

    # Terminal utils
    exa # ls – https://the.exa.website
    fd # find – https://github.com/sharkdp/fd
    bat # cat – https://github.com/sharkdp/bat
    pastel # https://github.com/sharkdp/pastel
    ripgrep # grep – https://github.com/BurntSushi/ripgrep
    procs # ps – https://github.com/dalance/procs
    htop # top – https://htop.dev
    wget
    neofetch # https://github.com/dylanaraps/neofetch

    # Shells ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    unstable.nushell # https://nushell.sh
#    dash # http://gondor.apana.org.au/~herbert/dash/

    # Shell prompts
    starship # https://starship.rs

    # Text editors ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    kakoune # https://kakoune.org
#    kak-lsp # https://github.com/kak-lsp/kak-lsp
    neovim # https://neovim.io/ 

    # File managers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    broot # https://dystroy.org/broot/
    # xplr
    # https://github.com/sayanarijit/xplr
    # sidetree
    # https://github.com/topisani/sidetree

    # Git ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    git # https://git-scm.com
    gitAndTools.gh # https://cli.github.com
    gitAndTools.gitui # https://github.com/extrawurst/gitui

    # Email clients ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

#    aerc # https://aerc-mail.org

    # Torrents ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

#    synapse-bt # https://synapse-bt.org

    # IRC ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

#    thelounge # https://thelounge.chat

    # E-Books ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    calibre # https://calibre-ebook.com/

    # Web browsers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    chromium # https://chromium.org
    google-chrome # https://google.com/chrome/
    # firefox # https://mozilla.org/firefox/

    # Media players ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

#    mpv # https://mpv.io

    # Dependencies for mpv scripts
#    translate-shell # https://www.soimort.org/translate-shell/

    # Utils
#    ffmpeg-full # FFmpeg https://ffmpeg.org
#    youtube-dl # https://yt-dl.org

    # Videos editors ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

#    olive-editor # https://olivevideoeditor.org

    # Document viewers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    zathura # https://pwmt.org/projects/zathura/

    # Document converters
#    pandoc # https://pandoc.org
#    tectonic # https://tectonic-typesetting.github.io
    # img2pdf # https://gitlab.mister-muffin.de/josch/img2pdf

    # Desktop environments ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Networking
    networkmanager # https://wiki.gnome.org/Projects/NetworkManager

    # Audio
    pavucontrol # https://freedesktop.org/software/pulseaudio/pavucontrol/

    # Backlight
    #light # https://haikarainen.github.io/light/
    #redshift-wlr # http://jonls.dk/redshift/ (Wayland patch)

    # Wayland ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Wayland
    wayland # https://wayland.freedesktop.org
    #xwayland # https://wayland.freedesktop.org/xserver.html

    # Sway
    sway # https://swaywm.org
    swaybg # https://github.com/swaywm/swaybg
    swayidle # https://github.com/swaywm/swayidle
    swaylock # https://github.com/swaywm/swaylock

    # Services
#    kanshi # Output configuration – https://wayland.emersion.fr/kanshi/
    mako # Notifications – https://wayland.emersion.fr/mako/

    # Clipboard
    wl-clipboard # https://github.com/bugaevc/wl-clipboard

    # Screenshots
#    grim # https://wayland.emersion.fr/grim/
#    slurp # https://wayland.emersion.fr/slurp/

    # Screencast
#    wf-recorder # https://github.com/ammen99/wf-recorder

    # Utils
#    wev # https://git.sr.ht/~sircmpwn/wev
#    wlr-randr # https://github.com/emersion/wlr-randr

    # Messaging ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    discord # https://discord.com
#    gitter # https://gitter.im
    zoom-us # https://zoom.us/

    # Virtualization ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    kubectl # https://kubernetes.io/docs/reference/kubectl/overview/
    docker # https://docker.com
#    appimage-run # https://github.com/NixOS/nixpkgs/tree/master/pkgs/tools/package-management/appimage-run

    # Android ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

#    android-file-transfer # https://whoozle.github.io/android-file-transfer-linux/

    # Tools ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Archivers
#    archiver # https://github.com/mholt/archiver
#    zip # http://info-zip.org

    # Programming languages
#    jq # https://stedolan.github.io/jq/
#    bc # https://en.wikipedia.org/wiki/Bc_(programming_language)

    # Utils ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    file # https://darwinsys.com/file/
#    socat # http://www.dest-unreach.org/socat/

    # Filesystem
    gparted # https://gparted.org
    gptfdisk # https://rodsbooks.com/gdisk/

    # Watchers
#    inotify-tools # https://github.com/inotify-tools/inotify-tools

    # XDG
#    xdg_utils # https://freedesktop.org/wiki/Software/xdg-utils/ (provides xdg-open)

    # Notifications
#    libnotify # https://developer.gnome.org/notification-spec/ (provides notify-send)

    # Web ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Static site generators
#    hugo # https://gohugo.io

    # Services
#    ngrok # https://ngrok.com
#    heroku # https://heroku.com

    # Servers
#    nginx # https://nginx.org

    # Database
#    sqlite # https://sqlite.org
#    sqlitebrowser # https://sqlitebrowser.org
#    redis # https://redis.io

    # Programming languages ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # C
#    clang # https://clang.llvm.org
#    llvm # https://llvm.org

    # Build systems
#    gnumake # https://gnu.org/software/make/
#    pkg-config # https://freedesktop.org/wiki/Software/pkg-config/
#    meson # https://mesonbuild.com
#    ninja # https://ninja-build.org

    # Rust
    # https://rust-lang.org
    rustc
    cargo # https://crates.io
    rustup # https://rustup.rs

    # JavaScript
#    nodejs_latest # https://nodejs.org
#    yarn # https://yarnpkg.com
#    flow # https://flow.org

    # Python
    # https://python.org
    python39
    python39Packages.pip # https://pip.pypa.io

    # Haskell
    # https://haskell.org
#    ghc # https://haskell.org/ghc/
#    cabal-install # https://hackage.haskell.org/package/cabal-install

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
