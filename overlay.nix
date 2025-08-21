_: newPkgs: {
  swt_4_33 = newPkgs.callPackage ./packages/swt_4_33/package.nix { };
  stm32cubeide = newPkgs.callPackage ./packages/stm32cubeide/package.nix { };
}
