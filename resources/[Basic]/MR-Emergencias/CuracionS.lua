-- Creación de pickup y marcador
local pickupCura = createPickup(2043.009765625, -1423.388671875, 17.1640625, 0, 0, 57.011688232422)
local markerCura = createMarker(2043.009765625, -1423.388671875, 17.1640625, "cylinder", 2, 255, 255, 255, 0)

-- Posición de curación y variable para seguimiento del jugador en curación
local posCuracion = {1579.5590820312, 1779.1002197266, 2090.2419433594}
local jugadorEnCuracion = nil

-- Función para realizar la curación
function CurarJugador(player)
    if player == jugadorEnCuracion then
        jugadorEnCuracion = player
        
        setTimer(function()
            fadeCamera(player, true, 1.5, 0, 0, 0)
            triggerClientEvent(player, "mostrarCura", player)
        end, 2000, 1)

        local x, y, z = unpack(posCuracion)
        setElementPosition(player, x, y, z)
        setElementRotation(player, 0, 0, 270)
        setElementDimension(player, 9)
        setElementInterior(player, 3)
        setPedAnimation(player, "CRACK", "crckdeth2", -1, false, false, false)

        local camX, camY, camZ = 1577.1943359375, 1779.435546875, 2091.8186035156
        local lookX, lookY, lookZ = x, y, z
        setCameraMatrix(player, camX, camY, camZ, lookX, lookY, lookZ)

        setTimer(function()
            fadeCamera(player, false, 1.5, 0, 0, 0)
        end, 9000, 1)

        setTimer(function()
            fadeCamera(player, true, 1.5, 0, 0, 0)
setElementRotation(player, 0, 0, 1)
            setPedAnimation(player, false)
            setElementFrozen(player, false)
            jugadorEnCuracion = nil
            setElementHealth(player, 100)
            setCameraTarget(player, player)
            takePlayerMoney(player, 100)
            setElementPosition(player, 1590.1726074219, 1789.1124267578, 2083.376953125)
            setElementRotation(player, 0, 0, 1)

            outputChatBox("#FF4343[Hospital] #ffffffHas sido exitosamente reanimado.", player, 255, 0, 0, true)
            outputChatBox("#FF4343[Hospital] #ffffffSe han aplicado cargos de #00ff00100$ #ffffffpor concepto de gastos médicos.", player, 255, 0, 0, true)
            outputChatBox("#FF4343[Hospital] #ffffffTus objetos peligrosos no han sido confiscados.", player, 255, 0, 0, true)
        setElementRotation(player, 0, 0, 1)
		end, 10000, 1)
    end
end


-- Comando para iniciar el proceso de curación
addCommandHandler("emergencias", function(player)
    if isElementWithinMarker(player, markerCura) then
        if isPedInVehicle(player) then
            outputChatBox("#FF4343[Hospital] #ffffffDebes bajarte de tu vehiculo para poder curarte", player, 177, 53, 53, true)
        else
            if getElementHealth(player) <= 50 then
                if not jugadorEnCuracion then
                    fadeCamera(player, false, 1.5, 0, 0, 0)
                    setElementFrozen(player, true)
                    triggerClientEvent(player, "mostrarCura", player)
                    jugadorEnCuracion = player
                    outputChatBox("#FF4343[Hospital] #ffffffEstás entrando al #88FF00quirófano#ffffff. Por favor, espera un momento...", player, 255, 0, 0, true)

                    setTimer(function()
                        CurarJugador(player)
                    end, 2000, 1)
                else
                    outputChatBox("#FF4343[Hospital] #ffffff¡Alguien ya está siendo #ff3d3dreanimado#ffffff! Por favor, espera un momento...", player, 255, 0, 0, true)
                end
            else
                outputChatBox("#FF4343[Hospital] #ffffffDebes tener menos del 50% de vida para ocupar esto", player, 177, 53, 53, true)
            end
        end
    end
end)
