let
  browser = "firefox.desktop";
in
{
  xdg = {
    enable = true;

    userDirs.enable = true;

    mime.enable = true;

    mimeApps = {
      enable = true;

      defaultApplications = {
        "x-scheme-handler/bitwarden" = [ "Bitwarden.desktop"     ];
        "text/html"                  = [ browser ];
        "x-scheme-handler/http"      = [ browser ];
        "x-scheme-handler/https"     = [ browser ];
        "x-scheme-handler/about"     = [ browser ];
        "x-scheme-handler/unknown"   = [ browser ];
      };
    };
  };
}
