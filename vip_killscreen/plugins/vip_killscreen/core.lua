AddEventHandler("OnPlayerDeath", function(event)
    local attackerid = event:GetInt("attacker")
    local attacker = GetPlayer(attackerid)

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(attackerid, "killscreen") then
            if exports["vipcore"]:IsFeatureEnabled(attackerid, "killscreen") then
                local killscreen = tonumber(exports["vipcore"]:GetFeatureValue(attackerid, "killscreen"))
                if type(killscreen) ~= "number" then killscreen = tonumber(killscreen) end
                if not attacker then return end
                if attacker:IsFakeClient() then return end

                if not attacker:CCSPlayerPawn():IsValid() then return end
                attacker:CCSPlayerPawn().HealthShotBoostExpirationTime = server:GetCurrentTime() + 1
            end
        end
    end
    return EventResult.Continue
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("killscreen", "vip_killscreen.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("killscreen")
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
    return "VIP - Killscreen"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
