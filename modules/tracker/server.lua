TrackedAircraft = {}

function UpdateTracker(source, data)
    if (data) then 
        TrackedAircraft[source] = data
    else
        TrackedAircraft[source] = nil
    end
    TriggerClientEvent("pickle_airport:tracker:receiveAircraftUpdate", -1, source, TrackedAircraft[source])
end

RegisterNetEvent("pickle_airport:tracker:updateAircraft", function(data) 
    local source = source
    UpdateTracker(source, data)
end)