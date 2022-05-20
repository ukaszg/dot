#!/usr/bin/env fish

set -l real_path (readlink -f $PWD)
set -l win_cmd $argv[1]
set -l wsl_cmd $argv[2]
set -l argv $argv[3..-1]

if test (string sub -l 5 $real_path) = "/mnt/"
    exec $win_cmd $argv
else
    exec $wsl_cmd $argv
end
