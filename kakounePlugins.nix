{ lib, fetchFromGitHub, kakouneUtils }:
{
  fzf-kak = kakouneUtils.buildKakounePluginFrom2Nix {
    pname = "fzf-kak";
    version = "2021-07-01";
    src = fetchFromGitHub {
      owner = "andreyorst";
      repo = "fzf.kak";
      rev = "6910bfb4c23cac59c17f5b7850f7bd49aba3e5cb";
      sha256 = "sha256-KI4oWOw2VkYM22t/XwLPib2eHOlU9hd5JbH01IimisI=";
    };
    meta.homepage = "https:/github.com/andreyost/fzf.kak/";
  };
}
