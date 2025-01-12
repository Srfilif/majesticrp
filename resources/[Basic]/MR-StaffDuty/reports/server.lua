local db = exports["MR-Gamemode"]:getDatabase()

addEvent("guardarReporte", true)
addEventHandler("guardarReporte", resourceRoot, function(player, reporteTexto)
    local playerName = getPlayerName(player) -- Nombre del jugador
    local playerAccount = getPlayerAccount(player) -- Obtener la cuenta del jugador
    local playerNameAccount = getAccountName(playerAccount) -- Obtener el nombre de la cuenta

    -- Conexión a la base de datos

    -- Consulta para insertar el reporte en la base de datos
    local query = [[
            INSERT INTO reportes (nombre_usuario, reporte, fecha, account_id)
            VALUES (?, ?, ?, ?)
        ]]

    -- Obtener la fecha actual
    local fecha = getRealTime().timestamp
    local acc_id = getElementData(player, "cuenta_id")
    -- Ejecutar la consulta para insertar el reporte
    dbExec(db, query, playerNameAccount, reporteTexto, fecha, acc_id)

    -- Enviar mensaje de confirmación al jugador
    outputChatBox("#ffFFff* Tu reporte ha sido enviado correctamente a nuestro equipo", player, 255, 245, 255, true)
    outputChatBox("#ffFFff* Tiempo estimado #ffff3d1-3 minutos #ffFFff| #00ff000 #ffFFffstaffs contactados", player,
        255, 245, 255, true)

    for _, adminPlayer in ipairs(getElementsByType("player")) do
        if isObjectInACLGroup("user." .. getAccountName(getPlayerAccount(adminPlayer)), aclGetGroup("Admin")) then
            outputChatBox("#fc7f03[REPORTES] #ffFFffNuevo reporte: #ffFF3d" .. playerName ..
                              "#ffFFff | #ffFFffReporte: " .. reporteTexto, adminPlayer, 255, 0, 0, true)
        end
    end

end)
