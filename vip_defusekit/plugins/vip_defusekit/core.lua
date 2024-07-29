AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "defusekit") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "defusekit") then
                if player:IsFakeClient() then return EventResult.Continue end
                if not IsPistolRound() then
                    NextTick(function()
                        if not player:CBaseEntity():IsValid() then return end
                        if player:CBaseEntity().TeamNum == Team.CT then
                            player:GetWeaponManager():GiveWeapon("item_defuser")
                        end
                    end)
                end
            end
        end
    end
    return EventResult.Continue
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("defusekit", "vip_defusekit.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("defusekit")
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
    return "VIP - Defusekit"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
