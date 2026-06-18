{ config, lib, ... }:

let
  home = config.home.homeDirectory;
  repo = "${home}/Documents/dots";
  src  = "${home}/.config/home-manager";
in {
  home.activation.syncAndPush = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "[hm-git] Syncing configs..."


    # Parse arguments
    custom_msg=""
    do_push=1

    while [ $# -gt 0 ]; do
        case "$1" in
            --msg)
                shift
                custom_msg="$1"
                ;;
            --no-push)
                do_push=0
                ;;
        esac
        shift
    done


    # Sync files
    rm -rf "${src}/home-manager"
    cp -rf "${src}/" "${repo}/"
    cd "${repo}"

    changes=$(git status --porcelain)

    if [ -z "$changes" ]; then
        echo "[hm-git] No changes."
        exit 0
    fi


    # Commit message
    if [ -n "$custom_msg" ]; then
        msg="$custom_msg"
    else
        msg="auto: $(date '+%Y-%m-%d %H:%M:%S')"
    fi

    git add .
    git commit -m "$msg"

    echo "[hm-git] Changes committed."


    # Push
    if [ "$do_push" -eq 0 ]; then
        echo "[hm-git] Push skipped."
        exit 0
    fi

    if ! nc -z -w 2 github.com 443 2>/dev/null; then
        echo "[hm-git] GitHub unreachable."
    else
        git push origin HEAD:alpine
    fi


    echo "[hm-git] Done."
  '';
}
