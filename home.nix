{ config, lib, pkgs, ... }:
let
  editor = "kak";
  username = "rosario";

  sources = import ./nix/sources.nix;

  obelisk = import sources.obelisk {};

  edtiorInNewTerm = pkgs.writeShellScriptBin "edtiorInNewTerm" ''
    $TERM sh -c "$EDITOR $@" &>/dev/null &
  '';

  kakouneDesktop =
    pkgs.writeTextDir "share/applications/kakoune.desktop"
      (lib.generators.toINI { } {
        "Desktop Entry" = {
          Name = "Kakoune";
          Type = "Application";
          TryExec = "kak";
          # TODO make this more generic. Use whatever $TERM is.
          Exec = "${edtiorInNewTerm}/bin/edtiorInNewTerm %U";
          # Exec = "${pkgs.bash}/bin/sh -c '$TERM kak'";
          Terminal = true;
          Icon = "kakoune";
          Comment = "Edit text";
          GenericName = "Text Editor";
          StartupNotify= true;
          MimeType =
            "text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;text/x-haskell;text/markdown;text/x-python;application/x-yaml";
          Catagories = "Development;TextEditor;";
          StartupWMClass = "Kakoune";
        };
      });
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
  ];

  home = {
    username = username;
    homeDirectory = "/home/" + username;
    stateVersion = "21.11";

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

    killall
    xdg-utils

    obelisk.command

    hack-font

    hunspell
    hunspellDicts.en-us

    htop
    radeontop

    haskellPackages.hasktags
    universal-ctags
    tmux
    ripgrep
    (hiPrio kakouneDesktop)
    jq
  ];

  services.keybase.enable = true;

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

        unset SSH_AGENT_PID
        if [ "''${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
          export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
        fi
      '';
    };
    bat.enable = true;
    ssh.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
    };

    broot = {
      enable = true;
      enableBashIntegration = true;
      modal = true;
    };

    nnn = {
      enable = true;
      extraPackages = [
        pkgs.ffmpegthumbnailer
        pkgs.mediainfo
        pkgs.sxiv
      ];
    };

    ncspot = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  pam.sessionVariables = {
    SSH_AGENT_PID = "";
    SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh";
  };
}
