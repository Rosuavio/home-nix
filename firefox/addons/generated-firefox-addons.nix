{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "bitwarden" = buildFirefoxXpiAddon {
      pname = "bitwarden";
      version = "1.50.0";
      addonId = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3775487/bitwarden_free_password_manager-1.50.0-an+fx.xpi";
      sha256 = "0361ae35139c613c4b27fa80f094db250f4510f36eb5eafefdadc6f89b2050f9";
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
      version = "2.19.0";
      addonId = "ipfs-firefox-addon@lidel.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/3773956/ipfs_companion-2.19.0-an+fx.xpi";
      sha256 = "84652c6bf37889d4d6511b48860b76835fa7ea8fff03b7a23a013f882675337e";
      meta = with lib;
      {
        homepage = "https://github.com/ipfs-shipyard/ipfs-companion";
        description = "Harness the power of IPFS in your browser";
        license = licenses.cc0;
        platforms = platforms.all;
        };
      };
    "noscript" = buildFirefoxXpiAddon {
      pname = "noscript";
      version = "11.2.8";
      addonId = "{73a6fe31-595d-460b-a920-fcc0f8843232}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3778947/noscript_security_suite-11.2.8-an+fx.xpi";
      sha256 = "4744f9d99acbe9dec3557765edd9173272b4681c8425228fb6af52493f853467";
      meta = with lib;
      {
        homepage = "https://noscript.net";
        description = "The best security you can get in a web browser! Allow potentially malicious web content to run only from sites you trust. Protect yourself against XSS other web security exploits.";
        license = licenses.gpl2;
        platforms = platforms.all;
        };
      };
    "plasma-integration" = buildFirefoxXpiAddon {
      pname = "plasma-integration";
      version = "1.8.0.1";
      addonId = "plasma-browser-integration@kde.org";
      url = "https://addons.mozilla.org/firefox/downloads/file/3715245/plasma_integration-1.8.0.1-fx.xpi";
      sha256 = "226f0931a139346d78d0d8ae950688a731cb07a3e430b3b3f779585ae33714e7";
      meta = with lib;
      {
        homepage = "http://kde.org";
        description = "Multitask efficiently by controlling browser functions from the Plasma desktop.";
        license = licenses.gpl3;
        platforms = platforms.all;
        };
      };
    "react-devtools" = buildFirefoxXpiAddon {
      pname = "react-devtools";
      version = "4.13.5";
      addonId = "@react-devtools";
      url = "https://addons.mozilla.org/firefox/downloads/file/3781975/react_developer_tools-4.13.5-fx.xpi";
      sha256 = "d397fc7b3e2b7ac57d2fabf380408731c694dd52afa871e7808dfbb3531b623a";
      meta = with lib;
      {
        homepage = "https://github.com/facebook/react";
        description = "React Developer Tools is a tool that allows you to inspect a React tree, including the component hierarchy, props, state, and more. To get started, just open the Firefox devtools and switch to the \"⚛️ Components\" or \"⚛️ Profiler\" tab.";
        license = licenses.mit;
        platforms = platforms.all;
        };
      };
    "redux-devtools" = buildFirefoxXpiAddon {
      pname = "redux-devtools";
      version = "2.17.1";
      addonId = "extension@redux.devtools";
      url = "https://addons.mozilla.org/firefox/downloads/file/1509811/redux_devtools-2.17.1-fx.xpi";
      sha256 = "649d780d19201b2607347c4f57b5b57b237624b2c0ed322af9575cf791cce326";
      meta = with lib;
      {
        homepage = "https://github.com/zalmoxisus/redux-devtools-extension";
        description = "DevTools for Redux with actions history, undo and replay.";
        license = licenses.mit;
        platforms = platforms.all;
        };
      };
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
    }