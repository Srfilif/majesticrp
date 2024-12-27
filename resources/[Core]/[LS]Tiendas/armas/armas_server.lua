addEventHandler("onResourceStart", resourceRoot, function()
    for index, valores in pairs(ammunations) do
        local p = createPickup(valores.x, valores.y, valores.z, 3, 2061, 0)

        setElementData(p, "pickup.type", "infoshops")
        setElementData(p, "pickup.infoshops", index)
        setElementInterior(p, valores.int)
        setElementDimension(p, valores.dim)
        setElementData(p, "pickup.tableinfo", ArmasTable)


        -- Evento de interacción con el pickup
        addEventHandler("onPickupHit", p, function(hitElement)
            if isElement(hitElement) and hitElement:getType() == "player" and not hitElement:isInVehicle() then
                bindKey(hitElement, "F", "down", function()
                    OpenWindowArmas(hitElement, valores.nombre)
                end)
                hitElement:setData("PickupData", source)
            end
        end)

        -- Evento de dejar el pickup
        addEventHandler("onPickupLeave", p, function(hitElement)
            if isElement(hitElement) and hitElement:getType() == "player" and not hitElement:isInVehicle() then
                unbindKey(hitElement, "F", "down")
                hitElement:setData("PickupData", nil)
            end
        end)
    end
end)

function OpenWindowArmas(player, nombre)
    if isElement(player) and not player:isInVehicle() then
        local coldat = player:getData("PickupData")
        if isElement(coldat) then
            local infos = coldat:getData("pickup.tableinfo")
            triggerClientEvent(player, "abrirVen", player, nombre)
            print("Ventana abierta para", nombre)
        end
    end
end











function giveArma(player, id, balas, precio, name, tipoLicencia)
    local licencia = getElementData(player, "Roleplay:Licencia_Arma")
    if licencia then
        if licencia >= tipoLicencia then
            local slot = getSlotFromWeapon(id)
            local currentWeapon = getPedWeapon(player, slot)

            if currentWeapon ~= id and currentWeapon ~= 0 then
                outputChatBox("#ff3d3dYa tienes un arma diferente en este slot.", player, 255, 0, 0, true)
            else
                giveWeapon(player, id, balas)
                takePlayerMoney(player, precio)
                outputChatBox("#00ff00" .. name .. " entregada satisfactoriamente por $" .. precio .. ".", player, 255, 255, 255, true)
                triggerClientEvent("[LS]Tiendas:SDinero", player)
            end
        else
            outputChatBox("#ff3d3dNecesitas una licencia de armas Tipo " .. string.char(64 + tipoLicencia) .. " para comprar esto.", player, 255, 255, 255, true)
        end
    else
        outputChatBox("#ff3d3dNo tienes licencia de armas.", player, 255, 0, 0, true)
    end
end

addEvent("darArma", true)
addEventHandler("darArma", root, function(player, id, balas, precio, name, tipoLicencia)
    giveArma(player, id, balas, precio, name, tipoLicencia)
end)







