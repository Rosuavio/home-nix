{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    configure = {
      customRC = pkgs.lib.strings.fileContents ./config.vim;

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          direnv-vim
          deoplete-nvim
          LanguageClient-neovim
          gitgutter
          gv-vim
          fugitive
          vim-airline
        ];
        opt = [ vim-nix ];
      };
    };

    viAlias = true;
    vimAlias = true;
    # vimdiffAlias = true;
  };
}
