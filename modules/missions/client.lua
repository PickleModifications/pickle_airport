local MissionIndex, MissionAircraft, MissionBlip = nil, nil, nil

function SetMissionBlip(coords, blipType)
    if MissionBlip ~= nil then 
        RemoveBlip(MissionBlip)
        MissionBlip = nil
    end
    if coords then 
        local info = Config.Missions.Blips[blipType]
        MissionBlip = CreateBlip({
            Location = coords,
            Label = info.Label,
            ID = info.ID,
            Scale = info.Scale,
            Color = info.Color
        }) 
    end
end

function DeliveryMission(index, cb)
    local mission = Config.Missions.Sequences[index]
    local boxProp = nil

    local function Cleanup()
        SetMissionBlip()

        if boxProp then
            local ped = PlayerPedId()
            DeleteEntity(boxProp)
            ClearPedSecondaryTask(ped)
            boxProp = nil
        end
    end

    Citizen.CreateThread(function()
        local done = false
        
        ShowNotification(U.package_pickup_notify)
        SetMissionBlip(mission.PackagePickup, "PackagePickup")
        
        while index == MissionIndex and not done do 
            if (not DoesEntityExist(MissionAircraft) or GetEntityHealth(MissionAircraft) <= 0) then 
                Cleanup()
                cb(false)
                return
            end
            local wait = 1000
            local ped = PlayerPedId()
            local coords = mission.PackagePickup
            local pcoords = GetEntityCoords(ped)
            local dist = #(coords - pcoords)
            if (dist < 20) then
                wait = 0
                DrawMarker(2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 255, 255, 255, 127, false, true)
                if (dist < 1.25 and not ShowHelpNotification(U.package_pickup) and IsControlJustPressed(1, 51)) then
                    done = true
                    break
                end
            end
            Wait(wait)
        end
       
        if (not done) then 
            Cleanup()
            cb(false)
            return
        end
        done = false

        ShowNotification(U.package_dropoff_notify)
        SetMissionBlip(mission.PackageDropoff, "PackageDropoff")

        while index == MissionIndex and not done do 
            if (not DoesEntityExist(MissionAircraft) or GetEntityHealth(MissionAircraft) <= 0) then 
                Cleanup()
                cb(false)
                return
            end

            local wait = 1000
            local ped = PlayerPedId()
            local coords = mission.PackageDropoff
            local pcoords = GetEntityCoords(ped)
            local acoords = GetEntityCoords(MissionAircraft)
            local dist = #(coords - pcoords)
            local adist = #(coords - acoords)
            local vehicle = GetVehiclePedIsIn(ped)
            if (vehicle ~= 0 and boxProp) then 
                DeleteEntity(boxProp)
                ClearPedSecondaryTask(ped)
                boxProp = nil
            elseif (vehicle == 0) then
                if not IsEntityPlayingAnim(ped, "anim@heists@box_carry@", "idle", 13) then 
                    PlayAnim(ped, "anim@heists@box_carry@", "idle", -8.0, 8.0, -1, 49, 1.0)
                    Wait(10)
                end
                if (not boxProp) then
                    local bone = GetPedBoneIndex(ped, 60309)
                    local c, r = vec3(0.025, 0.08, 0.285), vec3(-165.0, 250.0, 0.0)
                    boxProp = CreateProp(`hei_prop_heist_box`, pcoords.x, pcoords.y, pcoords.z, true, true)
                    AttachEntityToEntity(boxProp, ped, bone, c.x, c.y, c.z, r.x, r.y, r.z, false, false, false, false, 2, true)
                elseif (boxProp and dist < 20 and adist < 40) then 
                    wait = 0
                    DrawMarker(2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.25, 0.25, 0.25, 255, 255, 255, 127, false, true)
                    if (dist < 1.25 and not ShowHelpNotification(U.package_dropoff) and IsControlJustPressed(1, 51)) then
                        done = true
                        break
                    end
                end
            end
            Wait(wait)
        end
        
        Cleanup()

        cb(done)
    end)
end

function PassengerMission(index, cb)
    local mission = Config.Missions.Sequences[index]
    local peds = {}
    local seats = GetVehicleModelNumberOfSeats(GetEntityModel(MissionAircraft)) - 2

    local function Cleanup()
        SetMissionBlip()
        for i=1, #peds do 
            DeleteEntity(peds[i])
        end
    end
    Citizen.CreateThread(function()
        local done = false

        ShowNotification(U.passenger_pickup_notify)
        SetMissionBlip(mission.PassengerPickup, "PassengerPickup")
        
        while index == MissionIndex and not done do 
            if (not DoesEntityExist(MissionAircraft) or GetEntityHealth(MissionAircraft) <= 0) then 
                Cleanup()
                cb(false)
                return
            end
            local wait = 1000
            local ped = PlayerPedId()
            local coords = mission.PassengerPickup
            local pcoords = GetEntityCoords(ped)
            local dist = #(coords - pcoords)
            if (dist < 20) then
                wait = 0
                DrawMarker(2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 255, 255, 127, false, true)
                if (dist < 1.25 and not ShowHelpNotification(U.passenger_pickup) and IsControlJustPressed(1, 51)) then
                    done = true
                    break
                end
            end
            Wait(wait)
        end

        if (done) then 
            ShowNotification(U.passenger_loading)
            FreezeEntityPosition(MissionAircraft, true)
            local vehicle = MissionAircraft
            local coords = mission.PassengerPickup
            for i=1, seats do 
                if IsVehicleSeatFree(vehicle, i) then 
                    local ped = CreateNPC(`g_m_m_armboss_01`, coords.x, coords.y, coords.z + 100.0, 0.0, true, true)
                    peds[#peds + 1] = ped
                    TaskWarpPedIntoVehicle(ped, vehicle, i)
                    Wait(1000)
                end
            end
            FreezeEntityPosition(MissionAircraft, false)
        else
            Cleanup()
            cb(false)
            return
        end

        done = false
        
        ShowNotification(U.passenger_dropoff_notify)
        SetMissionBlip(mission.PassengerDropoff, "PassengerDropoff")

        while index == MissionIndex and not done do 
            if (not DoesEntityExist(MissionAircraft) or GetEntityHealth(MissionAircraft) <= 0) then 
                Cleanup()
                cb(false)
                return
            end

            local wait = 1000
            local ped = PlayerPedId()
            local coords = mission.PassengerDropoff
            local pcoords = GetEntityCoords(ped)
            local acoords = GetEntityCoords(MissionAircraft)
            local dist = #(coords - pcoords)
            local adist = #(coords - acoords)
            local vehicle = GetVehiclePedIsIn(ped)
            if (vehicle == MissionAircraft and dist < 20 and adist < 40) then 
                wait = 0
                DrawMarker(2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 255, 255, 127, false, true)
                if (dist < 1.25 and not ShowHelpNotification(U.passenger_dropoff) and IsControlJustPressed(1, 51)) then
                    done = true
                    break
                end
            end
            Wait(wait)
        end

        if (done) then 
            ShowNotification(U.passenger_unloading)
            FreezeEntityPosition(MissionAircraft, true)
            local vehicle = MissionAircraft
            for i=1, #peds do 
                DeleteEntity(peds[i])
                Wait(1000)
            end
            FreezeEntityPosition(MissionAircraft, false)
            Cleanup()
        else
            Cleanup()
            cb(false)
            return
        end
        

        cb(done)
    end)
end

function StopMission()
    MissionIndex = nil
    MissionAircraft = nil
    SetMissionBlip()
end

function StartMission(Type)
    local vehicle = (Config.MissionCommand and GetCurrentAircraft() or nil)
    if MissionIndex == nil then 
        if not vehicle then 
            if (Type and Config.MissionTypes[Type]) then 
                local model = Config.MissionTypes[Type].Model
                local coords, heading = GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId())
                vehicle = CreateVeh(model, coords.x, coords.y, coords.z, heading, true, true)
                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                Wait(100)
            else
                ShowNotification("You cannot start a mission without being in a aircraft.")
                return
            end
        end
        local index = GetRandomInt(1, #Config.Missions.Sequences)
        if Type then 
            for i=1, 10 do 
                if Config.Missions.Sequences[index].Type ~= Type then
                    index = GetRandomInt(1, #Config.Missions.Sequences)
                else
                    break
                end
            end
            if Config.Missions.Sequences[index].Type ~= Type then 
                ShowNotification("There are no missions for this category.")
                return
            end
        end
        MissionIndex = index
        MissionAircraft = vehicle
        local mission = Config.Missions.Sequences[MissionIndex]
        if (mission.Type == "Delivery") then 
            DeliveryMission(MissionIndex, function(result)
                if result then
                    ShowNotification("Mission completed!")
                    TriggerServerEvent("pickle_airport:finishedMission", MissionIndex)
                else 
                    ShowNotification("Mission failed.")
                end
                StopMission()
            end)
        elseif (mission.Type == "Passenger") then 
            PassengerMission(MissionIndex, function(result)
                if result then
                    ShowNotification("Mission completed!")
                    TriggerServerEvent("pickle_airport:finishedMission", MissionIndex)
                else 
                    ShowNotification("Mission failed.")
                end
                StopMission()
            end)
        end
    else
        StopMission()
    end
end

function OpenMissionMenu(index)
    local menu_id = "airport_mission_menu"
    local options = {
        {label = "Passenger Flights", description = ""},
        {label = "Package Delivery", description = ""},
    }
    lib.registerMenu({
        id = menu_id,
        title = 'Aircraft Spawner',
        position = 'top-left',
        onClose = function(keyPressed)
            Interact = false
        end,
        options = options
    }, function(selected, scrollIndex, args)
        Interact = false
        if (selected == 1) then 
            StartMission("Passenger")
        elseif (selected == 2) then
            StartMission("Delivery")
        end
    end)

    lib.showMenu(menu_id)
end

if Config.MissionCommand then 
    RegisterCommand("pilotmission", function()
        if (PermissionCheck("pilot_mission")) then 
            StartMission()
        else
            ShowNotification(U.permission_denied)
        end
    end)
end

