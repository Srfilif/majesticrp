-- Configuración de la conexión a la base de datos
local db = dbConnect("mysql", "dbname=majestic_rp;host=localhost;charset=utf8", "root", "")

if not db then
    outputDebugString("No se pudo conectar a la base de datos.", 1)
else
    outputDebugString("Conexión a la base de datos del login exitosa.", 3)
end
-- Crear tablas si no existen
if db then
    dbExec(db, [[
        CREATE TABLE IF NOT EXISTS cuentas (
            id INT AUTO_INCREMENT PRIMARY KEY,
            nombre VARCHAR(50) NOT NULL UNIQUE,
            pass VARCHAR(255) NOT NULL,
            fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
            staff TINYINT(1) DEFAULT 0,
            vip TINYINT(1) DEFAULT 0,
            creditos INT DEFAULT 0,
            email VARCHAR(50) NOT NULL
        )
    ]])

    dbExec(db, [[
        CREATE TABLE IF NOT EXISTS personajes (
            id INT AUTO_INCREMENT PRIMARY KEY,
            cuenta_id INT NOT NULL,
            nombre_apellido VARCHAR(50) NOT NULL,
            pass VARCHAR(255) NOT NULL,
            fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
            dinero INT DEFAULT 0,
            nivel INT DEFAULT 1,
            experiencia INT DEFAULT 0,
            ubicacion_x FLOAT DEFAULT 0,
            ubicacion_y FLOAT DEFAULT 0,
            ubicacion_z FLOAT DEFAULT 0,
            salud FLOAT DEFAULT 100,
            armadura FLOAT DEFAULT 0,
            Sexo TEXT NOT NULL DEFAULT 'Masculino',
            TestRoleplay TEXT NOT NULL DEFAULT 'No',
            Nacionalidad TEXT NOT NULL,
            Edad INT NOT NULL,
            DNI INT NOT NULL,
            armas TEXT DEFAULT NULL,
            Trabajo TEXT NOT NULL,
            Skin INT NOT NULL DEFAULT 2,
            interior INT NOT NULL,
            dimencion INT NOT NULL,
            FOREIGN KEY (cuenta_id) REFERENCES cuentas(id) ON DELETE CASCADE
        )
    ]])
end
-- Manejar intento de inicio de sesión para cuentas-- Manejar intento de inicio de sesión para cuentas
addEvent("onPlayerAttemptLogin", true)
addEventHandler("onPlayerAttemptLogin", root, function(username, password)
    if not username or not password then
        triggerClientEvent(client, "onLoginResponse", client, false, "Los campos no pueden estar vacíos.")
    exports["MR-Notify"]:addNotification(client, "Los campos no pueden estar vacíos.", "info")

        return
    end

    -- Consulta para verificar la cuenta
    local query = dbQuery(db, "SELECT * FROM cuentas WHERE nombre = ? AND pass = SHA2(?, 256)", username, password)
    local result = dbPoll(query, -1)

    if result and #result > 0 then
        local accountData = result[1]
        local accountId = accountData.id

        -- Establecer datos del cliente
        setElementData(client, "cuenta_id", accountId)
        print("ID de cuenta establecida para " .. getPlayerName(client) .. ": " .. accountId)

        -- Notificar inicio de sesión exitoso
        triggerClientEvent(client, "onLoginResponse", client, true, "Inicio de sesión exitoso.")
        triggerEvent("onLoginResponses", resourceRoot, accountId, client)

      --  outputChatBox("¡" .. username .. " se ha conectado con éxito!", root, 0, 255, 0)

        -- Consultar personajes vinculados a la cuenta
        local charactersQuery = dbQuery(db, "SELECT * FROM personajes WHERE cuenta_id = ?", accountId)
        local charactersResult = dbPoll(charactersQuery, -1)

        -- Enviar personajes al cliente
        if charactersResult and #charactersResult > 0 then
            triggerClientEvent(client, "onReceiveCharacters", client, charactersResult)
            triggerClientEvent(client, "onShowCharacterSelector", client, charactersResult)
        else
            triggerClientEvent(client, "onReceiveCharacters", client, {})
            triggerClientEvent(client, "onShowCharacterSelector", client, {})
        end
    else
        -- Notificar error de inicio de sesión
        triggerClientEvent(client, "onLoginResponse", client, false, "Usuario o contraseña incorrectos.")
    exports["MR-Notify"]:addNotification(client, "Usuario o contraseña incorrectos.", "error")

    end
end)

addEvent("onPlayerRegister", true)
addEventHandler("onPlayerRegister", root, function(username, password, email)
    if not username or not password or not email then
        triggerClientEvent(client, "onRegisterResponse", client, false, "Los datos enviados son inválidos.")
    exports["MR-Notify"]:addNotification(client, "Los datos enviados son inválidos.", "error")

        return
    end

    -- Verificar si el usuario ya existe
    local query = dbQuery(db, "SELECT * FROM cuentas WHERE nombre = ?", username)
    local result = dbPoll(query, -1)

    if result and #result > 0 then
        triggerClientEvent(client, "onRegisterResponse", client, false, "El nombre de usuario ya está en uso.")
    exports["MR-Notify"]:addNotification(client, "El nombre de usuario ya está en uso.", "error")
        
        return
    end

    -- Insertar la nueva cuenta
    local hashed_password = password -- Si estás usando hashes, aplica SHA2 aquí
    local success = dbExec(db,
        "INSERT INTO cuentas (nombre, pass, fecha_registro, creditos, vip, staff) VALUES (?, SHA2(?, 256), NOW(), 0, 0, 0)",
        username, hashed_password)

    if success then
        triggerClientEvent(client, "onRegisterResponse", client, true, "Registro exitoso. Ahora puedes iniciar sesión.")
    exports["MR-Notify"]:addNotification(client, "Registro exitoso. Ahora puedes iniciar sesión.", "error")

    else
    exports["MR-Notify"]:addNotification(client, "Error al registrar la cuenta. Intenta de nuevo.", "error")

        triggerClientEvent(client, "onRegisterResponse", client, false,
            "Error al registrar la cuenta. Intenta de nuevo.")
    end
end)

--[[ 

-- Evento para manejar la selección del personaje
addEvent("onPlayerSelectCharacter", true)
addEventHandler("onPlayerSelectCharacter", root, 
    function(characterId)
        if not characterId then
            triggerClientEvent(client, "onCharacterSelectionSuccess", client, false, "Personaje no válido.")
            return
        end

        -- Consultar la información del personaje seleccionado
        local query = dbQuery(db, "SELECT * FROM personajes WHERE id = ? AND cuenta_id = ?", characterId, getElementData(client, "cuenta_id"))
        local result = dbPoll(query, -1)

        if result and #result > 0 then
            local character = result[1]
            -- Cargar los datos del personaje (ejemplo: teletransportar al jugador)
            local account = getAccount (  character.nombre_apellido, character.pass ) -- Return the account

            logIn ( client, account, character.pass ) -- Log them in.


            -- Establecer posición y estadísticas
         --   spawnPlayer(player, character.ubicacion_x, character.ubicacion_y, character.ubicacion_z)
            setElementHealth(player, character.salud)
            setPedArmor(player, character.armadura)
            setElementInterior(player, 0)
            setElementDimension(player, 0)
            setPlayerMoney(player, character.dinero)

            -- Restaurar armas si existen
            if character.armas and character.armas ~= "" then
                local weapons = fromJSON(character.armas)
                if weapons then
                    for _, weaponData in ipairs(weapons) do
                        giveWeapon(player, weaponData.weapon, weaponData.ammo)
                    end
                end
            end

            -- Establecer otros datos del personaje en el jugador
            setElementData(player, "cuenta_id", character.cuenta_id)
            setElementData(player, "nombre_apellido", character.nombre_apellido)
            setElementData(player, "Sexo", character.Sexo)
            setElementData(player, "experiencia", character.experiencia)
            setElementData(player, "nivel", character.nivel)
            setElementData(player, "Roleplay:Nacionalidad", character.Nacionalidad)
            setElementData(player, "Roleplay:Trabajo", character.Trabajo)
            setElementData(player, "Skin", character.Skin)
            setElementData(player, "Edad", character.Edad)
            setElementData(player, "DNI", character.DNI)
            setElementModel(player, character.Skin)

            -- Enviar mensajes al jugador
            outputChatBox("¡Bienvenidox, " .. character.nombre_apellido .. "!", player, 0, 255, 0)

            -- Configuración de la cámara
            fadeCamera(player, true)
            setCameraTarget(player, player)
            setPlayerTeam ( player, nil )    -- remove the player from the current team


            triggerClientEvent(client, "onCharacterSelectionSuccess", client)
        else
            triggerClientEvent(client, "onCharacterSelectionSuccess", client, false, "No se pudo cargar el personaje.")
        end
    end
)
 ]]
 addEvent("onCharacterCreation", true)
 addEventHandler("onCharacterCreation", root, function(client)
     -- Verificar si el jugador ya tiene un personaje creado en la cuenta

     local accountId = getElementData(client, "cuenta_id")
     -- Consultar personajes vinculados a la cuenta
     local query = dbQuery(db, "SELECT * FROM personajes WHERE cuenta_id = ?", accountId)
     local result = dbPoll(query, -1)
     -- Enviar personajes al cliente
     triggerClientEvent(source, "onShowCharacterSelector", source, result or {})
 
 end)

addEvent("onLoginResponses", true)
addEventHandler("onLoginResponses", root, function(accountId, client)
    -- Consultar personajes vinculados a la cuenta
    local query = dbQuery(db, "SELECT * FROM personajes WHERE cuenta_id = ?", accountId)
    local result = dbPoll(query, -1)
    -- Enviar personajes al cliente
    triggerClientEvent(source, "onShowCharacterSelector", source, result or {})

end)

addEvent("onCreateCharacter", true)
addEventHandler("onCreateCharacter", root, function(name, age, gender, nationality,skin, password)
    local accountId = getElementData(client, "cuenta_id")

    if accountId then
        -- Verificar si ya existe un personaje con el mismo nombre
        local checkQuery = dbQuery(db, "SELECT * FROM personajes WHERE nombre_apellido = ? AND cuenta_id = ?", name,
            accountId)
        local result = dbPoll(checkQuery, -1)

        if result and #result > 0 then
            -- Si ya existe un personaje con ese nombre
            outputChatBox("Ya tienes un personaje con ese nombre. Elige otro.", client, 255, 0, 0)
    exports["MR-Notify"]:addNotification(client, "Ya tienes un personaje con ese nombre. Elige otro.", "error")

        else

            -- Crear el nuevo personaje
             if getAccount(name)then 
                outputChatBox("Ya existe una cuenta con ese nombre.", client, 255, 0, 0)
    exports["MR-Notify"]:addNotification(client, "Ya existe una cuenta con ese nombre.", "error")

                return
             end
            local accc = addAccount(name, password)
            local usp = getAccount(name, password) -- Return the account

            logIn(client, usp, password)

            if accc then
                local query = dbExec(db,
                    "INSERT INTO personajes (cuenta_id, nombre_apellido, edad, sexo, nacionalidad,Skin,pass) VALUES (?, ?, ?, ?,?,?,?)",
                    accountId, name, age, gender, nationality,skin, password)

                if query then
                    -- Establecer contraseña en la cuenta asociada
                    local accountName = getAccountName(getPlayerAccount(client))
                    if accountName then
                        local userAccount = getAccount(accountName)
                        if userAccount then
                            setAccountPassword(userAccount, password)
            print("Se ha creado una nueva cuenta"..name )
            exports["MR-Notify"]:addNotification(client, "Personaje creado exitosamente y contraseña configurada.", "error")

                            outputChatBox("Personaje creado exitosamente y contraseña configurada.", client, 0, 255, 0)
                            triggerClientEvent(client, "onCharacterCreationFinished", client)
                        else
            exports["MR-Notify"]:addNotification(client, "Error al crear la cuenta (F8 para mas detalles).", "error")

                            outputChatBox("Error al asociar la cuenta al personaje. Inténtalo nuevamente.", client,
                                255, 0, 0)
                        end
                    else
                        outputChatBox("Error al obtener la cuenta asociada. Inténtalo nuevamente.", client, 255, 0, 0)
            exports["MR-Notify"]:addNotification(client, "Error al crear la cuenta (F8 para mas detalles).", "error")

                    end

                    -- Opcional: Notificar al cliente que el personaje fue creado
                    triggerClientEvent(client, "onCharacterCreated", client)
                else
                    outputChatBox("Error al crear el personaje. Inténtalo nuevamente.", client, 255, 0, 0)
            exports["MR-Notify"]:addNotification(client, "Error al crear el personaje (F8 para mas detalles).", "error")

                end

            else
                outputChatBox("Error al crear el personaje. Inténtalo nuevamente.", client, 255, 0, 0)
            exports["MR-Notify"]:addNotification(client, "Error al crear el personaje (F8 para mas detalles).", "error")


            end
        end
    else
        outputChatBox("Error: No se pudo encontrar la cuenta.", client, 255, 0, 0)
        exports["MR-Notify"]:addNotification(client, "No se pudo encontrar la cuenta.", "error")

    end
end)
