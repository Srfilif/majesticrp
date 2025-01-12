local db = exports["MR-Gamemode"]:getDatabase()
local cooldowns = {} -- Tabla para almacenar los tiempos de cooldown

-- Comando /duda
addCommandHandler("duda", function(player, _, ...)
    local dudaTexto = table.concat({...}, " ") -- Obtener el texto de la duda
    if dudaTexto == "" or dudaTexto == nil then
        outputChatBox("#ff3d3d* Debes escribir el texto de tu duda después del comando.", player, 255, 0, 0, true)
        return
    end

    local playerAccount = getPlayerAccount(player)
    if isGuestAccount(playerAccount) then
        outputChatBox("#ff3d3d* Debes estar logueado para enviar una duda.", player, 255, 0, 0, true)
        return
    end

    local accountName = getAccountName(playerAccount)
    local currentTime = getRealTime().timestamp

    -- Verificar cooldown
    if cooldowns[accountName] and (currentTime - cooldowns[accountName]) < 300 then
        local remainingTime = 300 - (currentTime - cooldowns[accountName])
        outputChatBox("#ff3d3d* Debes esperar " .. math.ceil(remainingTime) .. " segundos antes de enviar otra duda.", player, 255, 0, 0, true)
        return
    end

    local playerName = getPlayerName(player)
    local acc_id = getElementData(player, "cuenta_id")
    local fecha = currentTime

    -- Consulta para insertar la duda en la base de datos
    local query = [[
        INSERT INTO dudas (nombre_usuario, duda, fecha, account_id)
        VALUES (?, ?, ?, ?)
    ]]

    dbExec(db, query, playerName, dudaTexto, fecha, acc_id)

    -- Registrar el tiempo del último envío en la tabla cooldowns
    cooldowns[accountName] = currentTime

    -- Enviar mensaje de confirmación al jugador
    outputChatBox("#00ff00* Tu duda ha sido enviada correctamente. Un administrador te responderá pronto.", player, 0, 255, 0, true)

    -- Notificar a todos los jugadores en el grupo ACL "Admin"
    for _, adminPlayer in ipairs(getElementsByType("player")) do
        if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(adminPlayer)), aclGetGroup("Admin")) then
            outputChatBox("#fc7f03[DUDAS] #ffFFffNueva duda del jugador: #ffFF3d" .. playerName .. "#FFFFff | Duda: " .. dudaTexto, adminPlayer, 0, 0, 255, true)
        end
    end
end)


-- Comando /verdudas
addCommandHandler("verdudas", function(player)
    if not isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup("Admin")) then
        outputChatBox("#ff3d3d* Este comando es solo para administradores.", player, 255, 0, 0, true)
        return
    end

    -- Consultar dudas pendientes (sin respuesta)
    dbQuery(function(queryHandle)
        local results = dbPoll(queryHandle, 0)
        if not results or #results == 0 then
            outputChatBox("#ff3d3d* No hay dudas pendientes.", player, 255, 0, 0, true)
            return
        end
        outputChatBox("#ffFFff", player, 0, 255, 0, true)

        outputChatBox("#fc5e03  ========= LISTA DE DUDAS =========  ", player, 0, 255, 0, true)
          
        for _, row in ipairs(results) do
            outputChatBox("#ffFFffID: " .. row.id .. " |#ffff3d " .. row.nombre_usuario .. "#ffFFff |Duda: " .. row.duda, player, 255, 255, 255, true)
        end
        outputChatBox("#ffFFff", player, 0, 255, 0, true)

    end, db, "SELECT id, nombre_usuario, duda FROM dudas WHERE respuesta IS NULL OR respuesta = ''")
end)


-- Comando /responderduda
addCommandHandler("responderduda", function(player, _, id, ...)
    if not isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(player)), aclGetGroup("Admin")) then
        outputChatBox("#ff3d3d* Este comando es solo para administradores.", player, 255, 0, 0, true)
        return
    end

    if not id or tonumber(id) == nil or not ... then
        outputChatBox("#ff3d3d* Uso: /responderduda [ID DUDA] [Respuesta]", player, 255, 0, 0, true)
        return
    end

    local respuesta = table.concat({...}, " ")
    local idDuda = tonumber(id)

    -- Verificar si la duda ya está respondida
    dbQuery(function(queryHandle)
        local results = dbPoll(queryHandle, 0)
        if not results or #results == 0 then
            outputChatBox("#ff3d3d* No se encontró ninguna duda con ese ID.", player, 255, 0, 0, true)
            return
        end

        local duda = results[1]
        if duda.respuesta and duda.respuesta ~= "" then
            outputChatBox("#ff3d3d* Esta duda ya ha sido respondida.", player, 255, 0, 0, true)
            return
        end

        local acc_id = duda.account_id
        local dudaTexto = duda.duda
        local staffid = getElementData(player,"character_id")
        -- Actualizar la duda con la respuesta
        dbExec(db, "UPDATE dudas SET respuesta = ?, staff = ? WHERE id = ?", respuesta,staffid, idDuda)

        -- Notificar al administrador
        outputChatBox("#fc7f03[DUDAS] #ffFFffHas respondido la duda con ID #ffff3d" .. idDuda .. "#ffFFff correctamente.", player, 0, 255, 0, true)

        -- Buscar al jugador que hizo la duda por su account_id
        for _, targetPlayer in ipairs(getElementsByType("player")) do
            if tonumber(getElementData(targetPlayer, "cuenta_id")) == tonumber(acc_id) then
                outputChatBox("#fc7f03[DUDAS] #ffFFffEl staff #ffff3d"..getPlayerName ( player ).."#ffFFff  ha respondido tu duda: " .. dudaTexto, targetPlayer, 0, 255, 0, true)
                outputChatBox("#fc7f03[DUDAS] #ffFFffRespuesta: #ffff3d" .. respuesta.."#ffFFff.", targetPlayer, 0, 255, 0, true)
                return
            end
        end

        -- Si el jugador no está conectado
        outputChatBox("#ff3d3d* El jugador que hizo la duda no está conectado.", player, 255, 0, 0, true)
    end, db, "SELECT * FROM dudas WHERE id = ?", idDuda)
end)
