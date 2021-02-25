function killexe -d 'Kill all processes matching *.exe'
    for pid in (pgrep -f '\.exe')                                                                                                                                                                                                                   
        echo Killing [$pid]: (cat /proc/$pid/cmdline)
        kill $1 $pid
    end
end
