{ config, pkgs, ... }:
let
  editor = "nvim";
in
{
  imports = [
    ./vim
    ./gpg.nix
  ];
  manual.html.enable = true;

  home.sessionVariables = {
    EDITOR = editor;
    VISUAL = editor;
  };

  home.language.base = "en_US";

  xdg = {
    enable = true;

    userDirs.enable = true;
  };

  xsession = {
    enable = false;
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = pkgs.writeText "xmonad.hs" ''
          import XMonad
          import XMonad.Config.Kde

          main = xmonad kdeConfig
        '';
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableScDaemon = true;
    };

    # lorri.enable = true;

  };

  home.file.".gnupg/scdeamon.conf".text = ''
    reader-port Yubico Yubi
  '';

  programs = {
    bash.enable = true;
    starship.enable = true;
    bat.enable = true;
    ssh.enable = true;

    git = {
      enable = true;
      userName = "Rosario Pulella";
      userEmail = "RosarioPulella@gmail.com";

      extraConfig = {
        core.editor = editor;
        diff.tool = "vimdiff";
        difftool.prompt = false;

        mergetool.prompt = false;
        merge = {
          tool = "vimdiff";
          conflictstyle = "diff3";
        };
      };
    };

    direnv = {
      enable = true;
      # enableNixDirenvIntegration = true;
    };

    firefox = {
      enable = true;

      profiles.Rosario = {
        id = 0;
        isDefault = true;
        settings = {
        };
      };
    };

  };


  home.packages = with pkgs; [
    nix
    gitAndTools.gh

    watchman
    inotify-tools

    kdeApplications.filelight
    kdeApplications.gwenview
    kdeApplications.kate
    kdeApplications.ark
    kdeApplications.dragon
    kdeApplications.okular
    kdeApplications.spectacle

    hunspell
    hunspellDicts.en-us
    vscodium
    teams

    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui

    rnix-lsp

    # Needed so that coc can work https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#requirements
    nodejs

    unzip

    spotify
    bitwarden
    krita
    inkscape
    libreoffice
    exercism
    haskellPackages.cabal-install
    haskellPackages.ghc

    skype
    discord
    signal-desktop
    gitter
  ];
}
