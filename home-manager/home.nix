{ config, pkgs, ... }:

{
    imports = [
        ./gui/niri.nix
        ./gui/waybar.nix
        ./gui/rofi.nix
        ./gui/foot.nix
        ./gui/fish.nix
        ./gui/gtk.nix
        
        ./git.nix
    ];


    home.username      = "hurma";
    home.homeDirectory = "/home/hurma";
    home.stateVersion  = "26.05";

    home.packages = with pkgs; [
        ayugram-desktop
        gmad
        
        glibcLocales
    ];


    programs.home-manager.enable = true;
}
