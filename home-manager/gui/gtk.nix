{ ... }:

let
    inherit (import ../theme.nix) cursor gtk;
in
{
    xdg.configFile."gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-theme-name=${gtk.theme}
        gtk-application-prefer-dark-theme=1
        gtk-icon-theme-name=${gtk.icons}
        gtk-cursor-theme-name=${cursor.theme}
        gtk-font-name=Sans 10
        gtk-enable-animations=true
        gtk-toolbar-style=GTK_TOOLBAR_BOTH
        gtk-menu-images=true
        gtk-button-images=true
    '';
}
