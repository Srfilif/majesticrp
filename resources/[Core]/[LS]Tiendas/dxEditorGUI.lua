local Items = {}

addEventHandler("onClientResourceStart", resourceRoot, function()
    local screenW, screenH = guiGetScreenSize()

    wndInv =
        guiCreateWindow((screenW - 408) / 2, (screenH - 408) / 2, 408, 408, "Inventario - GreenWood Roleplay", false)
    guiWindowSetSizable(wndInv, false)
    guiSetVisible(wndInv, false)
    gridObj = guiCreateGridList(9, 53, 231, 347, false, wndInv)
    guiGridListAddColumn(gridObj, "Objecto", 0.6)
    guiGridListAddColumn(gridObj, "Cantidad", 0.3)
    botUsar = guiCreateButton(250, 53, 142, 21, "Utilizar", false, wndInv)
    labelinv = guiCreateLabel(10, 23, 388, 20, "¡Da click en el objeto para ver sus opciones!", false, wndInv)
    guiLabelSetHorizontalAlign(labelinv, "center", false)
    botTirar = guiCreateButton(250, 80, 142, 21, "Tirar", false, wndInv)
    btnpasar = guiCreateButton(250, 107, 142, 21, "Pasar", false, wndInv)
    btncerrar = guiCreateButton(250, 379, 142, 21, "Cerrar", false, wndInv)
    guiSetProperty(btncerrar, "NormalTextColour", "FFFF0000")
    btnaccorios = guiCreateButton(250, 138, 142, 21, "Accesorios", false, wndInv)

	personajesselector = guiCreateComboBox(250, 169, 142, 200, "", false, wndInv)

    -- Manejo del botón "Tirar"

	addEvent("Show:NearbyPlayersSelector", true)
addEventHandler("Show:NearbyPlayersSelector", root, function(playerList, itemName, itemAmount)
    -- Limpiar el ComboBox
    guiComboBoxClear(personajesselector)
    
    -- Llenar el ComboBox con jugadores cercanos
    for _, playerData in ipairs(playerList) do
        guiComboBoxAddItem(personajesselector, playerData.name)
        guiComboBoxSetItemData(personajesselector, guiComboBoxGetItemCount(personajesselector) - 1, playerData.element)
    end

    -- Mostrar el inventario con el selector actualizado
    guiSetVisible(wndInv, true)
end)

-- Lógica para el botón "Pasar"
addEventHandler("onClientGUIClick", btnpasar, function()
    local selectedRow = guiGridListGetSelectedItem(gridObj)
    if selectedRow and selectedRow ~= -1 then
        -- Obtener ítem seleccionado
        local itemName = guiGridListGetItemText(gridObj, selectedRow, 1)
        local itemAmount = tonumber(guiGridListGetItemText(gridObj, selectedRow, 2))

        if itemName and itemAmount and itemAmount > 0 then
            -- Obtener jugador seleccionado
            local selectedPlayer = guiComboBoxGetSelected(personajesselector)
            if selectedPlayer and selectedPlayer ~= -1 then
                local targetPlayer = guiComboBoxGetItemData(personajesselector, selectedPlayer)

                -- Enviar al servidor la solicitud para transferir el ítem
                triggerServerEvent("GiveItemToPlayer", localPlayer, targetPlayer, itemName, itemAmount)

                -- Cerrar el inventario
                guiSetVisible(wndInv, false)
            else
                outputChatBox("#ff3d3d* Selecciona un jugador de la lista.", 255, 0, 0,true)
            end
        else
            outputChatBox("#ff3d3d* Selecciona un ítem válido del inventario.", 255, 0, 0,true)
        end
    else
        outputChatBox("#ff3d3d* Selecciona un ítem del inventario.", 255, 0, 0,true)
    end
end, false)
    -- Tirar un ítem desde el inventario
    addEventHandler("onClientGUIClick", btncerrar, function()
        triggerEvent("Open:Inventory", localPlayer)
    end, true)
    addEventHandler("onClientGUIClick", botTirar, function()
        local selectedRow = guiGridListGetSelectedItem(gridObj)
        if selectedRow ~= -1 then
            local itemName = guiGridListGetItemText(gridObj, selectedRow, 1)
            local itemAmount = tonumber(guiGridListGetItemText(gridObj, selectedRow, 2))
            if itemName and itemAmount then
                triggerServerEvent("TiraItem:Inventory", localPlayer, itemName, itemAmount)
            else
                outputChatBox("#ff3d3d* Selecciona un ítem válido.", 255, 0, 0,true)
            end
        else
            outputChatBox("#ff3d3d* Selecciona un ítem para tirar.", 255, 0, 0,true)
        end
    end, false)

    -- Recoger un ítem con el comando
    addCommandHandler("recoger", function()
        triggerServerEvent("RecogerItem:Inventory", localPlayer)
    end)

end)

function colocarArmas(player)
    if isElement(player) then
        tablaArmas = {}
        local weaponSlots = {2, 3, 4, 5, 6, 7, 8, 9}
        for i, slot in ipairs(weaponSlots) do
            local ammo = getPedTotalAmmo(player, slot)
            if (getPedWeapon(player, slot) ~= 0) then
                local weapon = getPedWeapon(player, slot)
                local ammo = getPedTotalAmmo(player, slot)
                table.insert(tablaArmas, {weapon, ammo})
            end
        end
        for k, v in pairs(tablaArmas) do
            if v[1] > 0 then
                local row = guiGridListAddRow(gridObj)
                guiGridListSetItemText(gridObj, row, 1, getWeaponNameFromID(v[1]), false, false)
                guiGridListSetItemText(gridObj, row, 2, v[2], false, false)
            end
        end
    end
end

addEvent('Open:Inventory', true)
addEventHandler('Open:Inventory', getLocalPlayer(), function(t, rr)
    if not localPlayer:getData("EnEdicion") then
        if rr == 'refresh' then
            Items.refresh(t)
            return
        end
        if not guiGetVisible(wndInv) then
            guiSetVisible(wndInv, true)
            showCursor(true)
            Items.refresh(t)
        else
            guiSetVisible(wndInv, not true)
            showCursor(not true)
        end
    end
end)

-- localPlayer:setData('Items',false)

function Items.refresh(t)
    guiGridListClear(gridObj)
    if t then
        colocarArmas(localPlayer)
        for k, v in pairs(t) do
            local row = guiGridListAddRow(gridObj)
            guiGridListSetItemText(gridObj, row, 1, v.Item, false, false)
            guiGridListSetItemText(gridObj, row, 2, '' .. v.Value, false, false)
        end
    end
end

function Items.buttons(b)
    if (b ~= 'left') then
        return
    end
    if (source == botUsar) then
        local object, quantity = guiGridListGetItemText(gridObj, guiGridListGetSelectedItem(gridObj), 1),
            guiGridListGetItemText(gridObj, guiGridListGetSelectedItem(gridObj), 2)
        if object ~= "" and quantity ~= "" then
            triggerServerEvent('Refresh:Inventory', localPlayer, object, quantity)
            setEnabled(botUsar, 2000)

            if object == 'Bidon de Gasolina' then
                guiSetVisible(wndInv, not true)
                showCursor(not true)
            end
        end
    end
end
addEventHandler('onClientGUIClick', resourceRoot, Items.buttons)

addEventHandler("onClientRender", getRootElement(), function()
    for k, v in ipairs(getElementsByType("pickup")) do
        local pick = v:getData("pickup.infoshops")
        if pick then
            tx, ty, tz = getElementPosition(v)
            local px, py, pz = getElementPosition(localPlayer)
            dist = math.sqrt((px - tx) ^ 2 + (py - ty) ^ 2 + (pz - tz) ^ 2)
            if dist < 8 then
                if isLineOfSightClear(px, py, pz, tx, ty, tz, true, false, false, true, false, false, false, localPlayer) then
                    local sx, sy, sz = getElementPosition(v)
                    local x, y = getScreenFromWorldPosition(sx, sy, sz)
                    if x and y then
                        dxDrawBorderedText(
                            "Usa la tecla '#FDCE61F#FFFFFF' para interactuar\n#FDCE61" .. (pick or "") .. "", x - 80,
                            y - 120, 200 + x - 80, 40 + y - 120, tocolor(255, 255, 255, 255), 1, "default-bold",
                            "center", "center")
                    end
                end
            end
        end
    end
end)

function dxDrawBorderedText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI)
    dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) - 1, (y) + 1, (w) - 1, (h) + 1, tocolor(0, 0, 0, 255), scale, font,
        alignX, alignY, clip, wordBreak, postGUI, true)
    dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor(0, 0, 0, 255), scale, font,
        alignX, alignY, clip, wordBreak, postGUI, true)
    dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end
--
local SonidoPlayer = {}
--
addEvent("SoundsPhone", true)
addEventHandler("SoundsPhone", root, function(tip, jugador)
    if tip == "LlamarSound" then
        s = Sound("sounds/LlamarSound.mp3", true)
        s:setVolume(0.50)
    elseif tip == "LlamadaSound" then
        local x, y, z = getElementPosition(jugador)
        SonidoPlayer[jugador] = Sound3D("sounds/LlamadaSound.mp3", x, y, z, true)
        attachElements(jugador, SonidoPlayer[jugador])
        SonidoPlayer[jugador]:setVolume(0.50)
        setSoundMaxDistance(SonidoPlayer[jugador], 10)
    elseif tip == "stopLlamada" then
        stopSound(s)
    elseif tip == "stopLlamado" then
        if SonidoPlayer[jugador] then
            stopSound(SonidoPlayer[jugador])
            SonidoPlayer[jugador] = nil
        end
    end
end)




