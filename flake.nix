{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zig2nix.url = "github:Cloudef/zig2nix";
    zenbrowser.url = "github:0xc000022070/zen-browser-flake";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = { self, nixpkgs, chaotic, ... }@inputs: {
    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    nixosConfigurations."muldakmens" = nixpkgs.lib.nixosSystem { # change to your hostname
      specialArgs = { inherit inputs; };
      modules = [ 
		./configuration.nix 
		chaotic.nixosModules.nyx-cache
        	chaotic.nixosModules.nyx-overlay
        	chaotic.nixosModules.nyx-registry
	];
    };
  };
}
