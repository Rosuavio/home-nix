{pkgs, ...}:
{
  home.packages = with pkgs; [
    pulsemixer
    playerctl
    spotify-tui
  ];

  services = {
    # Enable playerctld services that keeps track of media player activity to direct commands to most recently active app
    # https://github.com/altdesktop/playerctl
    playerctld.enable = true;

    # Forwards bluetooth media controls to MPRIS commands
    mpris-proxy.enable = true;
  };
}
