{pkgs, ... }:
{
  home.packages = with pkgs; [
    nix
    gitAndTools.gh
    gitAndTools.hub

    alacritty

    watchman
    inotify-tools

    hunspell
    hunspellDicts.en-us
    teams
    okular

    zoom-us

    rnix-lsp

    # needed so that coc can work https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#requirements
    nodejs

    spotify
    bitwarden
    inkscape
    libreoffice
    exercism

    skype
    discord
    signal-desktop
    gitter

    radicle-upstream
  ];
}
