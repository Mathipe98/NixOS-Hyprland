{ pkgs, username, ... }:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users = { 
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video" 
        "input" 
        "audio"
      ];

    # define user packages here
    packages = with pkgs; [
	bash
	oh-my-posh
	gh
	teams
	slack
	protonvpn-gui
	python3Full
	vscode
	pnpm
	nodejs
	xclip
	(python311.withPackages (ps: with ps; [ pip ]))
	fzf
	fd
	bat
	eza
	(nerdfonts.override {
	  fonts = [
	    "0xProto",
	    "Hack",
	    "FiraCode",
    	    "FiraMono",
 	    "CascadiaCode",
            "Cousine",
	    "DroidSansMono",
	    "JetBrainsMono",
	    "SourceCodePro"
	  ];
	})
      ];
    };
    
    defaultUserShell = pkgs.bash;
    file."nvim" = {
      source = "";
      target = "";
      recursive = true;
    }
  }; 
  
  environment.shells = with pkgs; [ bash ];
  environment.systemPackages = with pkgs; [ fzf ]; 
}
