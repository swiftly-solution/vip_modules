AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "speed") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "speed") then
                local speed = tonumber(exports["vipcore"]:GetFeatureValue(playerid, "speed"))
                if type(speed) ~= "number" then speed = tonumber(speed) end
                if player:IsFakeClient() then return EventResult.Continue end
                NextTick(function()
                    if not player:CCSPlayerPawn():IsValid() then return end
                    player:CCSPlayerPawn().VelocityModifier = (speed or 1.0)
                end)
            end
        end
    end
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("speed", "vip_speed.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("speed")
    end
    return EventResult.Continue
end)


function GetPluginAuthor()
    return "Swiftly Solution"
end

function GetPluginVersion()
    return "v1.0.0"
end

function GetPluginName()
    return "VIP - Speed"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
