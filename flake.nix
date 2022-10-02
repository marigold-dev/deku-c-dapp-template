{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs";
    deku.url = "github:marigold-dev/deku";
    tuna.url = "github:marigold-dev/tuna";
  };
  outputs = { self, flake-utils, nixpkgs, deku, tuna }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = with pkgs; mkShell {
          packages = [
            ligo
            deku.packages.${system}.default
            tuna.packages.${system}.tuna
            nodePackages.npm
          ];
        };
      });
}
