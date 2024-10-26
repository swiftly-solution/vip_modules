function FindPlayerByPointer(ptr)
    for i = 1, playermanager:GetPlayerCap() do
        local player = GetPlayer(i - 1)
        if player then
            if not player:IsFakeClient() then
                if player:CBaseEntity():ToPtr() == ptr then
                    return player
                end
            end
        end
    end
    return nil
end


AddEventHandler("OnEntitySpawned", function(event --[[ Event ]], entityptr --[[ string ]])

        local entityInstance = CEntityInstance(entityptr)
        local entityBase = CBaseEntity(entityInstance:ToPtr())

        if entityInstance == nil or not entityInstance:IsValid() then
            return EventResult.Continue
        end
        if entityBase == nil or not entityBase:IsValid() then
            return EventResult.Continue
        end

        if entityInstance.Entity.DesignerName == "smokegrenade_projectile" then
        local player = FindPlayerByPointer(CBaseEntity(entityptr).OwnerEntity:ToPtr())
            if not player then
                return
            end
            local playerid = player:GetSlot()
            if GetPluginState("vipcore") == PluginState_t.Started then
                if exports["vipcore"]:HasFeature(playerid, "smokecolor") then
                    if exports["vipcore"]:IsFeatureEnabled(playerid, "smokecolor") then
                        local smokecolor = exports["vipcore"]:GetFeatureValue(playerid, "smokecolor")
                        if player:IsFakeClient() then
                            return
                        end

                        if entityInstance.Entity.DesignerName ~= "smokegrenade_projectile" then
                            return EventResult.Continue
                        end

                        local entitySmokeProjectile = CSmokeGrenadeProjectile(entityBase:EHandle():ToPtr())

                        if entitySmokeProjectile == nil or not entitySmokeProjectile:IsValid() then
                            return EventResult.Continue
                        end
                        NextTick(
                            function()
                                local colors = string.split(smokecolor, ",")
                                entitySmokeProjectile.SmokeColor =
                                    Vector(
                                    (tonumber(colors[1]) or 255) + 0.0,
                                    (tonumber(colors[2]) or 255) + 0.0,
                                    (tonumber(colors[3]) or 255) + 0.0
                                )
                            end
                        )
                        return EventResult.Continue
                    end
                end
            end
        end
    end
)

AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("smokecolor", "vip_smokecolor.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("smokecolor")
    end
    return EventResult.Continue
end)
