#!/usr/bin/env fish

#### USAGE (in sh): ##
# exec wsl-context-do.fish $cmd.exe /usr/bin/$cmd [OPTIONS [OPTIONS...]] "$@"
#
### OPTIONS: these go 1st, multiple are allowed.
# - `--cmd` wrap Windows command in a call to `powershell.exe`.
# - `--wsl` will force usage of WSL command.
# - `--win` will force usage of Windows command.
######################

set -l win_cmd $argv[1]
set -l wsl_cmd $argv[2]
set -l argv $argv[3..-1]

## Options:
set -l options -x 'wsl,win' 'C-cmd' 'L-wsl' 'W-win'
argparse -i -n wsl-context-do.fish $options -- $argv

# Force WSL.
if set -q _flag_wsl
    exec $wsl_cmd $argv
end

# Wrap Windows command in call to `powershell.exe`.
if set -q _flag_cmd
    set win_cmd powershell.exe (wslpath -w $win_cmd)
end

# Force Windows.
if set -q _flag_win
    exec $win_cmd $argv
end

# Run command depending on current dir.
if [ (string sub -l 5 (readlink -f $PWD)) = '/mnt/' ]
    exec $win_cmd $argv
else
    exec $wsl_cmd $argv
end
