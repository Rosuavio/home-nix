pkgs:
with pkgs; [
  nix
  gitAndTools.gh

  watchman
  inotify-tools

  kdeApplications.filelight
  kdeApplications.gwenview
  kdeApplications.kate
  kdeApplications.ark
  kdeApplications.dragon
  kdeApplications.okular
  kdeApplications.spectacle

  hunspell
  hunspellDicts.en-us
  vscodium
  teams

  yubikey-manager
  yubikey-manager-qt
  yubikey-personalization
  yubikey-personalization-gui

  rnix-lsp

  # needed so that coc can work https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim#requirements
  nodejs

  unzip

  spotify
  bitwarden
  krita
  inkscape
  libreoffice
  exercism
  haskellPackages.cabal-install
  haskellPackages.ghc

  skype
  discord
  signal-desktop
  gitter
]
