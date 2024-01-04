{config, pkgs, lib, ...}:
let
  cfg = config.wayland.windowManager.sway;
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  light = "${pkgs.light}/bin/light";
  sModifier = "Mod4";
  lockCmd = lib.getExe pkgs.swaylock;
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures = {
      gtk = true;
      base = true;
    };

    systemd = {
      enable = true;
      xdgAutostart = true;
    };

    config = {
      modifier = sModifier;
      startup = [
        { command = "mkfifo $SWAYSOCK.wob && tail -f $SWAYSOCK.wob | ${pkgs.wob}/bin/wob"; }
        { command = "element-desktop"; }
        { command = "signal-desktop"; }
      ];
      assigns = {
        "9: other" = [
          { class = "Slack"; }
          { class = "Element"; }
          { class = "Signal"; }
          { class = "discord"; }
        ];
      };
      terminal = lib.getExe config.programs.foot.package;

      output = {
        "*" = {
          bg = "#000000 solid_color";
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
      menu = "${lib.getExe config.programs.rofi.finalPackage} -show run";
      # modifier = "";

      gaps = {
        smartGaps = true;
        inner = 12;
      };
    };

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland

      # Xwayland compatibility
      export XWAYLAND_NO_GLAMOR=1

      export XDG_SESSION_TYPE=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1

      export CLUTTER_BACKEND=wayland
    '';
  };
}
