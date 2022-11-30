local Flights = {}
GlobalState.Flights = Flights

function UpdateFlights()
    GlobalState.Flights = Flights
end

RegisterCallback("pickle_airport:startFlight", function(source, cb, index, flight_info)
    if (Flights[index]) then 
        cb(false)
        return
    else
        if PermissionCheck(source, "flight") then 
            Flights[index] = flight_info
            Flights[index].source = source
            UpdateFlights()
            cb(Flights[index])
            SetTimeout(1000 * Config.AirportSettings.DepartureTime, function()
                Flights[index] = nil
                UpdateFlights()
            end)
        else
            cb(false)
            return
        end
    end
end)

RegisterCallback("pickle_airport:startNPCFlight", function(source, cb, index)
    if (Config.AirportSettings.NPCFlightCost and Search(source, "money") - Config.AirportSettings.NPCFlightCost >= 0) then 
        RemoveItem(source, "money", Config.AirportSettings.NPCFlightCost)
        cb(true)
        return
    else
        cb(false)
        return
    end
end)

RegisterCallback("pickle_airport:purchaseTicket", function(source, cb, index)
    if (Flights[index] and Search(source, "money") - Flights[index].price >= 0) then 
        RemoveItem(source, "money", Flights[index].price)
        cb(true)
        return
    else
        cb(false)
        return
    end
end)


RegisterNetEvent("pickle_airport:returnPassengers", function(index, passengers)
    local source = source
    if PermissionCheck(source, "flight") then 
        for i=1, #passengers do 
            TriggerClientEvent("pickle_airport:returnBoarding", passengers[i], index)
        end
    end
end)