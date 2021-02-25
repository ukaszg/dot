function su -w su -d 'Make `su` use fish.'
    command su --shell=/usr/bin/fish $argv
end
