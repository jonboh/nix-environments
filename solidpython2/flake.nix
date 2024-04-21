{
  description = "solidpython2 flake";
  # Specifies the Nix flake inputs, such as Nixpkgs.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  # Defines the outputs provided by this flake.
  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.x86_64-linux.python310Packages.solidpython2 = import ./solidpython2.nix {inherit pkgs;};
    devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        (pkgs.python310.withPackages
          (ps:
            with ps; [
              ruff-lsp
              autopep8
              debugpy
              setuptools
              self.packages.x86_64-linux.python310Packages.solidpython2
            ]))
      ];
    };
  };
}
