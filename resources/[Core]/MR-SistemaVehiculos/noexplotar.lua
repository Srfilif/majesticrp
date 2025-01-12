-- Salud mínima que tendrá un vehículo cuando esté muy dañado
local MIN_HEALTH = 300 -- Ajusta este valor según prefieras

-- Evento que se ejecuta cada vez que un vehículo recibe daño
addEventHandler("onVehicleDamage", root, function(loss)
    local health = getElementHealth(source)

    -- Si la salud actual está por debajo del mínimo, ajustarla al mínimo
    if health <= MIN_HEALTH then
        setElementHealth(source, MIN_HEALTH)
        source:setEngineState (false)
        source:setFrozen(false)
        source:setLightState(0, 1)
        source:setLightState(1, 1)
        source:setData('Motor', 'apagado')
    end
end)

-- Evento opcional para evitar que los vehículos exploten en cualquier caso
addEventHandler("onVehicleExplode", root, function()
    -- Restaurar la salud mínima antes de la explosión
    setElementHealth(source, MIN_HEALTH)
    fixVehicle(source) -- Opcional: repara el vehículo para que no tenga humo
    cancelEvent() -- Cancela la explosión
end)
