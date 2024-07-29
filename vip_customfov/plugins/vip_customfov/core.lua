AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "fov") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "fov") then
                local fov = tonumber(exports["vipcore"]:GetFeatureValue(playerid, "fov"))
                if type(fov) ~= "number" then fov = tonumber(fov) end
                if player:IsFakeClient() then return EventResult.Continue end
                NextTick(function()
                    if not player:CBasePlayerController():IsValid() then return end
                    player:CBasePlayerController().DesiredFOV = (fov or 90.0)
                end)
            end
        end
    end
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("fov", "vip_fov.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("fov")
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
    return "VIP - Custom FOV"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
