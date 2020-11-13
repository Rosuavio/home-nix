{ pkgs, ... }:
let
  editor = "nvim";
  username = "rosario";
in
{
  imports = [
    ./vim
    ./gpg.nix
    ./xdg.nix
    ./services.nix
    ./programs.nix
  ];
  manual.html.enable = true;

  home = {
    username = username;
    homeDirectory = "/home/" + username;
    stateVersion = "20.09";

    sessionVariables = {
      SHELL = pkgs.fish;
      THING = pkgs.fish;
      Stuff = editor;
      EDITOR = editor;
      VISUAL = editor;
    };

    language.base = "en_US";
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

 home.file.".gnupg/scdeamon.conf".text = ''
    reader-port Yubico Yubi
  '';

  home.packages = import ./packages.nix pkgs;
}
