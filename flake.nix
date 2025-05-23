{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
	url = "github:nix-community/home-manager";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
	inherit system;
	config = {
	   allowUnfree = true;
	};
     };
    in
    {
    nixosConfigurations."muldakmens" = nixpkgs.lib.nixosSystem { # change to your hostname
      specialArgs = { inherit inputs system; };
      modules = [ 
		./configuration.nix 
		home-manager.nixosModules.home-manager
		{
		   home-manager.useGlobalPkgs = true;
            	   home-manager.useUserPackages = true;
		}
	];
    };
  };
}

