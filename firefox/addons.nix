{ buildFirefoxXpiAddon, lib }:
{
  "stylus" = buildFirefoxXpiAddon {
    pname = "stylus";
    version = "1.5.17";
    addonId = "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}";
    url = "https://addons.mozilla.org/firefox/downloads/file/3732726/stylus-1.5.17-fx.xpi";
    sha256 = "6d0d770c7ebf8938533eec7d55952d0845df3c47b1783a23b4f513e6cae58f09";
    meta = with lib;
    {
      homepage = "https://add0n.com/stylus.html";
      description = "Redesign your favorite websites with Stylus, an actively developed and community driven userstyles manager. Easily install custom themes from popular online repositories, or create, edit, and manage your own personalized CSS stylesheets.";
      license = licenses.gpl3;
      platforms = platforms.all;
    };
  };

  "bitwarden" = buildFirefoxXpiAddon {
    pname = "bitwarden";
    version = "1.49.0";
    addonId = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
    url = "https://addons.mozilla.org/firefox/downloads/file/3741860/bitwarden_free_password_manager-1.49.0-an+fx.xpi";
    sha256 = "e71db6bdf639450f3ade99c4a4653ecac596f2c44dacd0ee4b35cba1834082a3";
    meta = with lib;
    {
      homepage = "https://bitwarden.com";
      description = "A secure and free password manager for all of your devices.";
      license = licenses.gpl3;
      platforms = platforms.all;
    };
  };

  "ipfs-companion" = buildFirefoxXpiAddon {
    pname = "ipfs-companion";
    version = "2.18.0";
    addonId = "ipfs-firefox-addon@lidel.org";
    url = "https://addons.mozilla.org/firefox/downloads/file/3741905/ipfs_companion-2.18.0-an+fx.xpi";
    sha256 = "19ad13747049aeec8e9c86007b4a7a59fb43c0ee80e3ef759fb7673db61f15b8";
    meta = with lib;
    {
      homepage = "https://github.com/ipfs-shipyard/ipfs-companion";
      description = "Harness the power of IPFS in your browser";
      license = licenses.cc0;
      platforms = platforms.all;
    };
  };
}
