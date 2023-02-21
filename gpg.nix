{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };

  programs.gpg.enable = true;
}
