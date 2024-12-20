AddEventHandler("OnPostPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "bhop") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "bhop") then
                playerutils:SetBunnyhop(playerid, exports["vipcore"]:GetFeatureValue(playerid, "bhop"))
            end
        end
    end
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("bhop", "vip_bhop.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("bhop")
    end
    return EventResult.Continue
end)

function GetPluginAuthor()
    return "Swiftly Solution"
end

function GetPluginVersion()
    return "v1.0.1"
end

function GetPluginName()
    return "VIP - Bunny Hop"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
