function fish_prompt
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
end
