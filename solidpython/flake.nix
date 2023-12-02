{
  description = "solidpython2 flake";
  # Specifies the Nix flake inputs, such as Nixpkgs.
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  # Defines the outputs provided by this flake.
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.x86_64-linux.default = import ./solidpython.nix { inherit pkgs; };
    };
}
