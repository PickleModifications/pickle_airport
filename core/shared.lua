function lerp(a, b, t) return a + (b-a) * t end

function v3(coords) return vec3(coords.x, coords.y, coords.z), coords.w end

function dprint(...)
    if Config.Debug then 
        print(...)
    end
end

function GetRandomInt(min, max, skipNum)
    if min >= max then 
        return min
    else
        local num = math.random(min, max)
        if skipNum ~= nil and skipNum == num then 
            while skipNum == num do 
                num = math.random(min, max)
                Wait(0)
            end
        end
        return num
    end
end