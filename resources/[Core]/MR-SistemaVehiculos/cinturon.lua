-- Tabla para guardar el estado del cinturón/casco de cada jugador
local playerSafety = {}

-- Comando para el cinturón
function toggleCinturon(player)
    if not isPedInVehicle(player) then
        outputChatBox("Debes estar en un vehículo para usar el cinturón.", player, 255, 0, 0)
        return
    end

    local vehicle = getPedOccupiedVehicle(player)
    if getVehicleType(vehicle) == "Bike" or getVehicleType(vehicle) == "BMX" then
        outputChatBox("No puedes usar cinturón en una motocicleta o bicicleta.", player, 255, 0, 0)
        return
    end

    playerSafety[player] = not playerSafety[player]
    if playerSafety[player] then
        outputChatBox("#34eb58* Te has abrochado el cinturón de seguridad.", player, 0, 255, 0,true)
    else
        outputChatBox("#ff3d3d* Te has quitado el cinturón de seguridad.", player, 255, 255, 0,true)
    end
end
addCommandHandler("cinturon", toggleCinturon)

-- Evento para manejar el daño al chocar
function handleVehicleDamage(loss)
    local player = getVehicleOccupant(source) -- Obtiene al ocupante del vehículo
    if player then
        if loss < 50 then
            -- Si el daño es leve (por debajo de 50), no ocurre nada
            return
        end
        
        if playerSafety[player] then
            -- Si el jugador tiene cinturón/casco, se salva y el daño es cancelado
            outputChatBox("#3440eb[CINTURON] #ffFFff¡El cinturón de seguridad te ha salvado la vida!", player, 0, 255, 0,true)
            cancelEvent() -- Cancela el daño del vehículo
        else
            -- Si el jugador no tiene cinturón/casco, aplica daño dependiendo de la pérdida
            local health = getElementHealth(player)
            local damage = math.min(loss / 10, health - 10) -- Calcula el daño pero nunca baja de 10 de vida
            local vehicle = getPedOccupiedVehicle(player)
            setElementHealth(player, health - damage)
            if loss > 95 then
            vehicle:setEngineState (false)
            vehicle:setFrozen(false)
            vehicle:setLightState(0, 1)
            vehicle:setLightState(1, 1)
            vehicle:setData('Motor', 'apagado')
            end
            -- Mensaje para el jugador
            outputChatBox("#ff3d3dTe has lastimado por no usar el cinturón/casco. ¡Ponte uno la próxima vez!", player, 255, 0, 0,true)
        end
    end
end
addEventHandler("onVehicleDamage", root, handleVehicleDamage)

-- Limpia el estado del jugador al salir del vehículo
function onPlayerExitVehicle()
    if playerSafety[source] then
        playerSafety[source] = nil
    end
end
addEventHandler("onPlayerVehicleExit", root, onPlayerExitVehicle)

-- Limpia el estado del jugador al desconectarse
function onPlayerQuit()
    playerSafety[source] = nil
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)
