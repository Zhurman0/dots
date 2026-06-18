{ ... }:

{
    xdg.configFile = {
        "fastfetch/config.jsonc".text = ''
            {
                "display": { "separator": " " },
            
                "modules": [
                    { "type": "title",  "key": " " },
                    { "type": "custom", "key": "╭──────────────╮" },
            
                    { "type": "os",      "key": "│ Os           │ " },
                    { "type": "kernel",  "key": "│ Kernel       │ ", "format": "{release}" },
                    { "type": "uptime",  "key": "│ Uptime       │ " },
                    { "type": "packages","key": "│ Packages     │ " },
            
                    { "type": "custom",  "key": "├──────────────┤" },
            
                    { "type": "display", "key": "│ Display      │ ", "format": "{width}x{height} @ {refresh-rate}Hz" },
                    { "type": "wm",      "key": "│ Wm           │ " },
                    { "type": "terminal","key": "│ Terminal     │ " },
                    { "type": "shell",   "key": "│ Shell        │ " },
            
                    { "type": "custom",  "key": "├──────────────┤" },
            
                    { "type": "cpu",     "key": "│ CPU          │ ", "showPeCoreCount": true },
                    { "type": "memory",  "key": "│ RAM          │ " },
                    { "type": "gpu",     "key": "│ GPU          │ ", "format": "{vendor} {name}", "hideType": "integrated" },
            
                    { "type": "custom",  "key": "├──────────────┤" },
            
                    {
                        "type": "disk",
                        "key": "│ Disk (/)     │ ",
                        "folders": "/",
                        "format": "{size-used} / {size-total} ({size-percentage})  {create-time}"
                    },

                    {
                        "type": "disk",
                        "key": "│ Disk (games) │ ",
                        "folders": "/media/games",
                        "format": "{size-used} / {size-total} ({size-percentage})  {create-time}"
                    },
            
                    { "type": "custom",  "key": "╰──────────────╯" }
                ]
            }
        '';

        "fastfetch/minimal.jsonc".text = ''
            {
                "display": { "separator": " " },
            
                "modules": [
                    { "type": "title",    "key": " " },
                    { "type": "custom",   "key": "╭──────────────╮" },
            
                    { "type": "os",       "key": "│ Os           │ " },
                    { "type": "packages", "key": "│ Packages     │ " },
            
                    { "type": "wm",       "key": "│ Wm           │ " },
                    { "type": "terminal", "key": "│ Terminal     │ " },
                    { "type": "cpu",      "key": "│ CPU          │ ", "showPeCoreCount": true },
            
                    { "type": "custom",   "key": "╰──────────────╯" }
                ]
            }
        '';
    };
}
