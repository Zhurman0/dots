{ ... }:

let
    colors = (import ./theme.nix).colors;
in {
    xdg.configFile."waybar/config.jsonc".text = ''
        {
            "reload_style_on_change": true,
            "layer":    "top",
            "position": "left",
            "width":    44,
            "margin":   "3",

            "modules-left": [
                "custom/separator",
                "custom/language_label",
                "niri/language",
                "custom/separator",
                "custom/pulseaudio_label",
                "pulseaudio"
            ],

            "modules-center": [
                "clock#date",
                "custom/separator",
                "clock#time",
                "custom/separator",
                "tray"
            ],

            "modules-right": [
                "custom/cpu_label",
                "cpu",
                "custom/separator",
                "custom/memory_label",
                "memory",
                "custom/separator"
            ],

            "custom/separator": {
                "rotate":   90,
                "format":   "│"
            },

            "clock#date": {
                "rotate":   90,
                "format":   "{:%a %d.%m}",
                "interval": 1800,
                "tooltip-format": "<tt><small>{calendar}</small></tt>",
                "calendar": {
                    "mode":         "month",
                    "weeks-pos":    "right",
                    "format": {
                        "months":   "<span color='#ffead3'><b>{}</b></span>",
                        "weeks":    "<span color='#C2C3C0'><b>{:%W}</b></span>",
                        "weekdays": "<span color='#495C6B'><b>{}</b></span>",
                        "today":    "<span color='#ff6699'><b><u>{}</u></b></span>"
                    }
                },
                "actions": {
                    "on-scroll-up":   "shift_up",
                    "on-scroll-down": "shift_down"
                }
            },

            "clock#time": {
                "rotate":   90,
                "format":   "{:%I:%M%p}",
                "interval": 60,
                "tooltip":  false
            },

            "custom/language_label": {
                "format": "Lng"
            },

            "niri/language": {
                "format":    "{short}",
                "format-us": "US",
                "format-RU": "RU",
                "expand":    false
            },

            "custom/pulseaudio_label": {
                "format": "Vol"
            },

            "pulseaudio": {
                "format":       "{volume}%",
                "format-muted": "---",
                "scroll-step":  5,
                "tooltip":      false
            },

            "tray": {
                "icon-size": 22,
                "spacing":   2
            },

            "custom/cpu_label": {
                "format": "CPU"
            },

            "cpu": {
                "format":   "{usage}%",
                "interval": 2
            },

            "custom/memory_label": {
                "format": "RAM"
            },

            "memory": {
                "format":   "{percentage}%",
                "interval": 2
            }
        }
    '';

    xdg.configFile."waybar/style.css".text = ''
        window#waybar {
            background:  #0E0F06;
            color:       ${colors.text};
        }

        * {
            font-family: monospace;
            font-size:   15px;
            color:       ${colors.text};
            background:  transparent;
            font-weight: normal;
        }

        #custom-separator {
            color:       ${colors.bg};
            padding:     1px;
            font-size:   20px;
        }

        #custom-language_label,
        #custom-pulseaudio_label,
        #custom-cpu_label,
        #custom-memory_label {
            color:       ${colors.prAlt};
            font-weight: bold;
        }
    '';
}
