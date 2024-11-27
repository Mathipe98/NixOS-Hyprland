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
	oh-my-posh
	gh
	teams
	slack
	protonvpn-gui
	python3Full
	vscode
      ];
    };
    
    defaultUserShell = pkgs.bash;
  }; 
  
  environment.shells = with pkgs; [ bash ];
  environment.systemPackages = with pkgs; [ fzf ]; 
}
