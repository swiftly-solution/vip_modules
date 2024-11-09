AddEventHandler("OnAllPluginsLoaded", function (event)
    exports["cookies"]:RegisterCookie("UsedVIPTest", false)
end)

commands:Register("viptest", function (playerid, args, argc, silent, prefix)
    local player = GetPlayer(playerid)
    if not player then return end
    if player:IsFakeClient() then return end
    if not player:IsValid() then return end

    if player:GetVar("vip.group") ~= "none" then
        return ReplyToCommand(playerid, config:Fetch("vips.prefix"), FetchTranslation("vip-test.alreadyisvip"), playerid)
    end

    if exports["cookies"]:GetPlayerCookie(playerid, "UsedVIPTest") == true then
        return ReplyToCommand(playerid, config:Fetch("vips.prefix"), FetchTranslation("vip-test.alreadyuse"), playerid)
    end

    server:Execute("sw_addvip \"" .. player:GetSteamID() .. "\" \"" .. config:Fetch("vip-test.group") .. "\" \"" .. config:Fetch("vip-test.duration") .. "\"")
    exports["cookies"]:SetPlayerCookie(playerid, "UsedVIPTest", true)
    ReplyToCommand(playerid, config:Fetch("vips.prefix"), FetchTranslation("vip-test.receivedvip"):gsub("{HOURS}", ComputePrettyTime(config:Fetch("vip-test.duration"))), playerid)
end)
