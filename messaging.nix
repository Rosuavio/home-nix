{ pkgs, ... }:
{
  home.packages = with pkgs; [
    teams
    zoom-us
    jitsi-meet
    skype
    discord
    signal-desktop
    gitter
    slack
    element-desktop
  ];

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/msteams" = [ "teams.desktop" ];
  };
}
