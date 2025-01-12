-- Obtener la conexión a la base de datos
local db = exports["MR-Gamemode"]:getDatabase() -- Asegúrate de que el recurso tenga la exportación configurada

-- Verifica si un jugador es invitado
function notIsGuest(player)
    local account = player:getAccount()
    return not account or isGuestAccount(account)
end

-- Función para cargar los datos del inventario desde la base de datos
function loadPlayerData(player)
    if not db or not player then return end

    local accountName = getAccountName(getAccount(getPlayerName(player)))
    if not accountName then return end

    -- Cargar datos del inventario
    local queryHandle = dbQuery(db, "SELECT Item, Value FROM Inventario WHERE Jugador=?", accountName)
    local result = dbPoll(queryHandle, -1)

    if result and #result > 0 then
        for _, row in ipairs(result) do
            player:setData("Inventory:" .. row.Item, row.Value)
        end
    end
end

-- Función para guardar los datos del inventario en la base de datos
function savePlayerData(player)
    if not db or not player  then return end

    local accountName = getAccountName(getAccount(getPlayerName(player)))
    if not accountName then return end

    -- Guardar datos del inventario
    for key, value in pairs(player:getAllData()) do
        if key:sub(1, 10) == "Inventory:" then
            local itemName = key:sub(11) -- Extraer el nombre del ítem
            local itemValue = tonumber(value) or 0

            if itemValue > 0 then
                dbExec(db, "INSERT INTO Inventario (Jugador, Item, Value) VALUES (?, ?, ?) ON CONFLICT(Item) DO UPDATE SET Value=?", accountName, itemName, itemValue, itemValue)
            else
                dbExec(db, "DELETE FROM Inventario WHERE Jugador=? AND Item=?", accountName, itemName)
            end
        end
    end
end

-- Evento al iniciar sesión
addEventHandler("onPlayerLogin", root, function()
    if not notIsGuest(source) then
        loadPlayerData(source)
    end
end)

-- Evento al guardar datos al salir
function quitPlayerData()
    if not notIsGuest(source) then
        savePlayerData(source)
    end
end
addEventHandler("onPlayerQuit", root, quitPlayerData)

-- Guardar todos los datos al detener el recurso
function saveAllPlayerData()
    for _, player in ipairs(getElementsByType("player")) do
        if not notIsGuest(player) then
            savePlayerData(player)
        end
    end
end
addEventHandler("onResourceStop", resourceRoot, saveAllPlayerData)
