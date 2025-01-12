local db = exports["MR-Gamemode"]:getDatabase()

function saveCharacterData(player)
    if not isElement(player) then
        return
    end

    local characterId = getElementData(player, "character_id")
    if not characterId then
        return
    end

    -- Obtener datos del jugador
    local x, y, z = getElementPosition(player)
    local rx, ry, rz = getElementRotation(player)
    local int = getElementInterior(player)
    local dim = getElementDimension(player)
    local health = getElementHealth(player)
    local armor = getPedArmor(player)
    local dinero = getPlayerMoney(player)
    local weapons = {}
    local skin = getElementModel(player)
    local portearmas = getElementData(player, "Roleplay:Licencia_Arma")



    -- Guardar las armas
    for slot = 0, 12 do
        local weapon = getPedWeapon(player, slot)
        local ammo = getPedTotalAmmo(player, slot)
        if weapon > 0 then
            table.insert(weapons, {
                weapon = weapon,
                ammo = ammo
            })
        end
    end

    -- Convertir las armas a JSON
    local weaponsJSON = toJSON(weapons)

    -- Actualizar en la base de datos
    local query = [[
        UPDATE personajes
        SET ubicacion_x = ?, ubicacion_y = ?, ubicacion_z = ?, salud = ?, armadura = ?, dinero = ?, experiencia = ?, nivel = ?, armas = ?, Skin = ?, interior = ?, dimencion = ?, portearma = ?
        WHERE id = ?
    ]]
    dbExec(db, query, x, y+0.5, z, health, armor, dinero, getElementData(player, "Roleplay:Reputacion") or 0,
        getElementData(player, "Nivel") or 1, weaponsJSON, skin, int,dim,portearmas,characterId)
end

addEventHandler("onPlayerQuit", root, function()
    saveCharacterData(source)
end)
-- Evento para manejar la selección del personaje
addEvent("onPlayerSelectCharacter", true)
addEventHandler("onPlayerSelectCharacter", root, function(characterId)
    if not characterId then
        triggerClientEvent(client, "onCharacterSelectionSuccess", client, false, "Personaje no válido.")
        return
    end

    -- Consultar la información del personaje seleccionado
    local query = dbQuery(db, "SELECT * FROM personajes WHERE id = ? AND cuenta_id = ?", characterId,
        getElementData(client, "cuenta_id"))
    local result = dbPoll(query, -1)

    if result and #result > 0 then
        local character = result[1]
        -- Validar si ya está logueado en otra cuenta
        if isGuestAccount(getPlayerAccount(source)) == false then
            print("Se echó al jugador " .. getPlayerName(client) .. " por estar logueado en otra cuenta")
            kickPlayer(source, "Ya estás logueado en otra cuenta") -- Kickear al jugador para evitar duplicados
            return
        end

        -- Intentar obtener la cuenta usando el nombre de usuario y la contraseña
        local account = getAccount(character.nombre_apellido, character.pass)

        if account then
            -- Cuenta encontrada, intentar iniciar sesión
            local success = logIn(client, account, character.pass)
            if success then
                print("Inicio de sesión exitoso para: " .. character.nombre_apellido)
            else
                print("No se pudo iniciar sesión para: " .. character.nombre_apellido)
            end
        else
            -- La cuenta no existe, crearla
            print("No se encontró la cuenta. Creándola...")

            local newAccount = addAccount(character.nombre_apellido, character.pass)
            if newAccount then
                print("Cuenta creada exitosamente para: " .. character.nombre_apellido)

                -- Intentar iniciar sesión con la nueva cuenta
                local success = logIn(client, newAccount, character.pass)
                if success then
                    
                    print("Inicio de sesión exitoso para la nueva cuenta: " .. character.nombre_apellido)
                else
                    print("Error al iniciar sesión con la nueva cuenta.")
                end
            else
                print("Error al crear la cuenta para: " .. character.nombre_apellido)
            end
        end
        outputChatBox("#ffFFf1",client, 0, 255, 0,true)
        outputChatBox("#ffFFf2",client, 0, 255, 0,true)
        outputChatBox("#ffFFf2",client, 0, 255, 0,true)
        outputChatBox("#ffFFf3",client, 0, 255, 0,true)
        outputChatBox("#ffFFf1",client, 0, 255, 0,true)
        outputChatBox("#ffFFf2",client, 0, 255, 0,true)
        outputChatBox("#ffFFf2",client, 0, 255, 0,true)
        outputChatBox("#ffFFf3",client, 0, 255, 0,true)
        outputChatBox("#ffFFf1",client, 0, 255, 0,true)
        outputChatBox("#ffFFf2",client, 0, 255, 0,true)
        outputChatBox("#ffFFf2",client, 0, 255, 0,true)
        outputChatBox("#ffFFf3",client, 0, 255, 0,true)
        triggerClientEvent(client,"addhudPlayer", client)

        -- Establecer posición y estadísticas
        setPlayerName(client, character.nombre_apellido)
        spawnPlayer(client, character.ubicacion_x, character.ubicacion_y, character.ubicacion_z)
        setElementHealth(client, character.salud)
        setPedArmor(client, character.armadura)
        setElementInterior(client, character.interior)
        setElementDimension(client, character.dimencion)
        setPlayerMoney(client, character.dinero)
        

        -- Restaurar armas si existen
        if character.armas and character.armas ~= "" then
            local weapons = fromJSON(character.armas)
            if weapons then
                for _, weaponData in ipairs(weapons) do
                    giveWeapon(client, weaponData.weapon, weaponData.ammo)
                end
            end
        end
        outputChatBox("#ffFFff* ¡Bienvenido, Has selecionado el personaje #ffff3d " .. character.nombre_apellido .. "#ffFFFf!.", client, 0, 255, 0,true)

        -- Establecer otros datos del personaje en el jugador
        setElementData(client, "character_id", character.id)
        setElementData(client, "cuenta_id", character.cuenta_id)
        setElementData(client, "nombre_apellido", character.nombre_apellido)
        setElementData(client, "Sexo", character.Sexo)
        setElementData(client, "nivel", character.nivel)
        setElementData(client, "Roleplay:Nacionalidad", character.Nacionalidad)
        setElementData(client, "Roleplay:Trabajo", character.Trabajo)
        setElementData(client, "Skin", character.Skin)
        setElementData(client, "Edad", character.Edad)
        setElementData(client, "DNI", character.DNI)
        setElementData(client, "Roleplay:Licencia_Arma", character.portearma)
        setElementData(client, "Roleplay:Reputacion",character.experiencia)
        setElementData(client, "Nivel", character.nivel)

        setElementModel(client, character.Skin)
        setPedWalkingStyle ( client,character.caminata )

        -- Enviar mensajes al jugador

        setPlayerTeam(client, nil) -- remove the player from the current team

        -- Verificar si es un jugador nuevo
        if character.TestRoleplay == "No" then
            -- Establecer datos iniciales para un jugador nuevo
            local updateQuery = dbExec(db, "UPDATE personajes SET TestRoleplay = ? WHERE id = ?", "Si", character.id)
            if updateQuery then
                print("TestRoleplay actualizado en la base de datos para: " .. character.nombre_apellido)
            else
                print("Error al actualizar TestRoleplay en la base de datos para: " .. character.nombre_apellido)
            end
            -- Ubicación inicial para jugadores nuevos (el lunes)
            setElementPosition(client, 1743.3095703125, -1860.140625, 13.579099655151)
            setElementRotation(client, 0, 0, 360)
            
            -- Configurar dinero inicial, salud y modelo
            setPlayerMoney(client, 50000)
            setElementHealth(client, 100)



            -- Mensaje de bienvenida específico para nuevos jugadores
            outputChatBox("¡Bienvenido a tu nueva aventura, " .. character.nombre_apellido .. "!", client, 0, 200, 0)
        end

        -- Configuración de la cámara
        fadeCamera(client, true)
        setCameraTarget(client, client)

        triggerClientEvent(client, "onCharacterSelectionSuccess", client)
    else
        triggerClientEvent(client, "onCharacterSelectionSuccess", client, false, "No se pudo cargar el personaje.")
    end
end)


addEventHandler("onResourceStop", resourceRoot, function()
    for _, player in ipairs(getElementsByType("player")) do
        saveCharacterData(player)
    end
end)

function loadCharactersForPlayer(player, accountId)
    local query = [[SELECT * FROM personajes WHERE cuenta_id = ?]]
    dbQuery(function(queryHandle)
        local result = dbPoll(queryHandle, 0)
        triggerClientEvent(player, "onShowCharacterSelector", player, result or {})
    end, db, query, accountId)
end

addEvent("onLoginResponse", true)
addEventHandler("onLoginResponse", root, function(success, accountId)
    if success then
        loadCharactersForPlayer(client, accountId)
    end
end)
