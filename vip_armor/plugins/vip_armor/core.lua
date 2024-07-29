AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "armor") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "armor") then
                local armor = tonumber(exports["vipcore"]:GetFeatureValue(playerid, "armor")) or 100
                if player:IsFakeClient() then return EventResult.Continue end
                if not IsPistolRound() then
                    NextTick(function()
                        if not player:CBaseEntity():IsValid() then return end
                        player:CCSPlayerPawn().ArmorValue = armor
                        CCSPlayer_ItemServices(player:CBasePlayerPawn().ItemServices:ToPtr()).HasHelmet = true
                    end)
                end
            end
        end
    end
    return EventResult.Continue
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("armor", "vip_armor.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("armor")
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
    return "VIP - Armor"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
