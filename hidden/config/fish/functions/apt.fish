function apt -w apt -d 'Wraps apt in a sudo call if needed.'
    sudo /usr/bin/apt $argv
end
