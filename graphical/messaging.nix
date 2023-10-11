{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zoom-us
    # This had a wired conflict with a LICENSE file
    jitsi-meet
    discord
    signal-desktop
    slack
    element-desktop
  ];
}
