# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options

{ pkgs, inputs, ... }:
let

  python-packages = pkgs.python312.withPackages (
    ps: with ps; [
      requests
      pyquery # needed for hyprland-dots Weather script
      pyodbc
      numpy
      pandas
      opencv-python
      python-dotenv
      fastapi
      uvicorn
      threadpoolctl
      joblib
      scikit-learn
      scipy
      sounddevice
    ]
  );

in
{

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  environment.systemPackages =
    (with pkgs; [
      # System Packages
      bc
      baobab
      btrfs-progs
      clang
      curl
      cpufrequtils
      duf
      ffmpeg
      glib # for gsettings to work
      gsettings-qt
      git
      killall
      libappindicator
      libnotify
      openssl # required by Rainbow borders
      pciutils
      vim
      wget
      xdg-user-dirs
      xdg-utils
      gnumake
      go
      inputs.fix-python.packages.${pkgs.system}.default
      #fix-python
      xorg.libSM
      xorg.libXext
      opencv
      libuuid
      mysql84
      llm-ls
      stylua
      lua-language-server
      nil
      nixfmt-rfc-style
      wireshark
      unixODBC
      unixODBCDrivers.psql
      #unixODBCDrivers.mysql
      unixODBCDrivers.sqlite
      unixODBCDrivers.msodbcsql18
      portaudio
      devenv
      signal-desktop

      # Dotnet
      csharpier
      (
        with dotnetCorePackages;
        combinePackages [
          dotnet_8.sdk
          dotnet_8.runtime
          dotnet_8.aspnetcore
          dotnet_9.sdk
          dotnet_9.runtime
          dotnet_9.aspnetcore
        ]
      )
      csharp-ls
      netcoredbg

      fastfetch
      (mpv.override { scripts = [ mpvScripts.mpris ]; }) # with tray
      (azure-cli.withExtensions [
        azure-cli.extensions.aks-preview
        azure-cli.extensions.webapp
        azure-cli.extensions.redisenterprise
      ])
      #ranger

      # Hyprland Stuff
      #(ags.overrideAttrs (oldAttrs: { inherit (oldAttrs) pname; version = "1.8.2"; }))
      ags # desktop overview
      btop
      brightnessctl # for brightness control
      cava
      cavalier
      cliphist
      loupe
      gnome-system-monitor
      grim
      gtk-engine-murrine # for gtk themes
      hypridle
      imagemagick
      inxi
      jq
      kitty
      libsForQt5.qtstyleplugin-kvantum # kvantum
      networkmanagerapplet
      nwg-displays
      nwg-look
      nvtopPackages.full
      pamixer
      pavucontrol
      playerctl
      polkit_gnome
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum # kvantum
      rofi-wayland
      slurp
      swappy
      swaynotificationcenter
      swww
      unzip
      wallust
      wl-clipboard
      wlogout
      xarchiver
      yad
      yt-dlp

      #waybar  # if wanted experimental next line
      #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    ])
    ++ [
      python-packages
    ];

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    victor-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) # stable banch
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; }) # stable banch

    #nerd-fonts.jetbrains-mono # unstable
    #nerd-fonts.fira-code # unstable
    #nerd-fonts.fantasque-sans-mono #unstable
  ];

  programs = {
    hyprland = {
      enable = true;
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
      #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; #xdph-git

      portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
      xwayland.enable = true;
    };

    waybar.enable = true;
    wireshark = {
      enable = true;
      #usbmon.enable = true;
    };
    hyprlock.enable = true;
    firefox.enable = true;
    git.enable = true;
    nm-applet.indicator = true;
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];

    virt-manager.enable = false;

    #steam = {
    #  enable = true;
    #  gamescopeSession.enable = true;
    #  remotePlay.openFirewall = true;
    #  dedicatedServer.openFirewall = true;
    #};

    xwayland.enable = true;

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

  };

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

}
