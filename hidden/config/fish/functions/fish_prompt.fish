function fish_prompt
	set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
    set -l pwd (echo -n $PWD | sed "s/^$home_escaped/~/" | sed 's/ /%20/g')
    set -l prompt_symbol ''
    set -l cwd_color ''

    switch "$USER"
        case root toor
            set prompt_symbol '#'
            set cwd_color $fish_color_cwd_root
        case '*'
            set cwd_color $fish_color_cwd
            set prompt_symbol '>'
    end

    printf '%s%s%s@%s%s %s%s%s \n%s ' \
        (set_color $fish_color_user) \
        $USER \
        (set_color $fish_color_comment) \
        (set_color $fish_color_host) \
        (hostname) \
        (set_color $cwd_color) \
        $pwd \
        (set_color normal) \
        $prompt_symbol
end
