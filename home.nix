{ pkgs, config, ... }:
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
    ./packages.nix
    ./sway.nix
    ./kakoune.nix
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

  home.file.".gnupg/scdeamon.conf".text = ''
    reader-port Yubico Yubi
  '';
}
