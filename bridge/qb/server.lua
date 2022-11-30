if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function RegisterCallback(name, cb)
    QBCore.Functions.CreateCallback(name, cb)
end

function ShowNotification(target, text)
	TriggerClientEvent(GetCurrentResourceName()..":showNotification", target, text)
end

function Search(source, name)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if name ~= "money" then 
        local item = xPlayer.Functions.GetItemByName(name)
        if item ~= nil then 
            return item.amount
        else
            return 0
        end
    else
        return xPlayer.PlayerData.money['cash']
    end
end

function AddItem(source, name, amount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if name == "money" then 
        return xPlayer.Functions.AddMoney("cash", amount)
    else
        return xPlayer.Functions.AddItem(name, amount)
    end
end

function RemoveItem(source, name, amount)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if name == "money" then 
        return xPlayer.Functions.RemoveMoney("cash", amount)
    else
        return xPlayer.Functions.RemoveItem(name, amount)
    end
end

function CanCarryItem(source, name, amount)
    return true -- No function for this.
end

function RegisterUsableItem(...)
    QBCore.Functions.CreateUseableItem(...)
end

function PermissionCheck(source, perm)
    local job = QBCore.Functions.GetPlayer(source).job
    if (perm == "flight") then 
        return (job.name == "airport")
    elseif (perm == "pilot_mission") then 
        return (job.name == "airport")
    end
end