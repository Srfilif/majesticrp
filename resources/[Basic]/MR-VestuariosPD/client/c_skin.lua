local skins = {
    {id = 71, nombre = "Cadete"},
    {id = 214, nombre = "Mujer Policial"},
    {id = 298, nombre = "Mujer Policial II"},
    {id = 280, nombre = "Sargento"},
    {id = 284, nombre = "Motero"},
    {id = 281, nombre = "Oficial I"},
    {id = 282, nombre = "Teniente"}
}


local ventanaAbierta = false
local skinCivil -- Variable para almacenar el skin civil del jugador
colShapeVestuario = createColCuboid(1575.6357421875, -1685.0712890625, 15.1953125, 5, 5, 5) -- Cambia las coordenadas según tu mapa

-- Crear colShape (zona para vestuario)

-- Mostrar ventana al usar el comando
addCommandHandler("vestuario", function()
    if isElementWithinColShape(localPlayer, colShapeVestuario) then
        if not ventanaAbierta then
            abrirVentanaSkins()
        else
            outputChatBox("#FF3D3D* La ventana de vestuario ya está abierta.", 255, 0, 0, true)
        end
    else
        outputChatBox("#FF3D3D* Debes estar en el vestuario para usar este comando.", 255, 0, 0, true)
    end
end)

function abrirVentanaSkins()

    local screenW, screenH = guiGetScreenSize()
    ventanaSkins = guiCreateWindow((screenW - 424) / 2, (screenH - 324) / 2, 424, 324, "Vestuario - Policía", false)
    guiWindowSetSizable(ventanaSkins, false)

    -- Etiqueta de bienvenida
    ventanaSkins_Label = guiCreateLabel(12, 21, 403, 36, 
        "¡Bienvenido al vestuario policial!\nSelecciona el skin que quieras y dale clic a Tomar", false, ventanaSkins)
    guiLabelSetHorizontalAlign(ventanaSkins_Label, "center", false)

    -- Lista de skins
    listaSkins = guiCreateGridList(10, 54, 266, 260, false, ventanaSkins)
    guiGridListAddColumn(listaSkins, "ID", 0.2)
    guiGridListAddColumn(listaSkins, "Skin", 0.7)

    -- Llenar la lista con los skins
    for _, skin in ipairs(skins) do
        local row = guiGridListAddRow(listaSkins)
        guiGridListSetItemText(listaSkins, row, 1, tostring(skin.id), false, true)
        guiGridListSetItemText(listaSkins, row, 2, skin.nombre, false, false)
    end

    -- Botones
    botonTomarSkin = guiCreateButton(281, 57, 133, 22, "Tomar Skin", false, ventanaSkins)
    botonGuardarSkinCivil = guiCreateButton(280, 89, 135, 22, "Guardar Skin Civil", false, ventanaSkins)
    botonRestaurarSkinCivil = guiCreateButton(279, 121, 136, 22, "Restaurar Skin Civil", false, ventanaSkins)
    botonCerrar = guiCreateButton(281, 292, 134, 22, "Cerrar", false, ventanaSkins)
    guiSetProperty(botonCerrar, "NormalTextColour", "FFFF0000")

    -- Mostrar cursor
    showCursor(true)
    ventanaAbierta = true

    -- Eventos de botones
    addEventHandler("onClientGUIClick", botonTomarSkin, tomarSkin, false)
    addEventHandler("onClientGUIClick", botonGuardarSkinCivil, guardarSkinCivil, false)
    addEventHandler("onClientGUIClick", botonRestaurarSkinCivil, restaurarSkinCivil, false)
    addEventHandler("onClientGUIClick", botonCerrar, cerrarVentanaSkins, false)
end


-- Función para tomar un skin
function tomarSkin()
    local row = guiGridListGetSelectedItem(listaSkins)
    if row ~= -1 then
        local skinID = tonumber(guiGridListGetItemText(listaSkins, row, 1))
        if skinID then
            triggerServerEvent("cambiarSkin", localPlayer, skinID)
        end
    else
        outputChatBox("#FF3D3D* Selecciona un skin para tomar.", 255, 0, 0, true)
    end
end

-- Función para guardar el skin civil-- Función para guardar el skin civil
function guardarSkinCivil()

   for _, skin in ipairs(skins) do
    if skin.id == getElementModel(localPlayer) then
        skinEncontrado = true
        break
    else
        skinEncontrado = false
        
        
    end
end

-- Si el skin del jugador está en la lista, mostramos un mensaje de error
if skinEncontrado then
    outputChatBox("#FF3d3d* No puedes guardar un skin del vestuario policial.", 255, 255, 255, true)
else
    -- Si no está en la lista, se guarda el skin
    outputChatBox("#ffFFff* Has guardado la skin civil correctamente", 255, 255, 255, true)
    skinCivil = getElementModel(localPlayer)

    -- Aquí puedes guardar el skin en una variable o en una base de datos si lo necesitas
end


end



-- Función para restaurar el skin civil
function restaurarSkinCivil()
    if skinCivil then
        triggerServerEvent("cambiarSkin", localPlayer, skinCivil)
        outputChatBox("#ffFFff* Has restaurado tu skin civil.", 255, 255, 255, true)
    else
        outputChatBox("#FF3D3D* No tienes un skin civil guardado.", 255, 0, 0, true)
    end
end

-- Función para cerrar la ventana
function cerrarVentanaSkins()
    if ventanaSkins then
        destroyElement(ventanaSkins)
        showCursor(false)
        ventanaAbierta = false
    end
end
