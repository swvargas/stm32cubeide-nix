# STM32CubeIDE packaged for nix

This is a project to package [STM32CubeIDE](https://www.st.com/en/development-tools/stm32cubeide.html) for nix.

You'll notice a pinned version of `swt`. CubeIDE is built against that specific version, and because we aren't building CubeIDE (just extracting it) we can't compile against a different version.

### Usage (classic, no flakes)

```nix
pkgs = import <nixpkgs> {
  # ...
  overlays = [
    (import <stm32cubeide>).overlay
  ];
};
```

### Usage (flakes)

Run directly: (warning: license check is automatically accepted)

`nix run git+https://git.sr.ht/~shelvacu/stm32cubeide-nix`

Include overlay in `flake.nix`:

```nix
{
  inputs.stm32cubeide.url = "git+https://git.sr.ht/~shelvacu/stm32cubeide-nix";

  outputs = { ... }@inputs:
  let
    # wherever you initialize nixpkgs
    pkgs = import inputs.nixpkgs {
      overlays = [ inputs.stm32cubeide.overlays.default ];
    };
  in
  {
    # ...
  };
}
```

### Legal

For this to be useful, you must obtain a license for STM32CubeIDE from ST. This project is not endorsed or affiliated with ST. This may not be a complete list.

The build scripts, documentation, and other code in this repo is under CC0:

[Nix packaging of STM32CubeIDE](https://git.sr.ht/~shelvacu/stm32cubeide-nix) by Shelvacu is marked [CC0 1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/)<img src="https://mirrors.creativecommons.org/presskit/icons/cc.svg" alt="" style="max-width: 1em;max-height:1em;margin-left: .2em;"><img src="https://mirrors.creativecommons.org/presskit/icons/zero.svg" alt="" style="max-width: 1em;max-height:1em;margin-left: .2em;">
