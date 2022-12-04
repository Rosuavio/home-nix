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
  };

  # This is supposed to enable dbus activation of mako. It does not work.
  # Because for some reason mako is crashing with 'failed to create display'
  # when started normal and not as a SystemdService.
  # xdg.dataFile."dbus-1/services/fr.emersion.mako.service".source =
  #   "${pkgs.mako}/share/dbus-1/services/fr.emersion.mako.service";
  # xdg.dataFile."dbus-1/services/fr.emersion.mako.service".text =
  #   lib.generators.toINI {} {
  #     "D-BUS Service" = {
  #       Name = "org.freedesktop.Notifications";
  #       Exec = lib.getExe pkgs.mako;
  #       # SystemdService = "mako.service";
  #     };
  #   };

  systemd.user.services = {
  #   mako = {
  #     # This just has the mako service started automatically when graphical-session.target is hit.
  #     # Install.WantedBy = [ "graphical-session.target" ];
  #     Unit = {
  #       Description = "mako notifcation deamon";
  #       Documentation = "man:mako(1)";
  #       # Why use graphical-session-pre here instead of graphical-session?
  #       # Dylan esentially suggested graphical-session.
  #       # In https://github.com/nix-community/home-manager/commit/9c17c5ccbbf5626f684eecc2ce660086ac8e249c,
  #       # rycee changed a bunch of systemd services to set the After event to graphical-session-pre.
  #       # With a dbus-activated service we dont "After" might not make any difference
  #       # Commented out because its not provided in the dunst repo.
  #       # But for some reason in the hm repo this is provieded for dunst's service
  #       # After = [ "graphical-session-pre.target" ];
  #       PartOf = [ "graphical-session.target" ];
  #       # Commented out because its not provided in the dunst repo.
  #       # But, a coworker told me to do it
  #       # StartLimitIntervalSec = 30;
  #     };
  #     Service = {
  #       Type = "dbus";
  #       BusName = "org.freedesktop.Notifications";
  #       ExecCondition = "/bin/sh -c '[ -n \"$WAYLAND_DISPLAY\" ]'";
  #       ExecStart = lib.getExe pkgs.mako;
  #       ExecReload = "${pkgs.mako}/bin/makoctl reload";
  #     };
  #   };

    safeeyes = {
      Install.WantedBy = [ "graphical-session.target" ];
      Unit = {
        Description = "Safeeyes";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
        StartLimitIntervalSec = 350;
        StartLimitBurst = 30;
      };

      Service = {
        ExecStart = lib.getExe pkgs.safeeyes;
        Restart = "on-failure";
        RestartSec = 3;

        Environment = "PATH=${lib.makeBinPath [ pkgs.alsa-utils ]}";
      };
    };
  };
}
