addEvent("TiendaRopa:DarSkin", true)
addEventHandler("TiendaRopa:DarSkin", root,
    function(model, money)
        takePlayerMoney(source, money)
        --
    --    setElementData(source, "Skin", model);
        setElementModel(source, model)
        outputChatBox("#ffFFff* Has comprado la skin por #00ff00$" .. money.." #ffFFff.",source, 0, 255, 0,true)

	end
)

addEventHandler("onResourceStart", resourceRoot, function()
    for index, valores in pairs(tiendasropa) do
        local p = createPickup(valores.x, valores.y, valores.z, 3, 1275, 0)

        setElementData(p, "pickup.type", "infoshops")
        
        setElementData(p, "pickup.infoshops", valores.nombre)
        setElementInterior(p, valores.int)
        setElementDimension(p, valores.dim)


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
            triggerClientEvent(player, "[LS]Tiendas:Ropa", player, nombre)
        end
    end
end

















