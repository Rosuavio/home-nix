{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zoom-us
    # This had a wired conflict with a LICENSE file
    jitsi-meet
    webcord-vencord
    signal-desktop
    slack
    element-desktop
  ];
}
