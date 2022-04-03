{ pkgs, lib, ... }:
let
  custom-kak-pluigins = pkgs.callPackage ./kakounePlugins.nix { inherit lib; fetchFromGitHub = pkgs.fetchFromGitHub; kakouneUtils = pkgs.kakouneUtils; };
in
{
  programs.kakoune = {
    enable = true;

    config = {
      autoComplete = [ "insert" "prompt" ];
      autoInfo = [ "command" "onkey" ];
      autoReload = "ask";
      indentWidth = 2;
      showWhitespace = {
        enable = true;
        space = " ";
      };
      numberLines = {
        enable = true;
        highlightCursor = true;
        relative = false;
      };

      ui = {
        enableMouse = false;
        setTitle = true;
        assistant = "clippy";
        statusLine = "bottom";
        useBuiltinKeyParser = true;
      };

      keyMappings = [
        {
          key = "<c-p>";
          mode = "normal";
          effect = ": fzf-mode<ret>";
        }
      ];

      hooks = [
        { name = "ModuleLoaded";
          option = "wayland";
          commands = "set-option global termcmd 'foot /bin/sh -c'";
        }
      ];
    };

    extraConfig = ''
      set -add global autoinfo normal
      set global ctagscmd '${pkgs.haskellPackages.hasktags}/bin/hasktags -cR'
    '';

    plugins = [
      pkgs.kakounePlugins.kak-lsp
      custom-kak-pluigins.fzf-kak
    ];

  };
  home.packages = [
    pkgs.rnix-lsp
    pkgs.haskell-language-server
  ];
}
