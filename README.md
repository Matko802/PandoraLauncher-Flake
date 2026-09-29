# PandoraLauncher-Flake

Pandora modern Minecraft launcher packaged from the official upstream AppImage.

- Upstream: https://github.com/Moulberry/PandoraLauncher
- AppImage: `PandoraLauncher-Linux-x86_64.AppImage`
- Binary: `pandora-launcher`
- Platform: `x86_64-linux`

## Try it

```bash
nix run github:Matko802/PandoraLauncher-Flake
```

## Use in your NixOS flake

```nix
pandora = {
  url = "github:Matko802/PandoraLauncher-Flake";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

```nix
nixpkgs.overlays = [ inputs.pandora.overlays.default ];
```

```nix
users.users.you.packages = with pkgs; [
  pandora-launcher
];
```

## Update to a newer AppImage

```bash
./update.sh
```

The script queries the latest GitHub release, prefetches the new AppImage hash, rewrites `version` and `hash` in `package.nix`, so the next rebuild picks up the new version.
