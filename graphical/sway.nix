{config, pkgs, ...}:
let
  cfg = config.wayland.windowManager.sway;
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  light = "${pkgs.light}/bin/light";
  swaylock = "${pkgs.swaylock}/bin/swaylock";
  sModifier = "Mod4";
in
{
  config = {
    home.sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
    };

    programs.mako = {
      enable = true;
      defaultTimeout = 10 * 1000;
    };

    services.wlsunset = {
      enable = true;
      latitude = "28.636591";
      longitude = "-81.371088";
    };
  };

  config.wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    systemdIntegration = true;

    config = {
      modifier = sModifier;
      startup = [
        { command = "mkfifo $SWAYSOCK.wob && tail -f $SWAYSOCK.wob | ${pkgs.wob}/bin/wob"; }
      ];
      terminal = "${pkgs.foot}/bin/foot";
      input = {
        "type:touchpad" = {
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };

      keybindings =
        pkgs.lib.mkOptionDefault {
          "${sModifier}+ctrl+l" = "exec ${swaylock}";

          XF86MonBrightnessDown = "exec ${bctl} -q set 5%- && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";
          XF86MonBrightnessUp   = "exec ${bctl} -q set +5% && ${light} -G | cut -d'.' -f1 > $SWAYSOCK.wob";

          # PulseAudio needs to be on the system, maybe check first.
          XF86AudioRaiseVolume = "exec ${pamixer} -ui 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
          XF86AudioLowerVolume = "exec ${pamixer} -ud 2 && ${pamixer} --get-volume > $SWAYSOCK.wob";
          XF86AudioMute = "exec ${pamixer} --toggle-mute && ( ${pamixer} --get-mute && echo 0 > $SWAYSOCK.wob ) || ${pamixer} --get-volume > $SWAYSOCK.wob";
          # If no pactl then fallback to alsa
          XF86AudioMicMute = "exec ${pactl} set-source-mute 1 toggle";
        };
      ## Might want to find a new menu
      #menu = "${pkgs.rofi}/bin/rofi";
      # modifier = "";
    };
  };
}
