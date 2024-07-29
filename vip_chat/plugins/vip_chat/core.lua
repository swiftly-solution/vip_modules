local playerData = {}

AddEventHandler("OnPlayerSpawn", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end
    if player:IsFakeClient() then return end
    if not playerData[playerid] then playerData[playerid] = {} end

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "chattag") then
            local chattag = tostring(exports["vipcore"]:GetFeatureValue(playerid, "chattag"))
            if type(chattag) ~= "string" then chattag = tostring(chattag) end

            if exports["vipcore"]:IsFeatureEnabled(playerid, "chattag") then
                if chattag ~= player:GetChatTag() then playerData[playerid].chattag = player:GetChatTag() end
                player:SetChatTag(chattag)
            else
                if player:GetChatTag() == chattag then
                    player:SetChatTag(playerData[playerid].chattag)
                end
            end
        end

        if exports["vipcore"]:HasFeature(playerid, "chattagcolor") then
            local chattagcolor = tostring(exports["vipcore"]:GetFeatureValue(playerid, "chattagcolor"))
            if type(chattagcolor) ~= "string" then chattagcolor = tostring(chattagcolor) end

            if exports["vipcore"]:IsFeatureEnabled(playerid, "chattagcolor") then
                if chattagcolor ~= player:GetChatTagColor() then
                    playerData[playerid].chattagcolor = player:GetChatTagColor()
                end
                player:SetChatTagColor(chattagcolor)
            else
                if player:GetChatTagColor() == chattagcolor then
                    player:SetChatTagColor(playerData[playerid].chattagcolor)
                end
            end
        end

        if exports["vipcore"]:HasFeature(playerid, "chatnamecolor") then
            local chatnamecolor = tostring(exports["vipcore"]:GetFeatureValue(playerid, "chatnamecolor"))
            if type(chatnamecolor) ~= "string" then chatnamecolor = tostring(chatnamecolor) end

            if exports["vipcore"]:IsFeatureEnabled(playerid, "chatnamecolor") then
                if chatnamecolor ~= player:GetNameColor() then playerData[playerid].chatnamecolor = player:GetNameColor() end
                player:SetNameColor(chatnamecolor)
            else
                if player:GetNameColor() == chatnamecolor then
                    player:SetNameColor(playerData[playerid].chatnamecolor)
                end
            end
        end

        if exports["vipcore"]:HasFeature(playerid, "chattextcolor") then
            local chattextcolor = tostring(exports["vipcore"]:GetFeatureValue(playerid, "chattextcolor"))
            if type(chattextcolor) ~= "string" then chattextcolor = tostring(chattextcolor) end

            if exports["vipcore"]:IsFeatureEnabled(playerid, "chattextcolor") then
                if chattextcolor ~= player:GetChatColor() then playerData[playerid].chattextcolor = player:GetChatColor() end
                player:SetChatColor(chattextcolor)
            else
                if player:GetChatColor() == chattextcolor then
                    player:SetChatColor(playerData[playerid].chattextcolor)
                end
            end
        end
    end
    return EventResult.Continue
end)

AddEventHandler("OnClientDisconnect", function(event, playerid)
    playerData[playerid] = nil
end)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("chattag", "vip_chat.chattag")
        exports["vipcore"]:RegisterFeature("chattagcolor", "vip_chat.chattagcolor")
        exports["vipcore"]:RegisterFeature("chatnamecolor", "vip_chat.chatnamecolor")
        exports["vipcore"]:RegisterFeature("chattextcolor", "vip_chat.chattextcolor")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("chat")
        exports["vipcore"]:UnregisterFeature("chattag")
        exports["vipcore"]:UnregisterFeature("chattagcolor")
        exports["vipcore"]:UnregisterFeature("chatnamecolor")
        exports["vipcore"]:UnregisterFeature("chattextcolor")
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
    return "VIP - Chat"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
