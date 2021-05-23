{
  services.gpg-agent.enable = true;

  programs.gpg = {
    enable = true;
    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      fixed-list-mode = true;
      no-comments = true;
      no-emit-version = true;
      no-greeting = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-fingerprint = true;
      # Display key origins and updates
      #with-key-origin = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      throw-keyids = true;
      # Default/trusted key ID to use (helpful with throw-keyids)
      #default-key = "0xFF3E7D88647EBCDB";
      #trusted-key = "0xFF3E7D88647EBCDB";
      # Group recipient keys (preferred ID last)
      #group keygroup = "0xFF00000000000001 0xFF00000000000002 0xFF3E7D88647EBCDB";
      # Keyserver URL
      #keyserver hkps://keys.openpgp.org
      #keyserver hkps://keyserver.ubuntu.com:443
      #keyserver hkps://hkps.pool.sks-keyservers.net
      #keyserver hkps://pgp.ocf.berkeley.edu
      # Proxy to use for keyservers
      #keyserver-options = "http-proxy=socks5-hostname://127.0.0.1:9050";
      # Verbose output
      #verbose = true;
      # Show expired subkeys
      #list-options = "show-unusable-subkeys";
    };
  };
}
