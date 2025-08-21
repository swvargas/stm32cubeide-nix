{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05-small";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable-small";
  };

  outputs = inputs: 
  let
    inherit (inputs.nixpkgs-lib) lib;
    packageNames = [ "stm32cubeide" "swt_4_33" ];
    packageAliases = packageNames ++ [ "swt" ];
    # swt doesn't support aarch64
    supportedSystems = [ "x86_64-linux" "x86_64-darwin" ];
  in
  inputs.flake-utils.lib.eachSystem supportedSystems (system: 
  let
    pkgsOpts = {
      inherit system;
      overlays = [ inputs.self.overlays.default ];
      config.allowUnfreePredicate = pkg: (pkg.pname or "") == "stm32cubeide";
    };
    mkPackages = { stable }:
      let
        input = if stable then inputs.nixpkgs-stable else inputs.nixpkgs-unstable;
        pkgs = import input pkgsOpts;
      in
      {
        inherit (pkgs) stm32cubeide swt_4_33;
        swt = pkgs.swt_4_33;
      };
    legacyPackages = {
      stable = mkPackages { stable = true; };
      unstable = mkPackages { stable = false; };
    };
  in
  {
    inherit legacyPackages;
    packages = lib.pipe { a = [ "stable" "unstable" ]; b = packageAliases; } [
      (lib.mapCartesianProduct ({a, b}: lib.nameValuePair "${a}-${b}" legacyPackages.${a}.${b}))
      lib.listToAttrs
      (attrs: attrs // legacyPackages.stable // { default = legacyPackages.stable.stm32cubeide; })
    ];
  }) // inputs.flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import inputs.nixpkgs-stable { inherit system; };
  in
  {
    formatter = pkgs.nixfmt-tree;
  }) // {
    overlays = {
      default = import ./overlay.nix;
    };
  };
}
