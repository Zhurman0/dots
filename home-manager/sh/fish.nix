{ lib, ... }:

{
  xdg.configFile =
    lib.mapAttrs'
      (name: body: {
        name = "fish/functions/${name}.fish";
        value.text = ''
          function ${name}
              ${body}
          end
        '';
      })
    {
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
            home-manager switch --flake ~/.config/home-manager/ $argv
        '';

        la = '' eza -la $argv '';
        ls = '' eza $argv '';
        lt = '' eza -T $argv '';

        niri-quit    = '' niri msg action quit $argv '';
        niri-session = '' dbus-run-session niri --session $argv '';

        ff    = '' fastfetch $argv '';
        ffmin = '' fastfetch --config ~/.config/fastfetch/minimal.jsonc $argv '';

        nctar = ''
            function nctar --description 'Archives the specified files and directories and sends them via netcat to the specified IP address and port'
                if contains -- --help $argv; or contains -- -h $argv
                    echo 'Usage: nctar [OPTIONS] PATH... IP'
                    echo
                    echo 'Archive files and directories, then send the tar stream to IP using netcat.'
                    echo
                    echo 'Arguments:'
                    echo '  PATH...       One or more files or directories to archive'
                    echo '  IP            Destination IP address (the final positional argument)'
                    echo
                    echo 'Options:'
                    echo '  -p, --port PORT   Destination port (default: 25565)'
                    echo '  -h, --help        Show this help message'
                    echo
                    echo 'Examples:'
                    echo '  nctar mydir 192.168.0.105'
                    echo '  nctar file1 mydir 192.168.0.105 -p 25565'
                    return 0
                end
            
                
                argparse 'p/port=' -- $argv
                or return 1
            
                if test (count $argv) -lt 2
                    echo 'Error: provide at least one PATH and a destination IP.' >&2
                    echo 'Run "nctar --help" for usage.' >&2
                    return 2
                end
                
            
                set -l ip $argv[-1]
                set -l paths $argv[1..-2]
                set -l port 25565
            
                if set -q _flag_port
                    set port $_flag_port
                end
            
                set -l size (du -sb -- $paths | awk '{sum += $1} END {print sum}')
                tar -cf - -- $paths | pv -s $size | nc $ip $port
            end
        '';
    };
}
