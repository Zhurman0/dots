function logrun
    set -l copy 0
    set -l errors_only 0
    set -l args

    switch $argv[1]
        case '-c'
            set copy 1
            set args $argv[2..-1]
        case '-e'
            set errors_only 1
            set args $argv[2..-1]
        case '-ce' '-ec'
            set copy 1
            set errors_only 1
            set args $argv[2..-1]
        case '-*'
            echo "$(set_color red)Unknown flag: $(set_color normal)$argv[1]"
            echo "Available flags: -c, -e, -ce, -ec"
            return 1
        case '*'
            set args $argv
    end

    set -l func (string join ' ' "$args")
    set -l shortname (string sub -l 15 -- $func | tr ' ' '-' | tr '/' '-')
    set -l file "/tmp/$(date '+%Y.%m.%d-%H:%M:%S')_$shortname.log"

    echo "$(fish_prompt)$func" > $file

    if test $errors_only -eq 1
        eval $func 2&| tee -a $file
    else
        eval $func 2>&1 | tee -a $file
    end

    echo "Logged $(set_color red)$func$(set_color normal) into $(set_color purple)$file"

    if test $copy -eq 1
        set -l max_kb 100
        set -l size_kb (math (stat -c %s $file) / 1024)

        if test $size_kb -le $max_kb
            cat $file | xclip -selection clipboard
            echo "Copied output to $(set_color yellow)clipboard $(set_color normal)($size_kb KB)"
        else
            echo "$(set_color yellow)Output too large to copy ($size_kb > $max_kb KB)"
        end
    end
end
