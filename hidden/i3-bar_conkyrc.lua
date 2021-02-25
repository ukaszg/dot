conky.config = {
    out_to_console = true,
    background = false,
    max_text_width = 0,

    -- Update interval in seconds
    update_interval = 2.0,
    update_interval_on_battery = 5.0,

    -- This is the number of times Conky will update before quitting.
    -- Set to zero to run forever.
    total_run_times = 0,

    -- Shortens units to a single character (kiB->k, GiB->G, etc.). Default is off.
    short_units = true,

    -- How strict should if_up be when testing an interface for being up?
    -- The value is one of up, link or address, to check for the interface
    -- being solely up, being up and having link or being up, having link
    -- and an assigned IP address.
    if_up_strictness = 'address',

    -- Add spaces to keep things from moving about?  This only affects certain objects.
    -- use_spacer should have an argument of left, right, or none
    use_spacer = 'left',

    -- number of cpu samples to average
    -- set to 1 to disable averaging
    cpu_avg_samples = 2,
    net_avg_samples = 5
};
-- { "full_text": "↓${downspeed wlp3s0} ↑${upspeed wlp3s0}, "name": "wifi"},
conky.text = [[
[
    { "full_text": "${loadavg}", "name": "load" },
    { "full_text": "mem ${memperc}%", "name": "mem" },
    { "full_text": "bat ${battery_short BAT1} ${battery_time BAT1}, "name": "battery"},
    { "full_text": "vol ${exec amixer sget 'Master' | tail -1 | cut -d\[ -f2 | tr -d \]}", "name": "volume" },
    { "full_text": "${time %a %d %B %H:%M}", "name": "clock" }
],
]];
