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
    # Everytime I suspend the systemd service soft dies, does not repot an error to systemd,
    # but is essentialy broken.
    spotifyd = {
      enable = true;
      package =
        pkgs.spotifyd.override {
          withMpris = true;
          # NOTE: I need to decide how I am going to deal with secrets, like my spotify password.
          # Integrating a system keyring with my password db or something might be a good idea,
          # and this option could help make use of that.
          # withKeyring = true;
        };
      settings = {
        global = {
          # For a few of these things I might want to get this data dynamicly or at least not have it in plane text in the repo

          # I am always prob going to use this user name, so I don't need to source it another way, but maybe encrypt it
          # NOTE: Might be usefull for using a better way of managing accounts.
          # I have my creds managed by something else than nix
          # username_cmd
          username = "rosariopulella@gmail.com";

          # Need different device name per device, this wont work. Maybe I can get the system's hostname dynamicly
          # Maybe maybe I use system wide spotifyd config to source
          device_name = "polaris";

          # Fine ish maybe, also maybe should be dynamic
          # Maybe I use system wide spotifyd config to source
          device_type = "computer";

          # TODO: For some reason `playerctl status` does not detect spotifyd,
          # that means mpris is not working
          # If I run the deamon from the cmdline it works
          # I started the systemd service after running and killing the deamon and it worked
          user_mpris = true;
          backend = "pulseaudio";
        };
      };
    };
  };
}
