{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    extraConfig = pkgs.lib.strings.fileContents ./config.vim;

    viAlias = true;
    vimAlias = true;
    # vimdiffAlias = true;
  };
}
