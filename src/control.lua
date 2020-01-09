current_time_without_combat = 0 -- How long currently without combat
saved = true -- if we saved after the last fight
firstRun = true -- dont't do things when the game just loaded (tick 0)

-- Handle the autosaving
function tick_handler()
    if (firstRun == false) then
        player = game.connected_players[1]
        if player.in_combat then
            current_time_without_combat = 0
            saved = false
        else
            if saved == false then
                current_time_without_combat = current_time_without_combat + 30
                if current_time_without_combat >= combat_autosave_delay then
                    game.auto_save()
                    saved = true
                    current_time_without_combat = 0
                end
            end
        end
    else
        firstRun = false
    end
end

function loadSettings()
    combat_autosave_delay = 60 * settings.global["combat_autosave_delay"].value -- How many ticks until saving, time is s * 60 = ticks
end

-- Read delay initially from settings
script.on_init(loadSettings)
script.on_load(loadSettings)

-- read the new value for the delay
script.on_configuration_changed(function()
    loadSettings()
end)

-- Register the tick handler
script.on_nth_tick(30, tick_handler)