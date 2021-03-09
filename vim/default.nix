{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    extraConfig = pkgs.lib.strings.fileContents ./config.vim;

    viAlias = true;
    vimAlias = true;
    # vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      { plugin = direnv-vim; }
      { plugin = deoplete-nvim; }
      { plugin = LanguageClient-neovim; }
      { plugin = gitgutter; }
      { plugin = gv-vim; }
      { plugin = fugitive; }
      { plugin = vim-airline; }

      { plugin = vim-nix; optional = true; }
    ];
  };
}
