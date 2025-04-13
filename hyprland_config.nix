{ config, pkgs, home, lib, ... }:

rec {
  wayland.windowManager.hyprland.extraConfig = ''
    windowrulev2 = workspace 6,class:virt-manager
    windowrulev2 = workspace 9,class:pavucontrol
    exec-once = uwsm app -- notrs
    exec-once = uwsm app -- systemctl --user start hyprpolkitagent
    exec-once = uwsm app -- waybar &
    exec-once = uwsm app -- hypridle &
    exec-once = uwsm app -- enable_agent.sh &
    exec-once = uwsm app -- wl-paste --watch cliphist store & // until clipcat is fixed
    exec-once = uwsm app -- wlsunset -l 48.86 -L 2.33
    exec-once = uwsm app -- pypr --debug /tmp/pypr.log
  '';
  wayland.windowManager.hyprland.settings = {
    decoration = {
      rounding = "0";
      dim_inactive = "off";
    };
    plugin = {
      hyprsplit = {
        num_workspace = 10;
      };
    };
    misc = {
      vfr = "true";
      disable_hyprland_logo = "true";
    };
    general = {
      gaps_in = 2;
      gaps_out = 2;
      border_size = 1;
      layout = "dwindle";
    };
    dwindle = {
      preserve_split = 1;
    };
    input = {
      kb_layout = "us";
      kb_variant = "intl";
      kb_model = "";
      kb_options = "ctrl:nocaps";
      kb_rules = "";
      follow_mouse = 1;
      sensitivity = 0;
      touchpad = {
        natural_scroll = "no";
        disable_while_typing = "yes";
      };
    };
    animations = {
      enabled = "no";
    };
    "$mod" = "SUPER";
    #"windowrulev2" = "workspace 6,class:virt-manager";
    #"windowrulev2" = "workspace 9,class:pavucontrol";
    bind = [
      "$mod, return, exec, wezterm"
      "$mod, C, killactive,"
      "$mod, M, exec, wezterm -e ${config.home.homeDirectory}/.config/hypr/manix.sh"
      "$mod, K, exit"
      "$mod, E, exec, wezterm -e yazi"
      "$mod, L, exec, hyprlock"
      "$mod, S, exec, grim -g \"$(slurp -o -r -c '##ff0000ff')\" -t ppm - | satty --filename - --fullscreen --output-filename /tmp/satty-$(date '+%Y%m%d-%H:%M:%S').png"
      "$mod, R, exec, wofi --show run"
      "$mod, P, exec, ${config.home.homeDirectory}/.config/hypr/wofi-power-menu.sh"
      "$mod, O, split:swapactiveworkspaces, current +1"
      "$mod SHIFT, O, split:grabroguewindows"
      "$mod, J, togglesplit,"
      "$mod, V, togglefloating,"

      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
      "$mod SHIFT, up, workspace, e+1"
      "$mod SHIFT, down, workspace, e-1"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"

      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, 0, split:workspace, 11"
      "$mod SHIFT, 0, workspace, split:movetoworkspacesilent, 11"
    ]
    ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, split:workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, split:movetoworkspacesilent, ${toString ws}"
            ]
          )
          9)
      );
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
