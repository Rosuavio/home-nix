{ pkgs, ... }:
{
  home.packages = with pkgs; [
    teams
    zoom-us
    skype
    discord
    signal-desktop
    gitter
  ];

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/msteams" = [ "teams.desktop" ];
  };
}
