function AbrirV(nombre)
    if Panel then
        destroyElement(Panel)
        Panel = nil
        showCursor(false)
    else
        ammu(nombre)
        showCursor(true)
    end
end
addEvent("abrirVen", true)
addEventHandler("abrirVen", root, AbrirV)






local function OpenWindWeapon(player)
    if not player:isInVehicle() then
        player:triggerEvent("Armas:setWindow", player)
    end
end

function ammu(nombre)
    
    local screenW, screenH = guiGetScreenSize()
    -- Asumiendo que solo tienes un Ammu-Nation en la tabla por ahora
    local selectedAmmu = ammunations[1] -- O el índice que corresponda
    Panel = guiCreateWindow((screenW - 509) / 2, (screenH - 460) / 2, 509, 460, nombre, false)
    guiWindowSetSizable(Panel, false)

    label1 = guiCreateLabel(0, 18, 504, 25, "Haz doble clic sobre el objeto que quieras comprar", false, Panel)
    guiSetFont(label1, "clear-normal")
    guiLabelSetHorizontalAlign(label1, "center", false)
    guiLabelSetVerticalAlign(label1, "center")
    grillist1 = guiCreateGridList(9, 57, 490, 363, false, Panel)
    guiGridListAddColumn(grillist1, "Objeto", 0.3)
    guiGridListAddColumn(grillist1, "Precio", 0.3)
    guiGridListAddColumn(grillist1, "Descripcion", 0.3)
    for i, arma in ipairs(ArmasTable) do
        guiGridListAddRow(grillist1)
        guiGridListSetItemText(grillist1, i - 1, 1, arma[2], false, false)
        guiGridListSetItemText(grillist1, i - 1, 2, "$" .. arma[3], false, false)
        guiGridListSetItemText(grillist1, i - 1, 3, arma[4], false, false)
    end
    guiGridListSetSortingEnabled ( grillist1, false )

    BotonCerrar = guiCreateButton(87, 430, 333, 20, "Cerrar", false, Panel)    
    addEventHandler("onClientGUIClick", BotonCerrar, AbrirV, false)

    addEventHandler("onClientGUIDoubleClick", grillist1, comprarGUI, false)
    showCursor(true)
end
function comprarGUI()
    local selectedItem = guiGridListGetSelectedItem(grillist1)
    if not selectedItem or selectedItem == -1 then
        outputChatBox("#ff3d3dPrimero selecciona el arma que deseas comprar.", 255, 0, 0, true)
        return
    end

    selectedItem = selectedItem + 1 -- Ajuste por índice de GUI
    local armaData = ArmasTable[selectedItem]
    local dineroJugador = getPlayerMoney(localPlayer)

    if not armaData then
        outputChatBox("#ff3d3dItem no válido.", 255, 0, 0, true)
        return
    end

    local precio = armaData[3]
    local idArma = armaData[1]
    local balas = armaData[5]
    local name = armaData[2]

    if dineroJugador < precio then
        outputChatBox("#ff3d3d¡No tienes suficiente dinero para comprar esto!", 255, 0, 0, true)
        return
    end

    if idArma == 0 then
        -- Comprar chaleco
        local armor = getPedArmor(localPlayer) or 0
        if armor >= 100 then
            outputChatBox("#ff3d3d* Ya tienes un chaleco, ¡no puedes llevar más!", 255, 255, 255, true)
        else
            setPedArmor(localPlayer, math.min(armor + balas, 100))
            takePlayerMoney(precio)
            outputChatBox("#00ff00Chaleco entregado satisfactoriamente.", 255, 255, 255, true)
        end
    else
        -- Comprar arma
        local tipoLicencia = getTipoLicencia(idArma)
        if tipoLicencia then
            triggerServerEvent("darArma", resourceRoot, localPlayer, idArma, balas, precio, name, tipoLicencia)
        else
            outputChatBox("#ff3d3dArma no válida.", 255, 0, 0, true)
        end
    end
end

function getTipoLicencia(idArma)
    if idArma == 22 or idArma == 24 then
        return 1
    elseif idArma == 25 or idArma == 33 then
        return 2
    elseif idArma == 29 or idArma == 31 then
        return 3
    end
    return nil
end



addEvent("[LS]Tiendas:SDinero", true)
addEventHandler("[LS]Tiendas:SDinero", localPlayer,
function()
    local sound = playSound("dinero.mp3")
    setSoundVolume(sound, 1)
end)
