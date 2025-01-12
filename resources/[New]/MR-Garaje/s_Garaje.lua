-- Tabla de garajes
local garajes = {
    ["Garaje SAPD"] = {
        markerPosition = { 1154.5185546875, 1122.7490234375, 10.8203125, 0, 0 }, -- Entrada (x, y, z, int, dim)
        garageInt = { 2000, 2000, 10, 0, 0, 0 }, -- Interior (x, y, z, rot, int, dim)

    },
    ["Garaje Central"] = {
        markerPosition = { 1050, 1050, 10, 0, 0 },
        garageInt = { 2050, 2050, 10, 90, 1, 1 },
    }
}

-- Función para crear los garajes
function crearGarajes()
    for nombre, data in pairs(garajes) do
        -- Crear marcador invisible de entrada
        local entryMarker = createMarker(
            data.markerPosition[1], -- x
            data.markerPosition[2], -- y
            data.markerPosition[3] - 1, -- z (ajustado para que esté debajo del pickup)
            "cylinder",
            2, -- Tamaño del marcador
            0, 0, 0, 0 -- Invisible (color RGBA: transparente)
        )
        
        -- Crear pickup visible para la entrada
        local entryPickup = createPickup(
            data.markerPosition[1], -- x
            data.markerPosition[2], -- y
            data.markerPosition[3], -- z
            3, -- Tipo de pickup (tipo 3 es un ícono)
            1274, -- Modelo del pickup
            0 -- Sin tiempo de respawn
        )
        
        -- Configurar interior y dimensión del marcador y pickup de entrada
        setElementInterior(entryMarker, data.markerPosition[4] or 0)
        setElementDimension(entryMarker, data.markerPosition[5] or 0)
        setElementInterior(entryPickup, data.markerPosition[4] or 0)
        setElementDimension(entryPickup, data.markerPosition[5] or 0)
     
        -- Crear marcador invisible de salida
        local exitMarker = createMarker(
            data.garageInt[1],
            data.garageInt[2],
            data.garageInt[3] - 1,
            "cylinder",
            2,
            0, 0, 0, 0 -- Invisible
        )
        
        -- Crear pickup visible para la salida
        local exitPickup = createPickup(
            data.garageInt[1],
            data.garageInt[2],
            data.garageInt[3],
            3,
            1274,
            0
        )
        
        -- Configurar interior y dimensión del marcador y pickup de salida
        setElementInterior(exitMarker, data.garageInt[5] or 0)
        setElementDimension(exitMarker, data.garageInt[6] or 0)
        setElementInterior(exitPickup, data.garageInt[5] or 0)
        setElementDimension(exitPickup, data.garageInt[6] or 0)

        setElementData(entryPickup, "pickup.interior", true)
        setElementData(entryPickup, "pickup.info", nombre)

        
        -- Evento para detectar si un jugador está cerca del marcador y presiona "F"
        addEventHandler("onMarkerHit", entryMarker, function(hitElement, matchingDimension)
            if getElementType(hitElement) == "player" and matchingDimension then
                bindKey(hitElement, "F", "down", function(player)
                    -- Teletransportar al interior del garaje
                    setElementPosition(player, data.garageInt[1], data.garageInt[2], data.garageInt[3])
                    setElementRotation(player, 0, 0, data.garageInt[4] or 0)
                    setElementInterior(player, data.garageInt[5] or 0)
                    setElementDimension(player, data.garageInt[6] or 0)
                    -- Mensaje al jugador
                    outputChatBox("#ede737[GARAJE] #ffFFffHas ingresado al " .. nombre .. "!", player, 0, 255, 0,true)
                    unbindKey(player, "F", "down") -- Desvincular la tecla después de usarla
                end)
            end
        end)

        addEventHandler("onMarkerHit", exitMarker, function(hitElement, matchingDimension)
            if getElementType(hitElement) == "player" and matchingDimension then
                bindKey(hitElement, "F", "down", function(player)
                    -- Teletransportar al jugador de vuelta a la entrada
                    setElementPosition(player, data.markerPosition[1], data.markerPosition[2], data.markerPosition[3])
                    setElementRotation(player, 0, 0, 0) -- Rotación por defecto
                    setElementInterior(player, data.markerPosition[4] or 0)
                    setElementDimension(player, data.markerPosition[5] or 0)
                    -- Mensaje al jugador
                    outputChatBox("#ede737[GARAJE] #ffFFffHas salido del " .. nombre .. "!", player, 255, 0, 0,true)
                    unbindKey(player, "F", "down") -- Desvincular la tecla después de usarla
                end)
            end
        end)
    end
end

-- Llamar la función para crear los garajes al iniciar el recurso
addEventHandler("onResourceStart", resourceRoot, crearGarajes)
