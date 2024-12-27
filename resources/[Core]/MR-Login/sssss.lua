local db = dbConnect("mysql", "dbname=majestic_rp;host=localhost;charset=utf8", "root", "")

if not db then
    outputDebugString(
        "No se pudo conectar a la base de datos. Verifique las credenciales y la configuración de MySQL.", 1)
else
    outputDebugString("Conexión a la base de datos exitosa.", 3)
end

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
        SET ubicacion_x = ?, ubicacion_y = ?, ubicacion_z = ?, salud = ?, armadura = ?, dinero = ?, experiencia = ?, nivel = ?, armas = ?
        WHERE id = ?
    ]]
    dbExec(db, query, x, y, z, health, armor, dinero, getElementData(player, "experiencia") or 0,
        getElementData(player, "nivel") or 1, weaponsJSON, characterId)
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
        -- Cargar los datos del personaje (ejemplo: tel etransportar al jugador)
        -- Imprimir nombre y contraseña del personaje para debug
        if isGuestAccount(getPlayerAccount(source)) == false then
            print("Se echo al jugador"..getPlayerName(client).." por estar logueado en otra cuenta")
            kickPlayer(source,"Ya estas logueado en otra cuenta") -- Kickear al jugador para evitar duplicados
            return
        end
        print(character.nombre_apellido .. " y " .. character.pass)

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

        -- Establecer posición y estadísticas
        setPlayerName(client, character.nombre_apellido)
        spawnPlayer(client, character.ubicacion_x, character.ubicacion_y, character.ubicacion_z)
        setElementHealth(client, character.salud)
        setPedArmor(client, character.armadura)
        setElementInterior(client, 0)
        setElementDimension(client, 0)
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

        -- Establecer otros datos del personaje en el jugador
        setElementData(client, "character_id", character.id)
        setElementData(client, "cuenta_id", character.cuenta_id)
        setElementData(client, "nombre_apellido", character.nombre_apellido)
        setElementData(client, "Sexo", character.Sexo)
        setElementData(client, "experiencia", character.experiencia)
        setElementData(client, "nivel", character.nivel)
        setElementData(client, "Roleplay:Nacionalidad", character.Nacionalidad)
        setElementData(client, "Roleplay:Trabajo", character.Trabajo)
        setElementData(client, "Skin", character.Skin)
        setElementData(client, "Edad", character.Edad)
        setElementData(client, "DNI", character.DNI)
        setElementModel(client, character.Skin)

        -- Enviar mensajes al jugador
        outputChatBox("¡Bienvenido, " .. character.nombre_apellido .. "!", client, 0, 255, 0)
        setPlayerTeam(client, nil) -- remove the player from the current team

        -- Configuración de la cámara
        fadeCamera(client, true)
        setCameraTarget(client, client)
        if character.TestRoleplay == "No" then 
            setElementData(client, "TestRoleplay", "Si")

            setElementPosition(client, 1743.3095703125, -1860.140625, 13.579099655151)
            setElementRotation(client,0,0,360)
        setPlayerMoney(client, 50000)
        setElementModel(client, 2)




        end

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
