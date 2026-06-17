{ ... }:

let
    inherit (import ../theme.nix) colors cursor wallpaper;
in {
    xdg.configFile."niri/config.kdl".text = ''
        layout {
            gaps 3
            empty-workspace-above-first

            default-column-display "normal"
            default-column-width { proportion 0.7; }

            center-focused-column "never"

            preset-column-widths {
                proportion 0.3
                proportion 0.35
                proportion 0.5
                proportion 0.7
                proportion 1.0
            }

            preset-window-heights {
                proportion 0.5
                proportion 0.7
                proportion 0.9
                proportion 1.0
            }

            focus-ring { off; }

            border {
                width 3
                active-color   "${colors.pr}"
                inactive-color "${colors.bg}"
                urgent-color   "${colors.bgAlt}"
            }

            tab-indicator {
                hide-when-single-tab
                place-within-column

                width 20
                gap 2

                length total-proportion=1.0
                position "right"

                active-color   "${colors.pr}"
                inactive-color "${colors.bg}"
                urgent-color   "${colors.bgAlt}"
            }

            insert-hint {
                color "${colors.pr}"
            }
        }

        output "HDMI-A-1" {
            mode "1920x1080@74.97"
            position x=0 y=0
            focus-at-startup
        }

        input {
            mod-key "Alt"
            keyboard {
                xkb {
                    layout  "us,ru"
                    options "grp:caps_toggle,compose:ralt,grp_led:caps"
                }

                track-layout "global"
                repeat-delay 1000
                repeat-rate  32

                numlock
            }
        }

        cursor {
            xcursor-theme "${cursor.theme}"
            xcursor-size   ${toString cursor.size}

            hide-when-typing
            hide-after-inactive-ms 3000
        }

        screenshot-path "/tmp/scrot/Screenshot from %Y-%m-%d_%H-%M-%S.png"

        window-rule {
            match app-id="com.ayugram.desktop"
            default-column-width { proportion 0.3; }
        }

        window-rule {
            match app-id="blueman-manager"
            default-column-width { proportion 0.3; }
        }

        window-rule {
            match app-id="com.ayugram.desktop" title="Media viewer"
            open-fullscreen true
        }

        window-rule {
            match app-id="PortProton"
            open-floating true
        }

        window-rule {
            match app-id="steam"
            default-column-width { proportion 1.0; }
        }

        recent-windows { off; }

        binds {
            Super+Q { close-window; }
            Super+T { spawn "foot"; }
            Super+R { spawn "rofi" "-show" "drun"; }
            Super+W { spawn "firefox"; }
            Super+F { spawn "thunar"; }

            Mod+T   { toggle-column-tabbed-display; }
            Mod+M   { fullscreen-window; }
            Mod+F   { toggle-window-floating; }
            Mod+H   { consume-window-into-column; }
            Mod+L   { expel-window-from-column; }
            Mod+J   { switch-preset-column-width; }
            Mod+K   { switch-preset-window-height; }

            Super+H { focus-column-left; }
            Super+L { focus-column-right; }
            Super+J { focus-window-down; }
            Super+K { focus-window-up; }
            Super+M { switch-focus-between-floating-and-tiling; }

            Super+Y { focus-column-first; }
            Super+N { focus-column-last; }

            Super+Mod+H { move-column-left; }
            Super+Mod+L { move-column-right; }

            Print            { screenshot; }
            Shift+Print      { screenshot-window; }
            Ctrl+Shift+Print { screenshot-screen; }

            XF86AudioLowerVolume { spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "-5%"; }
            XF86AudioRaiseVolume { spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "+5%"; }
            XF86AudioMute        { spawn "pactl" "set-sink-mute"   "@DEFAULT_SINK@" "toggle"; }
        }

        spawn-at-startup "waybar"
        spawn-at-startup "throne"
        spawn-at-startup "firefox"
        spawn-at-startup "AyuGram"
        spawn-sh-at-startup "swaybg -i ${wallpaper} -m fill"
    '';
}
