-- Tabla de configuración de armas
local configuracionArmas = {
    [24] = {maxMunicion = 35, cargador = 7}, -- Pistola: 30 balas máx., 10 balas por cargador
    [22] = {maxMunicion = 85, cargador = 17}, -- Desert Eagle: 21 balas máx., 7 balas por cargador
    [25] = {maxMunicion = 15, cargador = 1}, -- Desert Eagle: 21 balas máx., 7 balas por cargador

    [3] = {maxMunicion = 1, cargador = 1}, -- Pistola: 30 balas máx., 10 balas por cargador
    [29] = {maxMunicion = 150, cargador = 30}, -- Desert Eagle: 21 balas máx., 7 balas por cargador
    [34] = {maxMunicion = 10, cargador = 1}, -- Desert Eagle: 21 balas máx., 7 balas por cargador

    [31] = {maxMunicion = 150, cargador = 50} -- Rifle de Asalto: 150 balas máx., 30 balas por cargador
    -- Agrega más armas según sea necesario
}

-- Evento para dar el arma al jugador
addEvent("Armeria-darArma", true)
addEventHandler("Armeria-darArma", root, function(armaID)
    if not armaID then
        return
    end

    local config = configuracionArmas[armaID]

    if not config then
        outputChatBox("#ff3d3d* Este arma no tiene configurado un límite de munición o cargador.", client, 255, 0, 0, true)
        return
    end

    local maxMunicion = config.maxMunicion
    local cargador = config.cargador

    -- Obtener la munición actual del jugador para esta arma
    local municionActual = getPedTotalAmmo(client, getSlotFromWeapon(armaID)) or 0

    -- Verificar si ya tiene el arma
    local tieneArma = getPedWeapon(client, getSlotFromWeapon(armaID)) == armaID

    -- Calcular cuánta munición se puede dar sin exceder el límite
    if municionActual >= maxMunicion then
        outputChatBox("#ff3d3d* No puedes llevar más munición para este arma.", client, 255, 0, 0, true)
        return
    end

    local municionAEntregar = math.min(cargador, maxMunicion - municionActual)

    -- Dar el arma con la munición calculada
    if not tieneArma then
        giveWeapon(client, armaID, municionAEntregar, true) -- Dar arma con las balas iniciales
    else
        addWeaponAmmo(client, armaID, municionAEntregar) -- Solo agrega munición si ya tiene el arma
    end

    -- Mensaje al jugador
    outputChatBox("#FFFFFF* Has recibido un arma policial: #FFFF3D" .. getWeaponNameFromID(armaID) ..
        " #FFFFFFcon: #FFFF3D" .. municionAEntregar ..
        " balas #777777(" .. (municionActual + municionAEntregar) .. "/" .. maxMunicion .. ")#FFFFFF.", client, 0, 255, 0, true)
end)

-- Función auxiliar para añadir munición
function addWeaponAmmo(player, armaID, ammo)
    local currentAmmo = getPedTotalAmmo(player, getSlotFromWeapon(armaID)) or 0
    local weaponSlot = getSlotFromWeapon(armaID)
    takeWeapon(player, armaID) -- Remover y re-asignar para actualizar la munición
    giveWeapon(player, armaID, currentAmmo + ammo, true)
end



-- Función para dar chaleco al jugador
addEvent("Armeria-DarChaleco", true)
addEventHandler("Armeria-DarChaleco", root, function()
    local player = client
    if player then
        local currentArmor = getPedArmor(player)
        if currentArmor <= 90 then
            setPedArmor(player, 100) -- Dar 50 de armadura
            outputChatBox("#ffFFff* Has recibido un chaleco antibalas policial.", player, 0, 255, 0,true)
        else
            outputChatBox("#ff3d3d* Ya tienes un chaleco antibalas policial.", player, 255, 0, 0,true)
        end
    end
end)


-- Función para devolver un arma o chaleco antibalas del jugador
-- Función para devolver un arma o chaleco antibalas del jugador
addEvent("Armeria-devolverArma", true)
addEventHandler("Armeria-devolverArma", root, function(armaID)
    local player = client
    if player and tonumber(armaID) then
        -- Manejar la devolución del chaleco antibalas
        if tonumber(armaID) == 0 then
            local currentArmor = getPedArmor(player)
            if currentArmor > 0 then
                setPedArmor(player, 0) -- Quitar el chaleco
                outputChatBox("#FFFFFF* Has entregado tu chaleco antibalas. *", player, 0, 255, 0, true)
            else
                outputChatBox("#FF3D3D* No tienes chaleco para entregar.", player, 255, 0, 0, true)
            end
            return
        end

        -- Manejar la devolución de un arma
        local weaponSlot = getSlotFromWeapon(tonumber(armaID))
        if weaponSlot then
            local currentAmmo = getPedTotalAmmo(player, weaponSlot) -- Obtener la munición total del arma
            if currentAmmo > 0 then
                if takeWeapon(player, armaID) then
                    local weaponName = getWeaponNameFromID(tonumber(armaID)) or "arma desconocida"
                    outputChatBox("#FFFFFF* Has devuelto una: #FFFF00" .. weaponName ..
                        " #777777(ID: " .. tostring(armaID) .. ") #FFFFFFcon #FFFF00" .. tostring(currentAmmo) ..
                        " balas.", player, 0, 255, 0, true)
                else
                    outputChatBox("#FF3D3D* No tienes esta arma para devolver.", player, 255, 0, 0, true)
                end
            else
                outputChatBox("#FF3D3D* No tienes munición para este arma.", player, 255, 0, 0, true)
            end
        else
            outputChatBox("#FF3D3D* Error al encontrar el arma.", player, 255, 0, 0, true)
        end
    else
        outputChatBox("#FF3D3D* Error: ID de arma inválido.", player, 255, 0, 0, true)
    end
end)
