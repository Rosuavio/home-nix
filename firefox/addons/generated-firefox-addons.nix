{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "bitwarden" = buildFirefoxXpiAddon {
      pname = "bitwarden";
      version = "1.54.0";
      addonId = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3859577/bitwarden_free_password_manager-1.54.0-an+fx.xpi";
      sha256 = "232b50247ea309b98c0c022fea9d8ca5ef227eb539bf27c58c2fd83d8270d9d7";
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
      version = "11.2.11";
      addonId = "{73a6fe31-595d-460b-a920-fcc0f8843232}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3816655/noscript_security_suite-11.2.11-an+fx.xpi";
      sha256 = "b833e81823986646dbc473ebbee987bd47757fbe79c9d1720150f08ba6ca9ba9";
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
      version = "1.5.21";
      addonId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3828033/stylus-1.5.21-fx.xpi";
      sha256 = "cb330a7d8748493a415ee0705839e519c7bb045d91c5068d15e1d02eb661634e";
      meta = with lib;
      {
        homepage = "https://add0n.com/stylus.html";
        description = "Redesign your favorite websites with Stylus, an actively developed and community driven userstyles manager. Easily install custom themes from popular online repositories, or create, edit, and manage your own personalized CSS stylesheets.";
        license = licenses.gpl3;
        platforms = platforms.all;
        };
      };
    }