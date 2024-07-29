AddEventHandler("OnPlayerBlind", function(event)
    local playerid = event:GetInt("attacker")
    local player = GetPlayer(playerid)
    if not player then return EventResult.Continue end

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "antiflash") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "antiflash") then
                local antiflash = exports["vipcore"]:GetFeatureValue(playerid, "antiflash") or false
                if player:IsFakeClient() then return EventResult.Continue end
                if antiflash then
                    NextTick(function()
                        if not player:CCSPlayerPawnBase():IsValid() then return end
                        player:CCSPlayerPawnBase().BlindUntilTime = server:GetCurrentTime()
                    end)
                end
            end
        end
    end

    return EventResult.Continue
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("antiflash", "vip_antiflash.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("antiflash")
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
    return "VIP - Anti Flash"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
