set -U fish_user_paths ~/bin ~/.emacs.d/bin /opt/bin /sbin /usr/sbin
set -U fish_greeting ''

set -x EDITOR nvim
set -x VISUAL nvim
set -x XDG_CACHE_DIR "$HOME/.cache/"
set -x XDG_TEMPLATES_DIR "$HOME/.templates/"
set -x XDG_DATA_DIR "$HOME/.local/share/"
set -x XDG_DESKTOP_DIR $HOME/.
set -x XDG_DOWNLOAD_DIR "$HOME/incoming/"
set -x XDG_PUBLICSHARE_DIR "$HOME/pub/"
set -x XDG_DOCUMENTS_DIR "$HOME/org/"
set -x XDG_MUSIC_DIR "$HOME/m/"
set -x XDG_PICTURES_DIR "$HOME/pic/"
set -x XDG_VIDEOS_DIR "$HOME/vid/"
set -x INFOPATH "~/.local/share/info/:$INFOPATH"

# don't create `__pycache__` directories
set -x PYTHONDONTWRITEBYTECODE 'True'

# type gpg password using terminal
set -x GPG_TTY (tty)
