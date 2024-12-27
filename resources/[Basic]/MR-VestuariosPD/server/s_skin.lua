-- Evento para cambiar el skin del jugador
addEvent("cambiarSkin", true)
addEventHandler("cambiarSkin", root, function(skinID)
    if skinID then
        setElementModel(client, skinID)
        outputChatBox("* Tu skin ha sido cambiado a: " .. getPlayerName(client), client, 255, 255, 255)
    end
end)
