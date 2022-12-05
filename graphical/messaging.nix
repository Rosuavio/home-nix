{ pkgs, ... }:
{
  home.packages = with pkgs; [
    teams
    zoom-us
    # This had a wired conflict with a LICENSE file
    jitsi-meet
    skypeforlinux
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
