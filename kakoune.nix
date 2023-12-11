{ pkgs, lib, ... }:
let
  custom-kak-pluigins = pkgs.callPackage ./kakounePlugins.nix { inherit lib; fetchFromGitHub = pkgs.fetchFromGitHub; kakouneUtils = pkgs.kakouneUtils; };

  edtiorInNewTerm = pkgs.writeShellScriptBin "edtiorInNewTerm" ''
    $TERM sh -c "$EDITOR $@" &>/dev/null &
  '';

  kakouneDesktop = pkgs.writeTextDir "share/applications/kakoune.desktop"
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
          "text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;text/x-haskell;text/markdown;text/x-python;application/x-yaml;application/json;text/rust;text/vnd.trolltech.linguist;application/javascript";
        Catagories = "Development;TextEditor;";
        StartupWMClass = "Kakoune";
      };
    });

  nix-lsp = pkgs.nil;

  tomlFormat = pkgs.formats.toml { };
  kak-lsp-config = tomlFormat.generate "kak-lsp-config.toml" {
    snippet_support = false;
    verbosity = 2;
    server = {
      # In seconds
      timeout = 30 * 60 * 60;
    };
    language = {
      nix = {
        filetypes = [ "nix" ];
        roots = [ "flake.nix" "shell.nix" ".git" ];
        command = lib.getExe nix-lsp;
      };
      rust = rec {
        filetypes = [ "rust" ];
        roots = [ "Cargo.toml" ];
        command = "rust-analyzer";
        settings_section = "rust-analyzer";
        settings.${settings_section}.hoverActions.enable = false;
      };
      typescript = {
        filetypes = [ "typescript" ];
        roots = [ "package.json" "tsconfig.json" ];
        command = "typescript-language-server";
        args = [ "--stdio" ];
      };
      json = {
        filetypes = [ "json" ];
        roots = [ "packages.json" ];
        command = "vscode-json-languageserver";
        args = [ "--stdio" ];
      };
      toml = {
        filetypes = [ "toml" ];
        roots = [ "Cargo.toml;" ];
        command = "taplo-lsp";
        args = [ "run" ];
      };
    };
  };
in
{
  programs.kakoune = {
    enable = true;

    config = {
      autoComplete = [ "insert" "prompt" ];
      autoInfo = [ "command" "onkey" ];
      autoReload = "ask";
      # Indent of 2 is a haskell thing, need to set this only for haskell code.
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
        {
          name = "ModuleLoaded";
          option = "fzf-grep";
          commands = ''
            set global fzf_grep_command 'rg'
          '';
        }
        {
          name = "ModuleLoaded";
          option = "fzf-file";
          commands = ''
            set global fzf_file_command 'rg'
            set global fzf_highlight_command 'bat'
          '';
        }
        {
          name = "WinSetOption";
          # Maybe can split out the list of filetypes to use lsp for to a nix list.
          option = "filetype=(nix|typescript|toml|json)";
          commands = "lsp-enable-window";
        }
        {
          # Might be able to use nix to remove the repatition
          name = "WinSetOption";
          option = "filetype=rust";
          commands = ''
            set-option window indentwidth 4
            # Enable LSP
            lsp-enable-window

            # Auto-formatting on save
            # TODO: Expand home-manager to allow hooks inside commands of hooks to be defined in nix.
            # hook window BufWritePre .* lsp-formatting-sync

            # Configure inlay hints (only on save)
            hook window -group rust-inlay-hints BufWritePost .* rust-analyzer-inlay-hints
            hook -once -always window WinSetOption filetype=.* %{
              remove-hooks window rust-inlay-hints
            }
          '';
        }
      ];
    };

    extraConfig = ''
      # set -add global autoinfo normal

      # Only want this to be the ctagscmd when working with haskell files.
      set global ctagscmd '${pkgs.haskellPackages.hasktags}/bin/hasktags -cR'

      eval %sh{${pkgs.kakounePlugins.kak-lsp}/bin/kak-lsp --kakoune -s $kak_session --config ${kak-lsp-config}}
    '';

    # Adding something to this list only combines the derivations with kak using symlink join.
    plugins = [
      # kak-lsp config goes into .config/kak-lsp/kak-lsp.toml
      # Or config dir can be reconfigured with kak-lsp --configure <PATH>
      # It seems like there is some default config already. Maybe not actually.
      # pkgs.kakounePlugins.kak-lsp
      custom-kak-pluigins.fzf-kak
    ];

  };
  home.packages = [
    (pkgs.hiPrio kakouneDesktop)
    nix-lsp
    pkgs.rustfmt
    pkgs.rust-analyzer
    pkgs.nodePackages.vscode-json-languageserver
    pkgs.nodePackages.typescript-language-server
    pkgs.taplo-lsp
  ];
}
