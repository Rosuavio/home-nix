{config, pkgs, lib, ...}:
let
  cfg = config.wayland.windowManager.sway;
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  light = "${pkgs.light}/bin/light";
  sModifier = "Mod4";
  lockCmd = lib.getExe pkgs.swaylock;

  nscpotInNewTerm = pkgs.writeShellScriptBin "ncspotInNewTerm" ''
    $TERM sh -c "foot" &>/dev/null &
  '';
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
      base = true;
    };

    # systemdIntegration = true;

    config = {
      modifier = sModifier;
      startup = [
        { command = "mkfifo $SWAYSOCK.wob && tail -f $SWAYSOCK.wob | ${pkgs.wob}/bin/wob"; }
        # { command = "${nscpotInNewTerm}/bin/nscpotInNewTerm"; }
        { command = "element-desktop"; }
        { command = "signal-desktop"; }
      ];
      workspaceOutputAssign = [
        { workspace = "1"; output = "\"Dell Inc. DELL S3221QS H8CQTB3\""; }
        { workspace = "2"; output = "\"Dell Inc. DELL S3221QS H8CQTB3\""; }
        { workspace = "3"; output = "\"Dell Inc. DELL S3221QS H8CQTB3\""; }
        { workspace = "4"; output = "\"Dell Inc. DELL S3221QS H8CQTB3\""; }
        { workspace = "5"; output = "\"Dell Inc. DELL S3221QS H8CQTB3\""; }
        { workspace = "6"; output = "\"Dell Inc. DELL S3221QS H8CQTB3\""; }
        { workspace = "7"; output = "\"Dell Inc. DELL S3221QS H8CQTB3\""; }
        { workspace = "8"; output = "\"Dell Inc. DELL P2415Q 59JJ479U04NB\""; }
        { workspace = "9: other"; output = "\"Dell Inc. DELL P2415Q G3D7F6BQ08PL\""; }
      ];
      assigns = {
        "9: other" = [
          { class = "Slack"; }
          { class = "Element"; }
          { class = "Signal"; }
          { class = "discord"; }
        ];
      };
      terminal = "${pkgs.foot}/bin/foot";

      output = {
        "*" = {
          bg = "#000000 solid_color";
        };
        "Dell Inc. DELL S3221QS H8CQTB3" = {
          pos = "0 0";
        };
        "Dell Inc. DELL P2415Q 59JJ479U04NB" = {
          mode = "2560x1440";
          transform = "270";
          pos = "3840 0";
        };
        "Dell Inc. DELL P2415Q G3D7F6BQ08PL" = {
          mode = "2560x1440";
          transform = "270";
          pos = "5280 0";
        };
      };

      colors = {
        focused = {
          background = "#287729";
          border = "#6cd998";
          childBorder = "#2e7328";
          indicator = "#32ff32";
          text = "#ffffff";
        };

        focusedInactive = {
          background = "#3f5f40";
          border = "#88bf9e";
          childBorder = "#405c3d";
          indicator = "#66cc66";
          text = "#ffffff";
        };
      };

      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };

      focus.followMouse = false;

      keybindings =
        pkgs.lib.mkOptionDefault {
          "${sModifier}+ctrl+shift+h" = "move workspace to output left";
          "${sModifier}+ctrl+shift+l" = "move workspace to output right";
          "${sModifier}+ctrl+l" = "exec ${lockCmd} -f -i ${./lockscreen.png}";

          XF86MonBrightnessDown = "exec ${bctl} -q set 5%- && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
          XF86MonBrightnessUp   = "exec ${bctl} -q set +5% && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";

          # PulseAudio needs to be on the system, maybe check first.
          XF86AudioRaiseVolume = "exec ${pamixer} -ui 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
          XF86AudioLowerVolume = "exec ${pamixer} -ud 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
          XF86AudioMute = "exec ${pamixer} --toggle-mute && ( ${pamixer} --get-mute && echo 0 > $SWAYSOCK.wob ) || ${pamixer} --get-volume > $SWAYSOCK.wob";
          # If no pactl then fallback to alsa
          XF86AudioMicMute = "exec ${pactl} set-source-mute 1 toggle";
        };
      menu = "rofi -show run";
      # modifier = "";

      gaps = {
        smartGaps = true;
        inner = 12;
      };
    };

    extraConfig = ''
      exec "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP; systemctl --user start sway-session.target
    '';

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1

      export CLUTTER_BACKEND=wayland

      export XDG_CURRENT_DESKTOP="sway"
      export XDG_SESSION_TYPE="wayland"
    '';
  };
  systemd.user.targets.sway-session = {
    Unit = {
      Description = "sway compositor session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };
}
