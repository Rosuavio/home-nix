{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "bitwarden" = buildFirefoxXpiAddon {
      pname = "bitwarden";
      version = "2024.2.0";
      addonId = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4233394/bitwarden_password_manager-2024.2.0.xpi";
      sha256 = "2c59e7040749dee010b34fb2a9c24b28ada71ad7fa5a23264ff70e63f8f686d1";
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
      version = "11.4.29";
      addonId = "{73a6fe31-595d-460b-a920-fcc0f8843232}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4206186/noscript-11.4.29.xpi";
      sha256 = "05b98840b05ef2acbac333543e4b7c3d40fee2ce5fb4e29260b05e2ff6fe24cd";
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
      version = "1.5.46";
      addonId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4232144/styl_us-1.5.46.xpi";
      sha256 = "9a75bf1bdde7263a5502d78009b5f19117ea09e6237afc852e7ba4e52b565364";
      meta = with lib;
      {
        homepage = "https://add0n.com/stylus.html";
        description = "Redesign your favorite websites with Stylus, an actively developed and community driven userstyles manager. Easily install custom themes from popular online repositories, or create, edit, and manage your own personalized CSS stylesheets.";
        license = licenses.gpl3;
        platforms = platforms.all;
      };
    };
  }