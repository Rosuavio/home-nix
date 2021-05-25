{ pkgs, config, ... }:
let
  editor = "kak";
  username = "rosario";
in
{
  imports = [
    ./vim
    ./gpg.nix
    # ./sway.nix
    ./kakoune.nix
    ./plasma.nix
    ./archive.nix
    ./yubikey.nix
    ./firefox/firefox.nix
    ./git.nix
    ./messaging.nix
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

  # WORKAROUND: For kde's startup this is neaded to make sure we load some hm vars.
  home.file.".xprofile".text = ''. "${config.home.profileDirectory}/etc/profile.d/hm-session-vars.sh"'';

  xdg = {
    enable = true;

    userDirs.enable = true;

    mime.enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/bitwarden" = [ "Bitwarden.desktop" ];
      };
    };
  };


  home.packages = with pkgs; [
    nix

    alacritty

    watchman
    inotify-tools

    hunspell
    hunspellDicts.en-us
    okular

    rnix-lsp

    # needed so that coc can work https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#requirements
    nodejs

    spotify
    bitwarden
    inkscape
    libreoffice
    exercism

    element-desktop
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
