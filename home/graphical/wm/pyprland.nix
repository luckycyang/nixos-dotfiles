{
  pkgs-unstable,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.graphical.wm.pyprland;
in {
  options.modules.graphical.wm.pyprland = {
    enable = mkEnableOption "Pyprland";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs-unstable; [ pyprland ];
    xdg.configFile."hypr/pyprland.toml".text = ''
        [pyprland]
        plugins = [
          "toggle_special",
          "scratchpads",
          "lost_windows",
          "monitors",
          "shift_monitors",
          "toggle_dpms",
          "magnify",
          "expose",
          "workspaces_follow_focus",
        ]

        [workspaces_follow_focus]
        max_workspaces = 9

        [expose]
        include_special = false

        [scratchpads.term]
        animation = "fromTop"
        command = "alacritty --class scratchpad"
        class = "alacritty-dropterm"
        size = "75% 60%"
        max_size = "1920px 100%"
       

        [scratchpads.volume]
        animation = "fromRight"
        command = "pavucontrol"
        class = "pavucontrol"
        lazy = true
        size = "40% 90%"
        max_size = "1080px 100%"
        unfocus = "hide"

        [layout_center]
        margin = 60
        offset = [0, 30]
        next = "movefocus r"
        prev = "movefocus l"
        next2 = "movefocus d"
        prev2 = "movefocus u"
  '';
  };
}

