local mapEnabled = {
    ["headshot"] = { func = "SetBool", arg = "headshot", value = true },
    ["thrusmoke"] = { func = "SetBool", arg = "thrusmoke", value = true },
    ["noscope"] = { func = "SetBool", arg = "noscope", value = true },
    ["blind"] = { func = "SetBool", arg = "attackerblind", value = true },
    ["inair"] = { func = "SetBool", arg = "attackerinair", value = true },
    ["wipe"] = { func = "SetInt", arg = "wipe", value = 1 },
    ["dominated"] = { func = "SetInt", arg = "dominated", value = 1 },
    ["revenge"] = { func = "SetInt", arg = "revenge", value = 1 },
}

AddEventHandler("OnPlayerDeath", function(event)
    local playerid = event:GetInt("attacker")
    local player = GetPlayer(playerid)
    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "killfeed") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "killfeed") then
                local killfeed = tostring(exports["vipcore"]:GetFeatureValue(playerid, "killfeed"))
                if player:IsFakeClient() then return EventResult.Continue end
                local killfeedobj = string.split(killfeed, ",")
                for i = 1, #killfeedobj do
                    local enabled = killfeedobj[i]
                    if mapEnabled[enabled] then
                        event[mapEnabled[enabled].func](event, mapEnabled[enabled].arg, mapEnabled[enabled].value)
                    end
                end
            end
        end
    end
    return EventResult.Continue
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("killfeed", "vip_killfeed.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("killfeed")
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
    return "VIP - killfeed"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end