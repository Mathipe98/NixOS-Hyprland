{ pkgs, username, lib, ... }:

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
	zsh

    rg
	oh-my-posh
	gh
	slack
	protonvpn-gui
    #python3Full
	vscode
	pnpm
	nodejs
	xclip
    (python311.withPackages (ps: with ps; [ pip ]))
    (poetry.override { python3 = python311; })
	fzf
	fd
	bat
	eza
	vivaldi
    whatsapp-for-linux
      ];
    };
    
    defaultUserShell = pkgs.zsh;
  }; 
  
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ fzf ]; 

  programs = {
    # Zsh configuration
    # NB: This probably doesn't matter since I copy my own .zshrc
    zsh = {
      enable = true;
      enableCompletion = true;
      
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      };
   };
}
