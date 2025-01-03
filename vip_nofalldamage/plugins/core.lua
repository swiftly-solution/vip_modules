AddEventHandler("OnPlayerDamage", function (event, playerid, attackerid, damageinfo_ptr, inflictor_ptr, ability_ptr)
    local player = GetPlayer(playerid)
    if not player or not player:IsValid() then return end
    if player:IsFakeClient() then return end

    local damage = CTakeDamageInfo(damageinfo_ptr)
    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "nofalldamage") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "nofalldamage") then
                if damage.BitsDamageType & DamageTypes_t.DMG_FALL == DamageTypes_t.DMG_FALL then
                    event:SetReturn(false)
                end
            end 
        end
    end
end)


AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("nofalldamage", "vip_nofalldamage.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("nofalldamage")
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
    return "VIP - No Fall Damage"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end