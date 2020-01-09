current_time_without_combat = 0 -- How long currently without combat
combat_autosave_delay = 60 -- How many ticks until saving
saved = true -- if we saved after the last fight
firstRun = true -- dont't do things when the game just loaded

script.on_nth_tick(30, function()
    if (firstRun == false) then
        for index, player in pairs(game.connected_players) do
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
        end
    else
        firstRun = false
    end
end
)