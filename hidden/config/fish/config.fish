set -Ux fish_user_paths ~/bin ~/.emacs.d/bin ~/.local/node_modules/.bin ~/.local/bin /opt/bin /sbin /usr/sbin
set -Ux fish_greeting ''

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx XDG_CACHE_DIR "$HOME/.cache/"
set -gx XDG_TEMPLATES_DIR "$HOME/.templates/"
set -gx XDG_DATA_DIR "$HOME/.local/share/"
set -gx XDG_DESKTOP_DIR $HOME/.
set -gx XDG_DOWNLOAD_DIR "$HOME/incoming/"
set -gx XDG_PUBLICSHARE_DIR "$HOME/pub/"
set -gx XDG_DOCUMENTS_DIR "$HOME/org/"
set -gx XDG_MUSIC_DIR "$HOME/m/"
set -gx XDG_PICTURES_DIR "$HOME/pic/"
set -gx XDG_VIDEOS_DIR "$HOME/vid/"
set -gx INFOPATH "~/.local/share/info/:$INFOPATH"

# don't create `__pycache__` directories
set -x PYTHONDONTWRITEBYTECODE 'True'

# type gpg password using terminal
set -x GPG_TTY (tty)

