{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vaelio";
  home.homeDirectory = "/home/vaelio";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # GUI
    pkgs.hyprland
    pkgs.waybar
    pkgs.xwayland
    pkgs.wayland
    pkgs.hypridle
    pkgs.pyprland
    pkgs.xdg-desktop-portal-hyprland
    pkgs.hyprpaper
    pkgs.hyprlock
    (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})
    pkgs.wofi
    pkgs.pavucontrol
    pkgs.betterbird
    pkgs.neovide
    pkgs.wl-clipboard-rs

    # TERM
    pkgs.bat
    pkgs.alacritty
    pkgs.lsd
    pkgs.kitty
    pkgs.iamb
    pkgs.procs
    pkgs.simple-http-server
    pkgs.tokei
    pkgs.navi
    pkgs.yazi
    pkgs.rio

    # Screenshot
    pkgs.grim
    pkgs.qt5.full
    pkgs.qt5.qttools
    pkgs.qt5.qtsvg

    # Tools
    pkgs.chromium
    pkgs.vscodium
    pkgs.openlens
    pkgs.cloudflared
    pkgs.moonlight-qt
    pkgs.quickemu
    pkgs.virt-manager
    pkgs.remmina
    pkgs.netscanner
    pkgs.mpv
    pkgs.nmap
    pkgs.exegol

    # fonts
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    pkgs.nerdfonts
    pkgs.font-awesome

    # rust
    pkgs.cargo
    pkgs.cargo-update

  ];

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
    ".config/hypr/hyprpaper.conf".source = dotfiles/hyprpaper.conf;
    ".config/hypr/hyprland.conf".source = dotfiles/hyprland.conf;
    ".config/hypr/hypridle.conf".source = dotfiles/hypridle.conf;

    # waybar
    ".config/waybar/config".source = dotfiles/waybar_config;
    ".config/waybar/style.css".source = dotfiles/waybar_style.css;
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
    PATH="$HOME/.cargo/bin/:$PATH";
    #XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS";
  };

  # setup aliases
  home.shellAliases = {
    vim="nvim";
    ls="lsd";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Enable bash and starship prompt
  programs.bash.enable = true;
  programs.starship.enable = true;
}
