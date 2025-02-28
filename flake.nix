{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zig2nix.url = "github:Cloudef/zig2nix";
    zenbrowser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    nixosConfigurations."muldakmens" = nixpkgs.lib.nixosSystem { # change to your hostname
      # optional, let's you use inputs in your config.
      specialArgs = { inherit inputs; };
      modules = [ ./configuration.nix ];
    };
  };
}
