set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set list

set hidden
set number

:packadd vim-nix

let g:LanguageClient_serverCommands = {
  \ 'nix': ['rnix-lsp']
\ }
