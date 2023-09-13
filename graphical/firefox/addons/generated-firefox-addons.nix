{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "bitwarden" = buildFirefoxXpiAddon {
      pname = "bitwarden";
      version = "2023.8.3";
      addonId = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4164440/bitwarden_password_manager-2023.8.3.xpi";
      sha256 = "d43d7603ed04a24cd37b209a22d58b940cd71503d654d6305d6c37317fd5889c";
      meta = with lib;
      {
        homepage = "https://bitwarden.com";
        description = "A secure and free password manager for all of your devices.";
        license = licenses.gpl3;
        platforms = platforms.all;
        };
      };
    "noscript" = buildFirefoxXpiAddon {
      pname = "noscript";
      version = "11.4.27";
      addonId = "{73a6fe31-595d-460b-a920-fcc0f8843232}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4164985/noscript-11.4.27.xpi";
      sha256 = "6b57d9afce663f801177b7492fe7f00967ee3e66b6351b2cf3ff2a6c3ca99637";
      meta = with lib;
      {
        homepage = "https://noscript.net";
        description = "The best security you can get in a web browser! Allow potentially malicious web content to run only from sites you trust. Protect yourself against XSS other web security exploits.";
        license = licenses.gpl2;
        platforms = platforms.all;
        };
      };
    "stylus" = buildFirefoxXpiAddon {
      pname = "stylus";
      version = "1.5.35";
      addonId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4160414/styl_us-1.5.35.xpi";
      sha256 = "d415ee11fa4a4313096a268e54fd80fa93143345be16f417eb1300a6ebe26ba1";
      meta = with lib;
      {
        homepage = "https://add0n.com/stylus.html";
        description = "Redesign your favorite websites with Stylus, an actively developed and community driven userstyles manager. Easily install custom themes from popular online repositories, or create, edit, and manage your own personalized CSS stylesheets.";
        license = licenses.gpl3;
        platforms = platforms.all;
        };
      };
    }