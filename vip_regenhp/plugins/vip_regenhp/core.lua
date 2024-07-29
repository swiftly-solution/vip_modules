AddEventHandler("OnPlayerDeath", function(event)
    local attackerid = event:GetInt("attacker")
    local attacker = GetPlayer(attackerid)

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(attackerid, "regenhealth") then
            if exports["vipcore"]:IsFeatureEnabled(attackerid, "regenhealth") then
                local regenhealth = tonumber(exports["vipcore"]:GetFeatureValue(attackerid, "regenhealth"))
                if type(regenhealth) ~= "number" then regenhealth = tonumber(regenhealth) end
                if not attacker then return end
                if attacker:IsFakeClient() then return end

                if not attacker:CBaseEntity():IsValid() then return end
                local currentHealth = attacker:CBaseEntity().Health
                if currentHealth >= 98 then return end

                attacker:CBaseEntity().Health = currentHealth + regenhealth
            end
        end
    end
    return EventResult.Continue
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("regenhealth", "vip_regenhealth.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("regenhealth")
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
    return "VIP - Regenerate Health"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
