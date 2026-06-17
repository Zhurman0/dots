{ lib, ... }:

let
    functions = {
        fish_greeting = ''
            echo "Welcome to the club, $(set_color red)$(whoami)$(set_color normal)"
        '';

        fish_prompt = ''
            set -l color  "$(set_color brblack)"
            set -l normal "$(set_color normal)"

            set -l tmpname (prompt_hostname)
            if set -q IN_NIX_SHELL
                set -l tmpname "nix-shell"
            end

            set -l user   (set_color yellow)(whoami)$color
            set -l host   (set_color white)$tmpname$color
            set -l path   (set_color green)(prompt_pwd)$color
            set -l prompt (set_color red)'>'$color

            echo -e "$color┌[$user@$host]-[$path]\n└ $prompt $normal"
        '';

        hm-edit = ''
            if test (count $argv) -eq 0
                echo "Usage: hm-edit <module>"
                return 1
            end

            micro /home/hurma/.config/home-manager/$argv[1].nix
        '';

        hm-switch = ''
            home-manager switch --flake /home/hurma/.config/home-manager/ $argv
        '';

        la = '' eza -la $argv '';
        ls = '' eza $argv '';
        lt = '' eza -T $argv '';

        niri-quit = '' niri msg action quit $argv '';
        niri-session = '' dbus-run-session niri --session $argv '';
    };

    generatedFiles =
        lib.mapAttrs'
            (name: body: {
                name = "fish/functions/${name}.fish";
                value.text = ''
                    function ${name}
                        ${body}
                    end
                '';
            })
            functions;

in {
    xdg.configFile = generatedFiles;
}
