AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "gravity") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "gravity") then
                local gravity = tonumber(exports["vipcore"]:GetFeatureValue(playerid, "gravity"))
                if type(gravity) ~= "number" then gravity = tonumber(gravity) end
                if player:IsFakeClient() then return EventResult.Continue end
                NextTick(function()
                    if not player:CCSPlayerPawn():IsValid() then return end
                    CBaseEntity(player:CCSPlayerPawn():ToPtr()).GravityScale = (gravity or 1.0)
                end)
            end
        end
    end
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("gravity", "vip_gravity.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("gravity")
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
    return "VIP - Gravity"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
