AddEventHandler("OnPlayerDeath", function(event)
    local attackerid = event:GetInt("attacker")
    local attacker = GetPlayer(attackerid)

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(attackerid, "regenarmor") then
            if exports["vipcore"]:IsFeatureEnabled(attackerid, "regenarmor") then
                local regenarmor = tonumber(exports["vipcore"]:GetFeatureValue(attackerid, "regenarmor"))
                if type(regenarmor) ~= "number" then regenarmor = tonumber(regenarmor) end
                if not attacker then return end
                if attacker:IsFakeClient() then return end

                if not attacker:CCSPlayerPawn():IsValid() then return end
                local currentArmor = attacker:CCSPlayerPawn().ArmorValue
                if currentArmor >= 100 then return end

                attacker:CCSPlayerPawn().ArmorValue = currentArmor + regenarmor
            end
        end
    end
    return EventResult.Continue
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("regenarmor", "vip_regenarmor.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("regenarmor")
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
    return "VIP - Regenerate Armor"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
