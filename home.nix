{ pkgs, config, ... }:
let
  editor = "kak";
  username = "rosario";

  sources = import ./nix/sources.nix;

  ihp-new = (import "${sources.ihp}/ProjectGenerator/default.nix" { inherit pkgs; });
  obelisk = import sources.obelisk {};
in
{
  imports = [
    ./vim
    ./gpg.nix
    ./kakoune.nix
    ./archive.nix
    ./yubikey.nix
    ./git.nix
    ./graphical
  ];

  home = {
    username = username;
    homeDirectory = "/home/" + username;
    stateVersion = "21.05";

    sessionVariables = {
      EDITOR = editor;
      VISUAL = editor;
    };

    language = {
      base = "en_US.UTF-8";
      ctype = "en_US.UTF-8";
    };
  };

  systemd.user.startServices = "sd-switch";

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };

    mime.enable = true;

    mimeApps.enable = true;
  };

  home.packages = with pkgs; [
    nix
    niv

    killall
    xdg-utils

    ihp-new
    obelisk.command

    hack-font

    hunspell
    hunspellDicts.en-us

    rnix-lsp
  ];

  services.keybase.enable = true;

  programs = {
    bash.enable = true;
    bat.enable = true;
    ssh.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  dconf.enable = true;
}
