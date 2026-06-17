{ ... }:

let
    colors = (import ../theme.nix).colors;
in {
    xdg.configFile."rofi/config.rasi".text = ''
        configuration {
            modi:                  "drun";
            show-icons:            true;
            location:              6;
        }

        * {
            font:                  "JetBrains Mono Nerd Font 10";
        }

        /* ---Main Window--- */
        window {
            transparency:          "real";
            fullscreen:            false;
            width:                 100%;
            height:                60px;
            border-radius:         30px;
            border-color:          ${colors.pr};
            background-color:      rgba(30, 30, 30, 0.7);
            margin:                3px;
        }

        /* ---Main Box--- */
        mainbox {
            spacing:               0px;
            background-color:      transparent;
            orientation:           horizontal;
            children:              [ "inputbar", "listview" ];
            vertical-align:        0.5;
        }

        /* ---Inputbar--- */
        inputbar {
            padding:               4px;
            background-color:      transparent;
            text-color:            ${colors.text};
            orientation:           horizontal;
            children:              [ "entry" ];
            vertical-align:        0.5;
        }

        entry {
            expand:                false;
            width:                 200px;
            padding:               6px 10px;
            border-radius:         15px;
            background-color:      ${colors.bgAlt};
            text-color:            inherit;
            placeholder:           "";
        }

        listview {
            expand:                true;
            dynamic:               true;
            cycle:                 true;
            scrollbar:             false;
            layout:                horizontal;
            columns:               1;
            lines:                 20;
            border:                0px solid;

            padding:               4px 7px;
            spacing:               10px;
            background-color:      transparent;
            text-color:            ${colors.bg};
        }

        /* ---Elements--- */
        element {
            spacing:               6px;
            padding:               4px 6px;
            border-radius:         15px;
            background-color:      transparent;
            text-color:            ${colors.bg};
        }

        element normal.normal {
            background-color:      transparent;
            text-color:            inherit;
        }

        element selected.normal {
            background-color:      ${colors.pr};
            text-color:            ${colors.text};
        }

        element alternate.normal {
            background-color:      transparent;
        }

        element alternate.selected {
            background-color:      ${colors.pr};
        }

        element-icon {
            background-color:      transparent;
            size:                  25px;
            vertical-align:        0.5;
        }

        element-text {
            background-color:      transparent;
            text-color:            ${colors.text};
            vertical-align:        0.5;
        }

        element-text selected {
            text-color:            ${colors.bgAlt};
        }
    '';
}
