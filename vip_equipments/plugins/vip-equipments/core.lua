AddEventHandler("OnPostPlayerSpawn", function (event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)

    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "hats") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "hats") then
                local hats_path = exports["vipcore"]:GetFeatureValue(playerid, "hats")
                if type(hats_path) ~= "string" then hats_path = tostring(hats_path) end
                if player:IsFakeClient() then return EventResult.Continue end
                if not player then return EventResult.Continue end

                local entity_hat = CDynamicProp(CreateEntityByName("prop_dynamic_override"):ToPtr())
                if not entity_hat:IsValid() then return end
                local baseentitymodel = CBaseModelEntity(entity_hat:ToPtr())
                local baseentity = CBaseEntity(entity_hat:ToPtr())
                baseentitymodel:SetModel(hats_path)
                baseentity:Spawn()
                baseentity:AcceptInput("FollowEntity", CEntityInstance(player:CCSPlayerPawn():ToPtr()), CEntityInstance(player:CCSPlayerPawn():ToPtr()), "!activator", 0)

            end
        end
        if exports["vipcore"]:HasFeature(playerid, "backpacks") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "backpacks") then
                local backpack_path = tostring(exports["vipcore"]:GetFeatureValue(playerid, "backpacks"))
                if type(backpack_path) ~= "string" then backpack_path = tostring(backpack_path) end
                if player:IsFakeClient() then return EventResult.Continue end
                if not player then return EventResult.Continue end

                local entity_hat = CDynamicProp(CreateEntityByName("prop_dynamic_override"):ToPtr())
                if not entity_hat:IsValid() then return end
                local baseentitymodel = CBaseModelEntity(entity_hat:ToPtr())
                local baseentity = CBaseEntity(entity_hat:ToPtr())
                baseentitymodel:SetModel(backpack_path)
                baseentity:Spawn()
                baseentity:AcceptInput("FollowEntity", CEntityInstance(player:CCSPlayerPawn():ToPtr()), CEntityInstance(player:CCSPlayerPawn():ToPtr()), "!activator", 0)

            end
        end
    end
end)


AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("hats", "vip_equipments.title.hats")
        exports["vipcore"]:RegisterFeature("backpacks", "vip_equipments.title.backpacks")
    end

    Groups = config:Fetch("vips.groups")

    if Groups then
        for i = 1, #Groups do
            local group = Groups[i]

            if type(group.ToTable) == "function" then
                group = group:ToTable()
            end

            if group and group.features then
                precacher:PrecacheModel(group.features.hats)
                precacher:PrecacheModel(group.features.backpacks)
            end
        end
    end

    return EventResult.Continue
end)


AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("hats")
        exports["vipcore"]:UnregisterFeature("backpacks")
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
    return "VIP - Equipments"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end