# version/hashes from https://github.com/NixOS/nixpkgs/commit/a774bc36805e3701161f64a51c1917de76468ead
{
  lib,
  swt,
}:
swt.overrideAttrs (old: lib.recursiveUpdate old {
  version = "4.33";
  fullVersion = "4.33-202409030240";

  passthru = {
    srcMetadataByPlatform = {
      x86_64-linux = {
        hash = "sha256-0OUr+jpwTx5/eoA6Uo2E9/SBAtf+IMMiSVRhOfaWFhE=";
      };
      x86_64-darwin = {
        hash = "sha256-n948C/YPF55WPYvub3re/wARLP1Wk+XhJiIuI0YQH5c=";
      };
    };
  };

  # it complains I'm overriding version attr with overriding the src, but it just can't tell I'm indirectly overriding src
  __intentionallyOverridingVersion = true;
})
