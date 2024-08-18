AddEventHandler("OnBulletImpact", function(event)
    local playerid = event:GetInt("userid")
    local player = GetPlayer(playerid)
    if GetPluginState("vipcore") == PluginState_t.Started then
        if exports["vipcore"]:HasFeature(playerid, "tracercolor") then
            if exports["vipcore"]:IsFeatureEnabled(playerid, "tracercolor") then
                local tracer = tostring(exports["vipcore"]:GetFeatureValue(playerid, "tracercolor"))
                if type(tracer) ~= "string" then tracer = tostring(tracer) end
                if player:IsFakeClient() then return EventResult.Continue end
                if not player then return EventResult.Continue end


                local beamModel = "particles/ui/status_levels/ui_status_level_8_energycirc.vpcf"

                local beam = CBeam(CreateEntityByName("beam"):ToPtr())
                if not beam:IsValid() then return end

                CBaseModelEntity(beam:ToPtr()):SetModel(beamModel)

                local acceptInputValue = "Start"

                local baseentity = CBaseEntity(beam:ToPtr())
                baseentity:Spawn()
                baseentity:AcceptInput(acceptInputValue, CEntityInstance("0x0"), CEntityInstance("0x0"), "", 0)

                local playerCBaseEntity = CBaseEntity(player:CCSPlayerPawn():ToPtr())
                if not playerCBaseEntity:IsValid() then return end

                local playerCoords = playerCBaseEntity.CBodyComponent.SceneNode.AbsOrigin
                local cameraService = player:CBasePlayerPawn().CameraServices

                local eyePosition = Vector(playerCoords.x, playerCoords.y, playerCoords.z + cameraService.OldPlayerViewOffsetZ)

                baseentity:Teleport(eyePosition)

                beam.EndPos = Vector(event:GetFloat("x"), event:GetFloat("y"), event:GetFloat("z"))

                local colors = string.split(tracer, ",")
                local colorObj = Color(colors[1], colors[2], colors[3], colors[4])
                beam.Parent.Render = colorObj

                local lifetime = 500

                SetTimeout(lifetime, function()
                    if baseentity and baseentity:IsValid() then
                        baseentity:Despawn()
                    end
                end)

            end
        end
    end
    return EventResult.Continue
end)


AddEventHandler("OnAllPluginsLoaded", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:RegisterFeature("tracercolor", "vip_tracers.title")
    end
    return EventResult.Continue
end)

AddEventHandler("OnPluginStop", function(event)
    if GetPluginState("vipcore") == PluginState_t.Started then
        exports["vipcore"]:UnregisterFeature("tracercolor")
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
    return "VIP - Tracers"
end

function GetPluginWebsite()
    return "https://github.com/swiftly-solution/vip_modules"
end
