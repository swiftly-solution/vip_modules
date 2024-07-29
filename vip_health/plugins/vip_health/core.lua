AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "health") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "health") then
                local health = tonumber(exports["vipcore"]:GetFeatureValue(playerid, "health")) or 100
                if player:IsFakeClient() then return EventResult.Continue end
                if not IsPistolRound() then
                    NextTick(function()
                        if not player:CBaseEntity():IsValid() then return end
                        player:CBaseEntity().Health = health
                    end)
                end
            end
        end
    end
    return EventResult.Continue
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("health", "vip_health.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("health")
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
    return "VIP - Health"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
