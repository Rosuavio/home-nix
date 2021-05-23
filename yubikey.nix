{ pkgs, config, ... }:
{

  home.file.".gnupg/scdeamon.conf".text = ''
    reader-port Yubico Yubi
  '';

  home.packages = with pkgs; [
    yubikey-manager
    yubikey-manager-qt
    yubikey-personalization
    yubikey-personalization-gui
  ];
}