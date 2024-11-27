{
  description = "KooL's NixOS-Hyprland"; 
  	
  inputs = {
  	nixpkgs.url = "nixpkgs/nixos-unstable";
	#wallust.url = "git+https://codeberg.org/explosion-mental/wallust?ref=dev";
	hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # hyprland development
	distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes"; 
	# URL for specifying nightly version of nvim
        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

	home-manager = {
	    url = "github:nix-community/home-manager";
	    inputs.nixpkgs.follows = "nixpkgs";
	  };

	rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  	};

  outputs = 
	inputs@{ self,nixpkgs, ... }:
    	let
      system = "x86_64-linux";
      host = "hyprland-desktop";
      username = "mathipe";

    pkgs = import nixpkgs {
       	inherit system;
       	config = {
       	  allowUnfree = true;
          allowUnfreePredicate = _: true;
       	};
      };
    in
      {
	nixosConfigurations = {
      "${host}" = nixpkgs.lib.nixosSystem rec {
		specialArgs = { 
			inherit system;
			inherit inputs;
			inherit username;
			inherit host;
			};
	   		modules = [ 
				./hosts/${host}/config.nix 
				inputs.distro-grub-themes.nixosModules.${system}.default
				];
			};
		};
	};
}
