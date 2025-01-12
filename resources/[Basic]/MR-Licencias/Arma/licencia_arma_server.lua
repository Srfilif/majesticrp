local LicenciasArmas = {}

addEventHandler("onResourceStart", resourceRoot, function()
    for i, v in pairs(getLicenciaArmas()) do
        LicenciasArmas[i] = Marker(v[1], v[2], v[3] - 1, "cylinder", 1.5, 100, 100, 100, 0)
        LicenciasArmas[i]:setInterior(v.int)
        LicenciasArmas[i]:setDimension(v.dim)
    end
end)

addCommandHandler("portearma", function(player, cmd)
    if not notIsGuest(player) then
        if not player:isInVehicle() then
            for i, v in ipairs(LicenciasArmas) do
                if player:isWithinMarker(v) then
                    if 18 == 18 then
                        if player:getData("Nivel") >= 0 then
                            local licenciaarma = player:getData("Roleplay:Licencia_Arma") or 0
                            if licenciaarma == 0 then
                                if player:getMoney() >= 15000 then
                                    player:setData("Roleplay:Licencia_Arma", 1)
                                    player:outputChat(
                                        "#ffFFff* Acabas de obtener la licencia de armas por: #00ff00$15,000 #ffFFffdólares.",
                                        50, 150, 50, true)
                                    exports["[LS]Tiendas"]:setPlayerItem(player, "Licencia de Armas (Clase A)", 1)
                                    player:takeMoney(15000)
                                else
                                    player:outputChat("#ff3d3d* No tienes suficiente dinero para adquirir esto.", 50,
                                        150, 50, true)

                                end
                            else
                                player:outputChat("#ff3d3d* Ya tienes una licencia de armas (Tipo A).", 50, 150, 50,
                                    true)
                                player:outputChat(
                                    "#ffFFffPara una licencia de un rango superior deberas buscar a #3d3dffpolicial .",
                                    50, 150, 50, true)

                            end

                        else
                            player:outputChat("#ff3d3d* No tienes el nivel sufiente para adquirir esto (Se requiere Nivel 10).", 50, 150, 50,
                                    true)
                        end
                    else
						player:outputChat("#ff3d3d* Tu personaje no tiene la edad suficiente para comprar esto (Edad minima 18 Años).", 50, 150, 50,
						true)
                    end
                end
            end
        end
    end
end)

