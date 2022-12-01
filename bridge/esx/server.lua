if GetResourceState('es_extended') ~= 'started' then return end

ESX = exports.es_extended:getSharedObject()

function RegisterCallback(name, cb)
    ESX.RegisterServerCallback(name, cb)
end

function ShowNotification(target, text)
	TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text)
end

function Search(source, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    if (name ~= "money") then
        local item = xPlayer.getInventoryItem(name)
        if item ~= nil then 
            return item.count
        else
            return 0
        end
    else
        return xPlayer.getMoney()
    end
end

function AddItem(source, name, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if name == "money" then 
        return xPlayer.addMoney(amount)
    else
        return xPlayer.addInventoryItem(name, amount)
    end
end

function RemoveItem(source, name, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if name == "money" then 
        return xPlayer.removeMoney(amount)
    else
        return xPlayer.removeInventoryItem(name, amount)
    end
end

function RegisterUsableItem(...)
    ESX.RegisterUsableItem(...)
end

function PermissionCheck(source, perm)
    local job = ESX.GetPlayerFromId(source).job
    if (perm == "flight") then 
        return (job.name == "airport")
    elseif (perm == "pilot_mission") then 
        return (job.name == "airport")
    end
end