{
  nixpkgs-unstable,
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.modules.graphical.wm.hyprland;
  pkgs-unstable = import nixpkgs-unstable {system = "x86_64-linux";}; # where you can replace
in {
  options.modules.graphical.wm.hyprland = {enable = mkEnableOption "hyprland";};
  config = mkIf cfg.enable {
    home.packages = with pkgs-unstable; [
      wofi
      swaybg
      wlsunset
      wlogout
      wl-clipboard
      xfce.thunar
      slurp
      grim
      swappy
      swayidle
      swaylock
      blueman
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs-unstable.hyprland;
      systemd.enable = true;
      xwayland.enable = true;
      settings = {
        "$MOD" = "SUPER";
        # 快捷键
        bind = [
          # 终端
          "$MOD, RETURN, exec, alacritty"
          # wofi
          "$MOD, SPACE, exec, wofi --show drun --style=$HOME/.config/style.css"
          # kill
          "$MOD, Q, killactive"
          # 文件管理
          "$MOD, E, exec, thunar"
          # 注销菜单
          "$MOD, M, exec, wlogout --protocol layer-shell"
          # 退出 hyprland
          "$MOD SHIFT, M, exit"
          # 切换浮动与平铺
          "$MOD, V, togglefloating"
          # 用于分割窗口
          "$MOD, P, pseudo"
          "$MOD, J, togglesplit"
          # 截屏
          "$MOD SHIFT, S, exec, grim -g \"$(slurp)\" - | swappy -f -"
          # 全屏
          "$MOD, F, fullscreen, 0"
          # emoji
          "$MOD ALT, M, exec, wofi-emoji"
          # Steam wofi启动steam会卡住， 不知道为什么
          "$MOD SHIFT, G, exec, steam"
          "$MOD, left, movefocus, l"
          "$MOD, right, movefocus, r"
          "$MOD, up, movefocus, u"
          "$MOD, down, movefocus, d"
          # 切换工作区
          "$MOD, 1, workspace, 1"
          "$MOD, 2, workspace, 2"
          "$MOD, 3, workspace, 3"
          "$MOD, 4, workspace, 4"
          "$MOD, 5, workspace, 5"
          "$MOD, 6, workspace, 6"
          "$MOD, 7, workspace, 7"
          "$MOD, 8, workspace, 8"
          "$MOD, 9, workspace, 9"
          "$MOD, 0, workspace, 10"
          # 移活动窗口
          "$MOD SHIFT, 1, movetoworkspace, 1"
          "$MOD SHIFT, 2, movetoworkspace, 2"
          "$MOD SHIFT, 3, movetoworkspace, 3"
          "$MOD SHIFT, 4, movetoworkspace, 4"
          "$MOD SHIFT, 5, movetoworkspace, 5"
          "$MOD SHIFT, 6, movetoworkspace, 6"
          "$MOD SHIFT, 7, movetoworkspace, 7"
          "$MOD SHIFT, 8, movetoworkspace, 8"
          "$MOD SHIFT, 9, movetoworkspace, 9"
          "$MOD SHIFT, 0, movetoworkspace, 10"
          # 通过浏览切换工作区
          "$MOD, mouse_up, workspace, e-1"
          "$MOD, mouse_down, workspace, e+1"

          # pyprland
          "$MOD SHIFT, V, exec, pypr toggle volume"
          "$MOD SHIFT, V, exec, pypr toggle term"
          "$MOD SHIFT, V, exec, pypr reload"

        ];
        # 移动/拖动窗口
        bindm = [
          "$MOD,mouse:272,movewindow"
          "$MOD,mouse:273,resizewindow"
        ];
        env = [
          "LANGUAGE, en_US.UTF-8"
          "LANG, C"
          "LC_ALL, en_US.UTF-8"
          "WLR_NO_HARDWARE_CURSORS,1"
          "CLUTTER_BACKEND, wayland"
        ];
        monitor = [
          "eDP-1,1920x1080@60,0x0, 1"
          # "DP-2, 2560x1440@75, 1920x0, 1"
          #"HDMI-A-1, 2560x1440@75, 1920x0, 1"

          #"HDMI-A-1,1920x1080@60,0x0,1"
        ];
        general = {
          # gaps
          gaps_in = 6;
          gaps_out = 11;

          # border thiccness
          border_size = 2;

          # active border color
          "col.active_border" = "rgb(89b4fa) rgb(cba6f7) 270deg";

          # whether to apply the sensitivity to raw input (e.g. used by games where you aim using your mouse)
          apply_sens_to_raw = 0;
        };

        decoration = {
          # fancy corners
          rounding = 7;

          # blur
          blur = {
            enabled = true;
            size = 3;
            passes = 3;
            ignore_opacity = false;
            new_optimizations = 1;
            xray = true;
            contrast = 0.7;
            brightness = 0.8;
          };

          # shadow config
          drop_shadow = "no";
          shadow_range = 20;
          shadow_render_power = 5;
          "col.shadow" = "rgba(292c3cee)";
        };
        animations = {
          enabled = true;

          bezier = [
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
            "overshot, 0.4,0.8,0.2,1.2"
          ];

          animation = [
            "windows, 1, 4, overshot, slide"
            "windowsOut, 1, 4, smoothOut, slide"
            "border,1,10,default"

            "fade, 1, 10, smoothIn"
            "fadeDim, 1, 10, smoothIn"
            "workspaces,1,4,overshot,slidevert"
          ];
        };

        dwindle = {
          pseudotile = false;
          preserve_split = "yes";
          no_gaps_when_only = false;
        };
        workspace = [
          "1, monitor:eDP-1"
          "2, monitor:eDP-1"
          "3, monitor:eDP-1"
          "4, monitor:eDP-1"
          "5, monitor:eDP-1"
          "6, monitor:DP-2"
          "7, monitor:DP-2"
          "8, monitor:DP-2"
          "9, monitor:DP-2"
          "0, monitor:DP-2"
        ];
        exec-once = [
          "LANG=C waybar"
          "fcitx5 -d"
          "blueman-applet"
          "pypr"
	  # "eww daemon"
	  # "eww open bar"
        ];

        # 窗口规则
        windowrule = [
          # Position
          "float,^(pavucontrol)$"
          "float,^(blueman-manager)$"
          "float,^(nm-connection-editor)$"
          "float,^(thunar)$"
          "float,title:^(Open File)$"
          # opacity
          "opacity 0.80 0.80,class:^(Steam)$"
          "opacity 0.80 0.80,class:^(thunar)$"
          "opacity 0.80 0.80,class:^(Code)$"
          "opacity 0.80 0.70,class:^(pavucontrol)$"
          "opacity 0.90 0.90,class:^(Google Chrome)$"
        ];
      };
    };
  };
}
