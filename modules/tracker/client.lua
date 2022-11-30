TrackedAircraft = {}

function GetCurrentAircraft()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if (vehicle and GetPedInVehicleSeat(vehicle, -1) == ped) then
        if (IsPedInAnyPlane(ped)) then 
            return vehicle, 1
        elseif (IsPedInAnyHeli(ped)) then 
            return vehicle, 2
        end
    end
end

function UpdateClientTracker(source, data)
    if (TrackedAircraft[source] and TrackedAircraft[source].blip) then 
        RemoveBlip(TrackedAircraft[source].blip)
    end
    if (data) then 
        TrackedAircraft[source] = data
        
        local info = Config.Tracker.BlipTypes[data.aircraftType]
            
        if (PermissionCheck("view_tracker")) then 
            TrackedAircraft[source].blip = CreateBlip({
                Location = data.coords,
                Rotation = data.heading,
                Label = info.Label,
                ID = info.ID,
                Scale = info.Scale,
                Color = info.Color
            })
        end
    else
        TrackedAircraft[source] = nil
    end
end

CreateThread(function()
    while true do 
        local wait = 1000 * Config.Tracker.UpdateTime
        local vehicle, aircraftType = GetCurrentAircraft()
        if vehicle then 
            local coords = GetEntityCoords(vehicle)
            local heading = GetEntityHeading(vehicle)
            TriggerServerEvent("pickle_airport:tracker:updateAircraft", {coords = coords, heading = heading, aircraftType = aircraftType})
        elseif TrackedAircraft[GetPlayerServerId(PlayerId())] then
            TriggerServerEvent("pickle_airport:tracker:updateAircraft", nil)
        end
        Wait(wait)
    end
end)

RegisterNetEvent("pickle_airport:tracker:receiveAircraftUpdate", function(source, data)
    UpdateClientTracker(source, data)
end)