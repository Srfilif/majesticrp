function repararVehiculoCercano(player)
    -- Obtener la posición del jugador
    local px, py, pz = getElementPosition(player)
    -- Obtener una lista de todos los vehículos en el servidor
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

    -- Si se encuentra un vehículo cercano, repararlo
    if vehiculoCercano then
        fixVehicle(vehiculoCercano)
        outputChatBox("✅ Vehículo reparado exitosamente.", player, 0, 255, 0)
    else
        outputChatBox("❌ No hay ningún vehículo cerca para reparar.", player, 255, 0, 0)
    end
end

-- Registrar el comando /kitherramientas
addCommandHandler("kitherramientas", repararVehiculoCercano)
