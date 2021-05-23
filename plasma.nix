{pkgs, ... }:
{
  home.packages = with pkgs; [
      ark
      dolphin
      konsole
  ];
}
