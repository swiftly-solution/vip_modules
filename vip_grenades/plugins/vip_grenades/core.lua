AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "grenades") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "grenades") then
                local grenades = tonumber(exports["vipcore"]:GetFeatureValue(playerid, "grenades"))
                if player:IsFakeClient() then return EventResult.Continue end
                NextTick(function()
                    player:GetWeaponManager():GiveWeapon("weapon_hegrenade")
                    player:GetWeaponManager():GiveWeapon("weapon_flashbang")
                    player:GetWeaponManager():GiveWeapon("weapon_smokegrenade")
                    player:GetWeaponManager():GiveWeapon("weapon_molotov")
                end)
            end
        end
    end
    return EventResult.Continue
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("grenades", "vip_grenades.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("grenades")
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
    return "VIP - Grenades"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
