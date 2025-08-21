{
  overlay = import ./overlay.nix;
  makePackage = pkgs:
    let
      swt_4_33 = pkgs.callPackage ./packages/swt_4_33/package.nix;
    in
    pkgs.callPackage ./packages/stm32cubeide/package.nix { inherit swt_4_33; };
}
