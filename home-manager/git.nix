{ config, lib, ... }:

let
    home = config.home.homeDirectory;
    repo = "${home}/Documents/dots";
    src  = "${home}/.config/home-manager";
in {
    home.activation.syncAndPush = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        echo "[hm-git] Syncing configs..."

        cp -rf "${src}/" "${repo}/"
        cd "${repo}"
        
        changes=$(git status --porcelain)
        
        if [ -z "$changes" ]; then
            echo "[hm-git] No changes."
            exit 0
        fi
        
        git add .
        git commit -m "auto: $(date '+%Y-%m-%d %H:%M:%S')"

        echo "[hm-git] Changes commited."

        if ! nc -z -w 2 github.com 443 2&>/dev/null; then
            echo "[hm-git] GitHub unreachable, skipping push."
        else
            git push origin HEAD:alpine 
        fi

        echo "[hm-git] Done."
    '';
}
