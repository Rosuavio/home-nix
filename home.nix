{ config, lib, pkgs, ... }:
let
  editor = "kak";
  username = "rosario";

  new-terminal = pkgs.writeShellScriptBin "new-terminal" "$TERM $@ &>/dev/null &";
# $TERM sh -c "$EDITOR $@" &>/dev/null &
  new-shell = pkgs.writeShellScriptBin "new-shell" "$TERM sh -c $@";
in
{
  imports = [
    ./vim
    ./gpg.nix
    ./kakoune.nix
    ./archive.nix
    ./yubikey.nix
    ./git.nix
    ./graphical
    ./music.nix
  ];

  programs.home-manager.enable = true;

  home = {
    enableNixpkgsReleaseCheck = true;
    username = username;
    homeDirectory = "/home/" + username;
    stateVersion = "23.11";

    sessionVariables = {
      EDITOR = editor;
      VISUAL = editor;
    };

    language = {
      base = "en_US.UTF-8";
      ctype = "en_US.UTF-8";
    };
  };

  systemd.user.startServices = "sd-switch";

  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
    };

    mime.enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "kakoune.desktop" ];
      };
    };
  };

  home.packages = with pkgs; [
    nix
    niv
    npins

    mosh

    killall
    xdg-utils

    hack-font

    hunspell
    hunspellDicts.en-us

    htop
    radeontop

    haskellPackages.hasktags
    universal-ctags
    tmux
    ripgrep
    jq

    rustc
    cargo
    wget

    (aspellWithDicts (ps : [ ps.en ]))

    new-terminal
    new-shell

    tree
    ripgrep

    dbeaver
    socat
    file
  ];

  xdg.configFile."wireplumber/bluetooth.lua.d/50-bluze-config.lua" = {
    text = ''
    bluez_monitor.properties = {
      -- Enables bluetooth headset media controls
      ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",
    }
    '';
  };

  services = {
    keybase.enable = true;
  };

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        _urlencode() {
          local length="''${#1}"
          for (( i = 0; i < length; i++ )); do
          local c="''${1:$i:1}"
          case $c in
          %) printf '%%%02X' "'$c" ;;
          *) printf "%s" "$c" ;;
          esac
          done
        }

        osc7_cwd() {
          printf '\e]7;file://%s%s\e\\' "$HOSTNAME" "$(_urlencode "$PWD")"
        }

        PROMPT_COMMAND=osc7_cwd

        if [[ -n "$IN_NIX_SHELL" ]]; then
          export PS1="\n\[\033[1;32m\][$IN_NIX_SHELL-shell:\w]\$\[\033[0m\] "
        fi
      '';
    };
    bat.enable = true;
    ssh = {
      enable = true;
      package = pkgs.openssh;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };

    broot = {
      enable = true;
      enableBashIntegration = true;
      settings.modal = true;
    };

    nnn = {
      enable = true;
      bookmarks = {
        h = "~";
        d = "~/Documents";
        D = "~/Downloads";
      };
      extraPackages = [
        pkgs.ffmpegthumbnailer
        pkgs.mediainfo
        pkgs.sxiv
      ];
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    # TODO: Cant use rbw becuase I use 2FA and it does not seem to support it
    # both rbw and bitw are lightwieght bitwarden clients with services/demons
    # rbw seems like it might be a more active project and it has more attention (already packaged in nixpkgs)
    # bitw provides a D-Bus service org.freedesktop.secrets which I really want!
    # I need to see if I can make the two projects aware of eachother and spur them together.
    rbw = {
      enable = true;
      settings = {
        email = "RosarioPulella@gmail.com";
      };
    };
  };
}
