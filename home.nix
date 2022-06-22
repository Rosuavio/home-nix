{ config, lib, pkgs, ... }:
let
  editor = "kak";
  username = "rosario";

  sources = import ./nix/sources.nix;

  obelisk = import sources.obelisk {};

  nix-thunk = import sources.nix-thunk {};

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
    jq

    rustc
    cargo
    wget

    (aspellWithDicts (ps : [ ps.en ]))

    new-terminal
    new-shell
    pulsemixer
    nix-thunk.command
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

        if [[ -n "$IN_NIX_SHELL" ]]; then
          export PS1="\n\[\033[1;32m\][$IN_NIX_SHELL-shell:\w]\$\[\033[0m\] "
        fi

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
