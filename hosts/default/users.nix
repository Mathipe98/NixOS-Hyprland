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
	zsh

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
    #oh-my-posh = {
    #  enable = true;
    #  useTheme = "jandedobbeleer";
    #};
    zsh = {
      enable = true;
      enableCompletion = true;
      
      #ohMyZsh = {
      #  enable = true;
      #  plugins = ["git"];
      #  theme = "jandedobbeleer"; #"xiong-chiamiov-plus"; 
      #};
      
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      
      };
   };
}
