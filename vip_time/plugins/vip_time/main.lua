local isviptime = false

SetTimeout(60000, function ()
    local now = os.time()
    local hours = os.date("*t",now)["hour"]
    local mins = os.date("*t",now)["min"]

    if hours >= config:Fetch("vip-time.start") and hours <= config:Fetch("vip-time.end") then
        isviptime = true
    else
        isviptime = false
    end

end)

AddEventHandler("OnPlayerSpawn", function (event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if not player then return end
    if not player:IsValid() then return end
    if player:IsFakeClient() then return end

    if player:GetVar("vip.group") == "none" and isviptime == true then
        server:Execute("sw_addvip \""..player:GetSteamID().."\" \""..config:Fetch("vip-time.group").."\" 7200")
        return ReplyToCommand(playerid, config:Fetch("vips.prefix"), FetchTranslation("vip-time.gotvip"))
    end

    if player:GetVar("vip.group") == config:Fetch("vip-time.group") and isviptime == false then
        return server:Execute("sw_removevip \""..player:GetSteamID().."\"")
    end

end)