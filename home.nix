{ config, pkgs, lib, ... }:

rec {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vaelio";
  home.homeDirectory = "/home/vaelio";

  imports = [
  ./tempdir-daemon.nix
  ./hyprland_config.nix
  ./hypridle_config.nix
  ];
  #imports = [
  #  ./tempdir-daemon.nix
  #] ++ lib.optional (home.username == "vaelio") ./secrets-work.nix;
  #
  #imports = [
  #  ./tempdir-daemon.nix
  #] ++ lib.optional (lib.readFile("/etc/hostname") == "nixos-work\n") ./secrets-work.nix;


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.xwayland.enable = true;
  wayland.windowManager.hyprland.plugins = [
    pkgs.hyprlandPlugins.hyprsplit
  ];
  services.hypridle.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [

    # GUI
    #pkgs.hyprland
    pkgs.waybar
    pkgs.xwayland
    pkgs.wayland
    pkgs.hypridle
    pkgs.pyprland
    pkgs.xdg-desktop-portal-hyprland
    pkgs.hyprpaper
    pkgs.hyprlock
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
    pkgs.librewolf

    pkgs.wofi
    pkgs.rofi
    pkgs.pavucontrol
    pkgs.neovide
    pkgs.wl-clipboard
    #pkgs.wl-clipboard-rs # until clipcat is fixed
    pkgs.cliphist
    pkgs.dconf
    pkgs.wlsunset
    pkgs.brightnessctl
    pkgs.hyprpolkitagent

    # TERM
    pkgs.bat
    pkgs.alacritty
    pkgs.wezterm
    pkgs.lsd
    pkgs.kitty
    pkgs.procs
    pkgs.simple-http-server
    pkgs.tokei
    pkgs.navi
    pkgs.yazi
    pkgs.rio
    pkgs.bottom
    pkgs.wthrr

    # Screenshot
    pkgs.grim
    pkgs.qt5.full
    pkgs.qt5.qttools
    pkgs.qt5.qtsvg
    pkgs.flameshot
    pkgs.satty
    pkgs.slurp

    # Tools
    pkgs.galculator
    pkgs.spacedrive
    pkgs.chromium
    pkgs.vscodium
    pkgs.cloudflared
    pkgs.moonlight-qt
    pkgs.quickemu
    pkgs.virt-manager
    pkgs.remmina
    pkgs.netscanner
    pkgs.mpv
    pkgs.nmap
    pkgs.exegol
    pkgs.openvpn
    pkgs.seclists
    pkgs.feroxbuster
    pkgs.zellij
    pkgs.tpnote
    pkgs.tealdeer
    pkgs.fzf
    pkgs.pcmanfm
    pkgs.nix-search-cli
    #(pkgs.burpsuite.override { proEdition = true; })

    # fonts
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    pkgs.nerdfonts
    pkgs.roboto
    pkgs.font-awesome

    # rust
    pkgs.cargo
    pkgs.cargo-update

    # keyboard stuff
    pkgs.vial

    # nix stuff
    pkgs.manix

    # python
    pkgs.python3
    pkgs.python312Packages.ipython

  ];

  services.tempdir-daemon.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';


    # hyprland
    ".config/hypr/pyprland.toml".source = dotfiles/pyprland.toml;
    ".config/hypr/wofi-power-menu.sh".source = dotfiles/wofi-power-menu.sh;
    ".config/hypr/hyprlock.conf".source = dotfiles/hyprlock.conf;
    #".config/hypr/hyprpaper.conf".source = dotfiles/hyprpaper.conf;
    ".config/hypr/manix.sh".source = dotfiles/manix.sh;
    #".config/hypr/hyprland.conf".source = dotfiles/hyprland.conf;
    #".config/hypr/hypridle.conf".source = dotfiles/hypridle.conf;
    #".config/clipcat/clipcatd.toml".source = dotfiles/clipcatd.toml;
    #".config/clipcat/clipcat-menu.toml".source = dotfiles/clipcat-menu.toml;
    #".wallpapers/wallpaper.png".source = dotfiles/wallpaper.png;

    # waybar
    ".config/waybar/config".source = dotfiles/waybar_config;
    ".config/waybar/resolv.sh".source = dotfiles/resolv.sh;
    ".config/waybar/style.css".source = dotfiles/waybar_style.css;

    # cliphist
    #".local/bin/clipfzf".source = dotfiles/clipfzf;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/vaelio/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "nvim";
    PATH="$HOME/.cargo/bin/:$HOME/.local/bin/:$PATH";
    NIXOS_OZONE_WL = "1";
    #XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS";
  };

  # setup aliases
  home.shellAliases = {
    vim="nvim";
    ls="lsd";
    tpd="tempdir-daemon";
    dhcp="sudo udhcpc -qi ";
    feroxbuster="feroxbuster -w \\`fzf --walker-root=$HOME/.nix-profile/share/wordlists/seclists/\\`";
    #clipfzf="cliphist list | fzf | cliphist decode | wl-copy";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable bash and starship prompt
  programs.bash.enable = true;
  programs.starship.enable = true;
  programs.bash.profileExtra = ''
    if uwsm check may-start && uwsm select; then
        exec systemd-cat -t uwsm_start uwsm start default
    fi

    resolv() {
        echo "nameserver $1" | sudo tee /etc/resolv.conf
    }
  '';
  programs.nushell.enable = true;
  programs.starship.enableNushellIntegration = true;

  # fix xdg-desktop-portal
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-gtk];
      config.common.default = [ "hyprland" ];
    };
  };

  dconf = {
    enable = true;
  };
}
