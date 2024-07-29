AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "money") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "money") then
                local money = tonumber(exports["vipcore"]:GetFeatureValue(playerid, "money"))
                if type(money) ~= "number" then money = tonumber(money) end
                if player:IsFakeClient() then return EventResult.Continue end
                if not IsPistolRound() then
                    NextTick(function()
                        if not player:CCSPlayerController():IsValid() then return end
                        player:CCSPlayerController().InGameMoneyServices.Account = player:CCSPlayerController()
                            .InGameMoneyServices.Account + money
                    end)
                end
            end
        end
    end
    return EventResult.Continue
end)


AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("money", "vip_money.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("money")
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
    return "VIP - Money"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
