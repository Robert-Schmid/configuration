# https://search.nixos.org/packages

let
  pkgs = import <nixpkgs> {};
  inherit (pkgs) buildEnv;

in buildEnv {
  name = "terminal-tools";
  paths = with pkgs; [
    # Terminals ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

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

    zsh

    # Path Managment
    lorri
    direnv
    niv

    # Shell prompts
    starship # https://starship.rs

    # Text editors ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    kakoune # https://kakoune.org
#    kak-lsp # https://github.com/kak-lsp/kak-lsp
    neovim # https://neovim.io/ 

    # File managers ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈


    broot # https://dystroy.org/broot/
    # sidetree
    # https://github.com/topisani/sidetree

    # Git ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    git # https://git-scm.com
    gitAndTools.gh # https://cli.github.com
    gitAndTools.gitui # https://github.com/extrawurst/gitui

    # IRC ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    thelounge # https://thelounge.chat

    # Tools ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    # Archivers
    archiver # https://github.com/mholt/archiver
    zip # http://info-zip.org

    # Programming languages
#    jq # https://stedolan.github.io/jq/
#    bc # https://en.wikipedia.org/wiki/Bc_(programming_language)

    # Utils ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

    file # https://darwinsys.com/file/
#    socat # http://www.dest-unreach.org/socat/

    # Filesystem
#    gparted # https://gparted.org
#    gptfdisk # https://rodsbooks.com/gdisk/
#    exfat
#    ntfs3g
  ];
}

