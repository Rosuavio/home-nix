{ pkgs, config, ... }:
let
  editor = "kak";
  username = "rosario";
in
{
  imports = [
    ./vim
    ./gpg.nix
    ./xdg.nix
    # ./sway.nix
    ./kakoune.nix
    ./plasma.nix
    ./archive.nix
    ./yubikey.nix
    ./firefox/firefox.nix
    ./git.nix
  ];

  home = {
    username = username;
    homeDirectory = "/home/" + username;
    stateVersion = "20.09";

    sessionVariables = {
      EDITOR = editor;
      VISUAL = editor;
    };

    language.base = "en_US";
  };

  home.packages = with pkgs; [
    nix

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
  ];

  programs = {
    bash.enable = true;
    bat.enable = true;
    ssh.enable = true;

    vscode = {
      enable = true;
      package = pkgs.vscodium;
    };

    chromium = {
      enable = true;
      package = pkgs.brave;
    };
  };
}
