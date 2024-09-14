AddEventHandler("OnPostPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end

    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["weapon_restrictor"]:SetPlayerImmunity(playerid, false)
        if exports["vipcore"]:HasFeature(playerid, "weapon_restrict") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "weapon_restrict") then
                exports["weapon_restrictor"]:SetPlayerImmunity(playerid, true)
            end
        end
    end
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("weapon_restrict", "vip_weapon_restrict.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("weapon_restrict")
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
    return "VIP - Bunny Hop"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
