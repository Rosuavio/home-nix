{pkgs, ... }:
{
  home.packages = with pkgs; [
    nix
    gitAndTools.gh
    gitAndTools.hub

    swaylock
    swayidle
    wl-clipboard
    alacritty
    dmenu
    slurp
    grim

    watchman
    inotify-tools

    hunspell
    hunspellDicts.en-us
    teams

    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui

    rnix-lsp

    # needed so that coc can work https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#requirements
    nodejs

    unzip

    spotify
    bitwarden
    inkscape
    libreoffice
    exercism
    haskellPackages.cabal-install
    haskellPackages.ghc

    skype
    discord
    signal-desktop
    gitter

    radicle-upstream
  ];
}
