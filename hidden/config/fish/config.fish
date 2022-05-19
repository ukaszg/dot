set -Ux fish_user_paths $HOME/bin $HOME/.emacs.d/bin $HOME/.local/node_modules/.bin $HOME/.local/go/bin $HOME/.local/bin /opt/bin /sbin /usr/sbin
set -Ux fish_greeting ''

set -gx EDITOR vim
set -gx VISUAL vim
set -gx GOPATH "$HOME/.local/go"
set -gx XDG_CACHE_DIR "$HOME/.cache/"
set -gx XDG_TEMPLATES_DIR "$HOME/.templates/"
set -gx XDG_DATA_DIR "$HOME/.local/share/"
set -gx XDG_DESKTOP_DIR /.
set -gx XDG_DOWNLOAD_DIR "$HOME/incoming/"
set -gx XDG_PUBLICSHARE_DIR "$HOME/pub/"
set -gx XDG_DOCUMENTS_DIR "$HOME/org/"
set -gx XDG_MUSIC_DIR "$HOME/m/"
set -gx XDG_PICTURES_DIR "$HOME/pic/"
set -gx XDG_VIDEOS_DIR "$HOME/vid/"
set -gx INFOPATH "$HOME/.local/share/info/:$INFOPATH"
set -gx DISPLAY (ip route|awk '/^default/{print $3}'):0.0

# don't create `__pycache__` directories
set -x PYTHONDONTWRITEBYTECODE 'True'

# type gpg password using terminal
set -x GPG_TTY (tty)

if test -x ~/.local.fish
    . ~/.local.fish
end
