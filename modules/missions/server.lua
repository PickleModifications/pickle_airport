RegisterNetEvent("pickle_airport:finishedMission", function(index)
    local source = source
    if (PermissionCheck(source, "pilot_mission")) then
        local data = Config.Missions.Sequences[index]
        local rewards = data.Rewards
        for i=1, #rewards do 
            local amount = GetRandomInt(rewards[i].min, rewards[i].max)
            AddItem(source, rewards[i].name, amount)
        end
    else
        ShowNotification(source, U.permission_denied)
    end
end)