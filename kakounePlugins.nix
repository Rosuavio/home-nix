{ lib, fetchFromGitHub, kakouneUtils }:
{
  fzf-kak = kakouneUtils.buildKakounePluginFrom2Nix {
    pname = "fzf-kak";
    version = "2021-07-01";
    src = fetchFromGitHub {
      owner = "andreyorst";
      repo = "fzf.kak";
      rev = "124c3a27510d6ef707250a2f31cb66a923f54ca6";
      sha256 = "sha256:0rwmc5n20yyx37djaczsk684rrwpilkcy46waxxqlanlcnb61wsw";
    };
    meta.homepage = "https:/github.com/andreyost/fzf.kak/";
  };
}
