-- Función para encender/apagar un vehículo
function toggleEngine(player)
    local veh = getPedOccupiedVehicle(player)
    if not veh then
        outputChatBox("[Error] No estás en un vehículo.", player, 255, 0, 0)
        return
    end

    local engineState = getElementData(veh, "engine") or false

    if engineState then
        setVehicleEngineState(veh, false)
        setElementData(veh, "engine", false)
        outputChatBox("Has apagado el motor del vehículo.", player, 0, 255, 0)
    else
        setVehicleEngineState(veh, true)
        setElementData(veh, "engine", true)
        outputChatBox("Has encendido el motor del vehículo.", player, 0, 255, 0)
    end
end
addCommandHandler("encender", toggleEngine)
addCommandHandler("apagar", toggleEngine)

-- Función para bloquear/desbloquear un vehículo
function toggleLock(player)
    local veh = getPedOccupiedVehicle(player) or getElementData(player, "lastVehicle")
    if not veh then
        outputChatBox("[Error] No estás cerca de un vehículo para bloquear/desbloquear.", player, 255, 0, 0)
        return
    end

    local lockState = getElementData(veh, "locked") or false

    if lockState then
        setVehicleLocked(veh, false)
        setElementData(veh, "locked", false)
        outputChatBox("Has desbloqueado el vehículo.", player, 0, 255, 0)
    else
        setVehicleLocked(veh, true)
        setElementData(veh, "locked", true)
        outputChatBox("Has bloqueado el vehículo.", player, 0, 255, 0)
    end
end
addCommandHandler("bloquear", toggleLock)
addCommandHandler("desbloquear", toggleLock)

-- Guardar el último vehículo usado por el jugador
function saveLastVehicle(player, seat, jacked)
    if seat == 0 then -- Solo guardamos si es el conductor
        setElementData(player, "lastVehicle", source)
    end
end
addEventHandler("onPlayerVehicleExit", getRootElement(), saveLastVehicle)
-- Apagar el motor si el vehículo está configurado como apagado al entrar
-- Apagar el motor si el vehículo está configurado como apagado al entrar
function handleVehicleEnter(player, seat, jacked)
    if seat == 0 then -- Solo afecta al conductor
        local engineState = getElementData(source, "engine") or false
        setVehicleEngineState(source, engineState)
        if not engineState then
            outputChatBox("El motor del vehículo está apagado.", player, 255, 255, 0)
        end
    end
end
addEventHandler("onVehicleEnter", getRootElement(), handleVehicleEnter)
