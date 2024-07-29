AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "healthshot") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "healthshot") then
                local healthshot = tonumber(exports["vipcore"]:GetFeatureValue(playerid, "healthshot"))
                if type(healthshot) ~= "number" then healthshot = tonumber(healthshot) end
                if player:IsFakeClient() then return EventResult.Continue end
                NextTick(function()
                    for i = 1, healthshot do
                        player:GetWeaponManager():GiveWeapon("weapon_healthshot")
                    end
                end)
            end
        end
    end
    return EventResult.Continue
end)


AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("healthshot", "vip_healthshot.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("healthshot")
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
    return "VIP - Healthshot"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
