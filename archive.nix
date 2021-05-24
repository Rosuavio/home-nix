{pkgs, ... }:
{
  home.packages = with pkgs; [
    # archive
    gnutar
    libarchive
    cpio
    
    # compression
    bzip2
    gzip
    lrzip
    lz4
    lzip
    lzop
    xz
    zstd
    
    # archive and compression
    p7zip
    unrar
    unzip
    zip

    # gui tools
    ark
  ];
}
