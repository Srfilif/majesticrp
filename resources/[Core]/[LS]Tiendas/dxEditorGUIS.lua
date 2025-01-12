-- inventario.lua
local db = exports["MR-Gamemode"]:getDatabase() -- Obtener la conexión centralizada

addEventHandler("onResourceStart", resourceRoot, function()
    for _, v in ipairs(getElementsByType("player", root)) do
        bindKey(v, "i", "down", function(player)
            triggerClientEvent(player, "Open:Inventory", player, getPlayerItems(player))
        end)
    end

    -- Crear tabla de inventario si no existe
    
end)

addEventHandler("onPlayerLogin", getRootElement(), function()
    bindKey(source, "i", "down", function(player)
        triggerClientEvent(player, "Open:Inventory", player, getPlayerItems(player))
    end)
end)

-- Función para establecer un ítem para un jugador
function setPlayerItem(player, name, valor)
    if not db then
        return
    end

    local accont = getAccount(getPlayerName(player))
    local accountName = getAccountName(accont)
    local queryHandle = dbQuery(db, "SELECT * FROM Inventario WHERE Jugador=? AND Item=?", accountName, name)
    local result = dbPoll(queryHandle, -1)

    if not result or #result == 0 then
        -- Si no existe, insertar
        dbExec(db, "INSERT INTO Inventario (Jugador, Item, Value) VALUES (?, ?, ?)", accountName, name, valor)
    else
        if tonumber(valor) == 0 or tonumber(valor) < 0 then
            -- Si el valor es 0 o menor, eliminar
            dbExec(db, "DELETE FROM Inventario WHERE Jugador=? AND Item=?", accountName, name)
        else
            -- Actualizar el valor
            dbExec(db, "UPDATE Inventario SET Value=? WHERE Jugador=? AND Item=?", valor, accountName, name)
        end
    end
end

-- Función para obtener un ítem específico de un jugador
function getPlayerItem(player, name)
    if not db then
        return 0
    end

    local accont = getAccount(getPlayerName(player))
    local accountName = getAccountName(accont)
    local queryHandle = dbQuery(db, "SELECT Value FROM Inventario WHERE Jugador=? AND Item=?", accountName, name)
    local result = dbPoll(queryHandle, -1)

    if result and #result > 0 then
        return tonumber(result[1]["Value"])
    end
    return 0
end

-- Función para renombrar un ítem de un jugador
function getReNameItem(player, name, newname)
    if not db then
        return
    end

    local accountName = getAccountName(player)
    dbExec(db, "UPDATE Inventario SET Item=? WHERE Jugador=? AND Item=?", newname, accountName, name)
end

-- Función para obtener todos los ítems de un jugador
function getPlayerItems(player)
    if not db then
        return {}
    end

    local accont = getAccount(getPlayerName(player))
    local accountName = getAccountName(accont)
    local queryHandle = dbQuery(db, "SELECT * FROM Inventario WHERE Jugador=?", accountName)
    local result = dbPoll(queryHandle, -1)

    return result or {}
end

addEvent('Refresh:Inventory', true)
addEventHandler('Refresh:Inventory', root, function(name, valor)
    local pAccount = source:getAccount()
    if tonumber(valor) <= getPlayerItem(source, name) then

        local tipo, valor = table.find(Objetos, name)
       
        if name == "Caja de Cigarros" then
            if getPlayerItem(source, "Encendedor") >= 1 then
                source:setData("TextInfo", {"> Saca un cigarro y lo enciende", 255, 0, 216})
                setTimer(function(p)
                    p:setData("TextInfo", {"", 255, 0, 216})
                end, 3000, 1, source)
                source:setAnimation("GANGS", "drnkbr_prtl", 1, false, false)
                setPlayerItem(source, name, getPlayerItem(source, name) - 1)
                setPlayerItem(source, "Encendedor", getPlayerItem(source, "Encendedor") - 1)
            else
                exports['[LS]Notificaciones']:setTextNoti(source,
                    "Para fumar 1 cigarro debes tener un encendedor en tu inventario", 150, 50, 50, true)
            end
        end
		if name == "Cerveza" then
            if getPlayerItem(source, "Cerveza") >= 1 then
                source:setData("TextInfo", {"> Saca un cigarro y lo enciende", 255, 0, 216})
                setTimer(function(p)
                    p:setData("TextInfo", {"", 255, 0, 216})
                end, 3000, 1, source)
                source:setAnimation("GANGS", "drnkbr_prtl", 1, false, false)
                setPlayerItem(source, name, getPlayerItem(source, name) - 1)
                setPlayerItem(source, "Encendedor", getPlayerItem(source, "Encendedor") - 1)
            else
                exports['[LS]Notificaciones']:setTextNoti(source,
                    "Para fumar 1 cigarro debes tener un encendedor en tu inventario", 150, 50, 50, true)
            end
        end
        if name == "Bidon de Gasolina" then
            local veh = getPlayerNearbyVehicle(source)
            if veh then
                local gas = getElementData(veh, "Fuel")
                if gas <= 90 then
                    source:setData("TextInfo",
                        {"> Usa su bidon de gasolina y abre el tanque del vehículo para llenarlo", 255, 0, 216})
                    setTimer(function(p)
                        p:setData("TextInfo", {"", 255, 0, 216})
                    end, 2000, 1, source)
                    source:setAnimation("COP_AMBIENT", "Copbrowse_loop", -1, true, false, false)
                    setElementData(veh, "Fuel", 100)
                    setTimer(function(p, veh)
                        setPedAnimation(p)
                    end, 2000, 1, source, veh)
                    setPlayerItem(source, name, getPlayerItem(source, name) - 1)
                else
                    exports['[LS]Notificaciones']:setTextNoti(source, "Este vehiculo ya tiene la gasolina llena", 150,
                        50, 50, true)
                end
            end
        elseif name == "Caja de Herramientas" then
            local vehF = getPlayerNearbyVehicle(source)
            if vehF then
                local health = getElementHealth(vehF)
                if health < 900 then
                    local rx, ry, rz = getElementRotation(vehF)
                    source:setData("TextInfo",
                        {"> Usa su bidon de gasolina y abre el tanque del vehículo para llenarlo", 255, 0, 216})
                    setTimer(function(p)
                        p:setData("TextInfo", {"", 255, 0, 216})
                    end, 2000, 1, source)
                    source:setAnimation("COP_AMBIENT", "Copbrowse_loop", -1, true, false, false)
                    fixVehicle(vehF)
                    setElementRotation(vehF, 0, ry, rz)
                    setTimer(function(p, vehF)
                        setPedAnimation(p)
                    end, 2000, 1, source, vehF)
                    setPlayerItem(source, name, getPlayerItem(source, name) - 1)
                else
                    exports['[LS]Notificaciones']:setTextNoti(source, "Este vehiculo ya tiene toda la vida", 150, 50,
                        50, true)
                end
            end
        elseif name == "Ganzuas" then
            local vehG = getPlayerNearbyVehicle(source)
            if vehG then
                local locked = vehG:isLocked()
                if locked == true then
                    source:setAnimation('BD_FIRE', 'wash_up', -1, true, false, false)
                    vehG:setLocked(false)
                    setTimer(function(p, vehF)
                        setPedAnimation(p)
                    end, 10000, 1, source, vehF)
                    setPlayerItem(source, name, getPlayerItem(source, name) - 1)
                else
                    exports['[LS]Notificaciones']:setTextNoti(source, "Este vehiculo ya esta abierto", 150, 50, 50, true)
                end
            end
        elseif name == "Medicamentos" then
            local health = source:getHealth()
            if health <= 40 then
                source:setHealth(health + 10)
                exports['[LS]Notificaciones']:setTextNoti(source, "Acabas de consumir Medicamentos", 150, 50, 50, true)
            else
                exports['[LS]Notificaciones']:setTextNoti(source, "No puedes consumir mas medicamentos (+40% Vida)",
                    150, 50, 50, true)
            end
        end
        triggerClientEvent(source, 'Open:Inventory', source, getPlayerItems(source), 'refresh')
    end
end)

local armasValidas = {
    ["Colt 45"] = true,
    ["Silenced"] = true,
    ["Deagle"] = true,
    ["Shotgun"] = true,
    ["Combat Shotgun"] = true,
    ["Uzi"] = true,
    ["MP5"] = true,
    ["Tec-9"] = true,
    ["AK-47"] = true,
    ["M4"] = true,
    ["Rifle"] = true,
    ["Sniper"] = true
}

function getPlayerNearbyVehicle(player)
    if isElement(player) then
        for i, veh in ipairs(Element.getAllByType('vehicle')) do
            local vx, vy, vz = getElementPosition(veh)
            local px, py, pz = getElementPosition(player)
            if getDistanceBetweenPoints3D(vx, vy, vz, px, py, pz) < 3.5 then
                return veh
            end
        end
    end
    return false
end

Objetos = {
    ['hambre'] = {
        ["Pizzeta"] = 30,
        ["Pizza Chica"] = 20,
        ["Pizza Grande"] = 70,
        ["Hamburguesa"] = 15,
        ["Hamburguesa Chica"] = 10,
        ["Hamburguesa Grande"] = 25,
        ["Pata de Pollo"] = 10,
        ["Hamb. de Pollo"] = 15,
        ["Pollo Asado"] = 30,
        ["Galleta"] = 10
    },
    --
    ['bebida'] = {
        ["Cerveza"] = 10,
        ["Agua"] = 20,
        ["Lata de Spray"] = 30
    }
}
-- {"Caja de Cigarros", 50},
-- {"Encendedor", 25},
--

function table.find(t, item)
    for tipo, comida in pairs(t) do
        for index, value in pairs(comida) do
            if (index == item) then
                return tipo, value
            end
        end
    end
    return false
end

local items = {{"Telefono"}, {"Agenda"}, {"Camara"}, {"Bidon Vacio"}, {'Bidon de Gasolina'}, {'Caja de Herramientas'},
               {"Lata de Spray"}, {"Pizzeta"}, {"Pizza Chica"}, {"Pizza Grande"}, {"Ganzuas"}, --
{"Pata de Pollo"}, {"Hamb. de Pollo"}, {"Pollo Asado"}, --
{"Cerveza"}, {"Agua"}, {"Caja de Cigarros"}, {"Encendedor"}, --
{"Hamburguesa"}, {"Hamburguesa Chica"}, {"Hamburguesa Grande"}}

function isItemExist(itemName)
    for _, v in pairs(items) do
        if (v[1]:lower()) == (itemName:lower()) then
            return v[1]
        end
    end

    return false
end

local droppedItems = {} -- Tabla para manejar los ítems en el suelo

addEventHandler("onResourceStart", resourceRoot, function()
    local query = dbQuery(db, "SELECT * FROM objetos_suelo")
    local results = dbPoll(query, -1)

    if results then
        for _, row in ipairs(results) do
            -- Crear el objeto en el mundo
            local itemObject = Object(2969, row.x, row.y, row.z - 0.5)
            setElementInterior(itemObject, row.interior)
            setElementDimension(itemObject, row.dimension)

            local itemCol = createColSphere(row.x, row.y, row.z, 1.5)
            itemCol:setData("droppedItem", row.name)
            itemCol:setData("droppedAmount", row.amount)
            itemCol:setData("itemObject", itemObject)
            itemCol:setInterior(row.interior)
            itemCol:setDimension(row.dimension)

            table.insert(droppedItems, {
                object = itemObject,
                col = itemCol,
                id = row.id
            })
        end
    end
end)
-- Evento para tirar un ítem

addEvent("TiraItem:Inventory", true)
addEventHandler("TiraItem:Inventory", root, function(name, valor)
    if not name or not valor then
        return
    end

    local player = source
    local x, y, z = getElementPosition(player)
    local interior = player:getInterior()
    local dimension = player:getDimension()

    -- Si es un arma válida
    if armasValidas[name] then
        if tonumber(valor) <= 0 then
            takeWeapon(player, getWeaponIDFromName(name), 99999)
            triggerClientEvent(player, "Open:Inventory", player, getPlayerItems(player), "refresh")
            outputDebugString("Arma removida: " .. name)
            return
        end

        -- Crear el arma en el suelo
        exports["Weapons"]:createWeaponGround(getWeaponIDFromName(name), valor, x, y, z, interior, dimension)
        takeWeapon(player, getWeaponIDFromName(name), 99999)
        triggerClientEvent(player, "Open:Inventory", player, getPlayerItems(player), "refresh")
    else
        -- Si no es un arma, verificar si tiene suficiente cantidad
        local currentAmount = getPlayerItem(player, name)
        if tonumber(valor) <= currentAmount then
            setPlayerItem(player, name, currentAmount - tonumber(valor))

            -- Crear el objeto en el mundo
            local itemObject = Object(2969, x, y, z - 0.5)
            setElementInterior(itemObject, interior)
            setElementDimension(itemObject, dimension)

            local itemCol = createColSphere(x, y, z, 1.5)
            itemCol:setData("droppedItem", name)
            itemCol:setData("droppedAmount", tonumber(valor))
            itemCol:setData("itemObject", itemObject)
            itemCol:setInterior(interior)
            itemCol:setDimension(dimension)

            -- Guardar en la base de datos
            local query = string.format(
                "INSERT INTO objetos_suelo (name, amount, x, y, z, interior, dimension) VALUES ('%s', %d, %f, %f, %f, %d, %d)",
                name, tonumber(valor), x, y, z, interior, dimension)
            dbExec(db, query)

            -- Obtener el ID del ítem recién insertado
            local query = dbQuery(db, "SELECT LAST_INSERT_ID() AS id")
            local result = dbPoll(query, -1)
            local itemId = result[1] and result[1].id or nil

            -- Añadir a la tabla local si se obtuvo un ID válido
            if itemId then
                table.insert(droppedItems, {
                    object = itemObject,
                    col = itemCol,
                    id = itemId
                })
            end
            outputChatBox("#3d3dff[OBJETOS] #ffFFffHas tirado: #ffff3d" .. name .. " x" .. valor .. "#ffFFff al suelo.",
                player, 0, 255, 0, true)

            triggerClientEvent(player, "Open:Inventory", player, getPlayerItems(player), "refresh")
            
        else
            outputChatBox("#ff3d3d* No tienes suficientes de ese ítem.", player, 255, 0, 0, true)
        end
    end
end)

-- Evento para recoger un ítem
addEvent("RecogerItem:Inventory", true)
addEventHandler("RecogerItem:Inventory", root, function()
    local player = source
    local colFound = false

    for _, item in ipairs(droppedItems) do
        local col = item.col
        if isElementWithinColShape(player, col) then
            colFound = true
            local itemName = col:getData("droppedItem")
            local itemAmount = col:getData("droppedAmount")

            -- Añadir al inventario del jugador
            local currentAmount = getPlayerItem(player, itemName) or 0
            setPlayerItem(player, itemName, currentAmount + itemAmount)

            -- Eliminar el objeto del mundo
            local itemObject = col:getData("itemObject")
            if isElement(itemObject) then
                destroyElement(itemObject)
            end
            destroyElement(col)

            -- Eliminar de la tabla de droppedItems
            dbExec(db, "DELETE FROM objetos_suelo WHERE id = ?", item.id)
            for i, v in ipairs(droppedItems) do
                if v.col == col then
                    table.remove(droppedItems, i)
                    break
                end
            end

            outputChatBox("#3d3dff[OBJETOS] #ffFFffHas recogido: #ffff3d" .. itemName .. " x" .. itemAmount ..
                              "#ffFFff del suelo.", player, 0, 255, 0, true)
            break
        end
    end

    if not colFound then
        outputChatBox("#ff3d3d* No hay ítems cerca para recoger.", player, 255, 0, 0, true)
    end
end)



---- personaje


-- Función para obtener jugadores cercanos
function getNearbyPlayers(player, radius)
    local x, y, z = getElementPosition(player)
    local nearbyPlayers = {}
    
    for _, otherPlayer in ipairs(getElementsByType("player")) do
        if otherPlayer ~= player then
            local ox, oy, oz = getElementPosition(otherPlayer)
            if getDistanceBetweenPoints3D(x, y, z, ox, oy, oz) <= radius then
                table.insert(nearbyPlayers, otherPlayer)
            end
        end
    end
    return nearbyPlayers
end

-- Evento para abrir el selector de jugadores cercanos
-- Evento para abrir el selector de jugadores cercanos
addEvent("Open:NearbyPlayersSelector", true)
addEventHandler("Open:NearbyPlayersSelector", root, function(itemName, itemAmount)
    local player = source
    local nearbyPlayers = getNearbyPlayers(player, 10) -- Radio de 10 metros
    local playerList = {}
    
    for _, otherPlayer in ipairs(nearbyPlayers) do
        table.insert(playerList, {name = getPlayerName(otherPlayer), element = otherPlayer})
    end
    
    triggerClientEvent(player, "Show:NearbyPlayersSelector", player, playerList, itemName, itemAmount)
end)

-- Evento para transferir el ítem
addEvent("GiveItemToPlayer", true)
addEventHandler("GiveItemToPlayer", root, function(targetPlayer, itemName, itemAmount)
    local player = source
    if not isElement(targetPlayer) or getElementType(targetPlayer) ~= "player" then
        outputChatBox("#ff3d3d* El jugador seleccionado no es válido.", player, 255, 0, 0,true)
        return
    end
    
    -- Verificar si el jugador tiene suficientes ítems
    local currentAmount = getPlayerItem(player, itemName) or 0
    if tonumber(itemAmount) > currentAmount then
        outputChatBox("#ff3d3d* No tienes suficientes de este ítem.", player, 255, 0, 0,true)
        return
    end
    
    -- Restar el ítem del jugador que da
    setPlayerItem(player, itemName, currentAmount - tonumber(itemAmount))
    
    -- Añadir el ítem al jugador objetivo
    local targetAmount = getPlayerItem(targetPlayer, itemName) or 0
    setPlayerItem(targetPlayer, itemName, targetAmount + tonumber(itemAmount))
    
    -- Notificar a ambos jugadores
    outputChatBox("#3d3dff[OBJETOS] #ffFFfHas dado #ffff3d" .. itemAmount .. "x " .. itemName .. "#ffFFff a el jugador #ffff3d" .. getPlayerName(targetPlayer) .. "#FFffFF.", player, 0, 255, 0,true)
    outputChatBox("#3d3dff[OBJETOS] #ffFFfEl jugador #ffff3d"..getPlayerName(player) .. "#ffFFff te ha dado #ffff3d" .. itemAmount .. "x " .. itemName .. "#fffFFf.", targetPlayer, 0, 255, 0,true)
end)
