function fish_user_key_bindings
    fish_vi_key_bindings
    for m in default insert visual
        bind -M $m \ca beginning-of-line
        bind -M $m \ce end-of-line
        bind -M $m \cp up-or-search
        bind -M $m \cn down-or-search
        bind -M $m \cf forward-char
        bind -M $m \cb backward-char
        bind -M $m \e\x7f backward-kill-word
        bind -M $m \e\b backward-kill-word
        bind -M $m \cs '__ethp_commandline_toggle_sudo.fish'
    end
end
