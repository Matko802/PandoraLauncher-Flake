{
  description = "Pandora Minecraft launcher from the official AppImage";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs =
    { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: rec {
        pandora-launcher = pkgs.callPackage ./package.nix { };
        default = pandora-launcher;
      });
      overlays.default = final: _prev: {
        pandora-launcher = final.callPackage ./package.nix { };
      };
    };
}
