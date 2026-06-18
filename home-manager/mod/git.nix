{ config, lib, ... }:

let
  home = config.home.homeDirectory;
  repo = "${home}/Documents/dots";
  src  = "${home}/.config/home-manager";
in {
  home.activation.syncAndPush = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "[hm-git] Syncing configs..."


    # env variables
    custom_msg="''${HM_SYNC_MSG:-}"
    no_push=''${HM_SYNC_NOPUSH:-}


    # Sync files
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


    # Push logic
    if [ -n "$no_push" ]; then
        echo "[hm-git] Push skipped due to HM_SYNC_NOPUSH."
        exit 0
    fi

    if ! nc -z -w 2 github.com 443 2>/dev/null; then
        echo "[hm-git] GitHub unreachable, skipping push."
    else
        git push origin HEAD:alpine
    fi

    echo "[hm-git] Done."
  '';
}
