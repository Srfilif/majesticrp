
function repararVehiculoCercano(player)
    -- Verificar si el jugador tiene al menos 1 kit de herramientas
    local kitsDisponibles = exports["[LS]Tiendas"]:getPlayerItem(player, "Caja de Herramientas")

    if kitsDisponibles <= 0 then
        outputChatBox("❌ No tienes kits de herramientas disponibles.", player, 255, 0, 0)
        return
    end

    -- Obtener la posición del jugador
    local px, py, pz = getElementPosition(player)
    local vehiculos = getElementsByType("vehicle")
    local radio = 5 -- Radio para detectar vehículos cercanos
    local vehiculoCercano = nil

    -- Buscar el vehículo más cercano dentro del radio
    for _, vehiculo in ipairs(vehiculos) do
        local vx, vy, vz = getElementPosition(vehiculo)
        local distancia = getDistanceBetweenPoints3D(px, py, pz, vx, vy, vz)
        if distancia <= radio then
            vehiculoCercano = vehiculo
            break
        end
    end

    -- Si se encuentra un vehículo cercano
    if vehiculoCercano then
        local saludVehiculo = getElementHealth(vehiculoCercano)

        -- Verificar la salud del vehículo
        if saludVehiculo > 500 then
            outputChatBox("✅ El vehículo está en buen estado. Llévalo a un puesto de reparación para mantenimiento.", player, 0, 255, 0)
        else
            -- Reparar el vehículo y reducir el kit en 1
            fixVehicle(vehiculoCercano)
            exports["[LS]Tiendas"]:setPlayerItem(player, "Caja de Herramientas", kitsDisponibles - 1)
            outputChatBox("✅ Vehículo reparado exitosamente. Se ha consumido 1 kit de herramientas.", player, 0, 255, 0)
        end
    else
        outputChatBox("❌ No hay ningún vehículo cerca para reparar.", player, 255, 0, 0)
    end
end

-- Registrar el comando /kitherramientas
addCommandHandler("kitherramientas", repararVehiculoCercano)
