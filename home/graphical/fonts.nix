{pkgs, ...}:
{
  home.packages = with pkgs; [
      wqy_zenhei
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      iosevka
      # nerd c
      powerline-fonts
      material-design-icons
      martian-mono
      font-awesome
      weather-icons
      source-code-pro
      fira-code-nerdfont
  ];
}
