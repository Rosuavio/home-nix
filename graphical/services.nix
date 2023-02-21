{ pkgs, lib, ...}:
let
  lockpkg = pkgs.swaylock;
  minutes = minutes: minutes * 60;
  lockCmd = lib.getExe lockpkg;
  allOutputsDpms = x: ''${pkgs.sway}/bin/swaymsg "output * dpms ${x}"'';
in
{
  home.packages = [
    lockpkg
    pkgs.safeeyes
  ];

  programs = {
    mako = {
      enable = true;
      defaultTimeout = 1000 * 5;
    };
  };

  services = {
    wlsunset = {
      enable = true;
      latitude = "28.636591";
      longitude = "-81.371088";
    };

    swayidle = {
      enable = true;
      events = [
        { event = "before-sleep"; command = "${lockCmd} -f -i ${./lockscreen.png}"; }
        { event = "lock"; command = "lock"; }
      ];

      timeouts = [
        { timeout = minutes 15;
          command = "${lockCmd} -f -i ${./lockscreen.png}";
        }
        { timeout = minutes 20;
          command = allOutputsDpms "off";

          resumeCommand = allOutputsDpms "on";
        }
        # { timeout = minutes 30;
        #   command = ''systemctl suspend'';
        #   resumeCommand = allOutputsDpms "on";
        # }
      ];
    };

    safeeyes.enable = true;
  };

  # Add this to home-manager
  # https://github.com/nix-community/home-manager/compare/master...Rosuavio:home-manager:master
  systemd.user.services.safeeyes = {
    Unit.After = [ "graphical-session-pre.target" ];
    Service.Environment = "PATH=${lib.makeBinPath [ pkgs.alsa-utils ]}";
  };
}
