loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')

local MarkersJardinero = {}

addEventHandler("onResourceStart", resourceRoot, function()

    for i, v in ipairs(getJobsJardinero()) do

        --

        Blip(v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement())

        --

        Pickup(v[1], v[2], v[3], 3, 1210, 0)

        MarkersJardinero[i] = Marker(v[1], v[2], v[3] - 1, "cylinder", 1.5, 100, 100, 100, 0)

        MarkersJardinero[i]:setInterior(v.int)

        MarkersJardinero[i]:setDimension(v.dim)

        MarkersJardinero[i]:setData("MarkerJob", "Jardinero")

    end

end)
addCommandHandler("trabajar", function(player, cmd)
    -- Verificar que el jugador no esté en un vehículo
    if player:isInVehicle() then
        player:outputChat("#ff3d3dNo puedes comenzar a trabajar mientras estás en un vehículo.", 255, 255, 255, true)
        return
    end

    -- Iterar a través de los marcadores de trabajo
    for _, marker in ipairs(MarkersJardinero) do
        if player:isWithinMarker(marker) then
            local mjob = marker:getData("MarkerJob")

            -- Verificar si el marcador corresponde al trabajo "Jardinero"
            if mjob == "Jardinero" then
                local currentJob = player:getData("Roleplay:trabajo") or ""

                if currentJob == "Obrero" then
                    -- El jugador ya tiene el trabajo de "Obrero"
                    player:outputChat("¡Ya estás trabajando aquí!", 150, 50, 50, true)
                    removeElementData(player, "objeto")
                    removeElementData(player, "silla")
                elseif currentJob == "" then
                    -- El jugador no tiene ningún trabajo, asignar el trabajo de "Jardinero"
                    player:setData("Roleplay:trabajo", "Obrero")
                    player:outputChat("¡Bienvenido al trabajo de #ffff00Carpintero#ffffff!", 255, 255, 255, true)
                    removeElementData(player, "objeto")
                    removeElementData(player, "silla")
                else
                    -- El jugador ya tiene otro trabajo
                    player:outputChat("#ff3d3dNo puedes trabajar aquí. Ya tienes otro trabajo.", 255, 255, 255, true)
                end

                return -- Salir del bucle una vez que se encuentra el marcador correcto
            end
        end
    end

    -- Si no se encuentra un marcador relevante
end)

addCommandHandler("infoobrero", function(player, cmd)

    if not notIsGuest(player) then

        if not player:isInVehicle() then

            for i, v in ipairs(MarkersJardinero) do

                if player:isWithinMarker(v) then

                    local job = v:getData("MarkerJob")

                    if job == "Jardinero" then

                        player:outputChat("¡Bienvenidos al trabajo de #ffff00Obrero#ffffff!", 255, 255, 255, true)
                        player:outputChat("#ffFFff", 255, 255, 255, true)
                        player:outputChat("Tu trabajo es recoger los escombros que quedan de esta construccion", 255,
                            255, 255, true)
                        player:outputChat(
                            "para empezar a trabajar usa #00ff00/trabajar #ffFFffy para dejar de trabajar #ff0000/dejartrabajar",
                            255, 255, 255, true)
                    end

                end

            end

        end
    end

end)

local mPala = createMarker(1265.951171875, -1269.0361328125, 13.479056358337, 'cylinder', 1.0, 20, 100, 150, 0)
local PPala = Pickup(1265.951171875, -1269.0361328125, 13.479056358337, 2, 6, 0, 0)

local circlearea = createColCuboid(1221.837890625, -1274.693359375, 13.3828125 - 3, 65, 50, 20)

local spawns = {{1253.564453125, -1262.3994140625, 13.27038192749 - 1},
                {1257.3125, -1256.4677734375, 13.092193603516 - 1},
                {1261.5029296875, -1259.5107421875, 13.183612823486 - 1},
                {1273.9296875, -1257.8798828125, 13.978246688843 - 1},
                {1276.287109375, -1248.2646484375, 14.51598072052 - 1},
                {1270.740234375, -1242.0263671875, 16.402158737183 - 1},
                {1261.2568359375, -1239.208984375, 17.074718475342 - 1},
                {1253.546875, -1241.697265625, 17.982662200928 - 1},
                {1249.091796875, -1244.7373046875, 16.412010192871 - 1},
                {1243.3388671875, -1246.8984375, 14.541511535645 - 1},
                {1237.1298828125, -1251.6435546875, 14.607089042664 - 1}}

-- Droptable para ítems que los jugadores pueden obtener
local dropTable = {{
    item = "Colt 45",
    probability = 10,
    minAmount = 1,
    maxAmount = 17
}, -- Ejemplo: 40% para obtener 1 Pala
{
    item = "AK-47",
    probability = 10,
    minAmount = 1,
    maxAmount = 30
}, -- Ejemplo: 20% para 10-30 balas de AK-47
{
    item = "M4",
    probability = 10,
    minAmount = 10,
    maxAmount = 20
}, {
    item = "Materiales",
    probability = 40,
    minAmount = 10,
    maxAmount = 100
}, -- Ejemplo: 15% para 10-20 balas de M4
{
    item = "Dinero",
    probability = 30,
    minAmount = 50,
    maxAmount = 150
} -- Ejemplo: 25% para obtener dinero
}

local playerData = {} -- Tabla para almacenar datos específicos de cada jugador

-- Función para obtener un drop aleatorio basado en las probabilidades
local function getRandomDrop()
    local totalProbability = 0
    for _, drop in ipairs(dropTable) do
        totalProbability = totalProbability + drop.probability
    end

    local randomChance = math.random(1, totalProbability)
    local currentSum = 0

    for _, drop in ipairs(dropTable) do
        currentSum = currentSum + drop.probability
        if randomChance <= currentSum then
            local amount = math.random(drop.minAmount, drop.maxAmount)
            return drop.item, amount
        end
    end
    return nil, 0 -- Retorna nil si no se encuentra un drop (aunque no debería ocurrir)
end

function laburar(player)
    if playerData[player] and playerData[player].Marker then
        outputChatBox("#ffda0a[OBRERO] #ffFFffYa estás trabajando en un punto, espera a terminar para obtener otro.",
            player, 255, 255, 255, true)
        return
    end
    if not playerData[player] then

        outputChatBox("#ffda0a[OBRERO] #ffFFffEmpezaste a laburar, ve al punto marcado en el mapa.", player, 255, 255,
            255, true)

    end

    local rLine = math.random(1, #spawns)
    local Marker2 = createMarker(spawns[rLine][1], spawns[rLine][2], spawns[rLine][3], 'cylinder', 2.0, 255, 0, 0, 100,
        player)
    local Blip = createBlipAttachedTo(Marker2, 0, 2, 255, 0, 0, 255, 0, 500000, player)
    local basura = createObject(849, spawns[rLine][1], spawns[rLine][2], spawns[rLine][3])

    playerData[player] = {
        Marker = Marker2,
        Blip = Blip,
        Basura = basura
    }

    local function TestMarker(hitPlayer, matchingDimension)
        if hitPlayer == player and matchingDimension then
            if getElementData(player, "Roleplay:trabajo") == "Obrero" then
                local weaponType = getPedWeapon(player)
                if weaponType == 6 then -- Verificar si el jugador tiene una pala
                    triggerClientEvent("play_shop_sound1", player)

                    outputChatBox(
                        "#ffda0a[OBRERO] #ffFFffEmpezaste a quitar los escombros de este punto, espera #00ff0010 segundos",
                        player, 255, 255, 255, true)
                    moveObject(basura, 10000, spawns[rLine][1], spawns[rLine][2], spawns[rLine][3] - 1)
                    setPedAnimation(player, "BASEBALL", "Bat_4", 10000, true, false, false, false)

                    setTimer(function()
                        local money = math.random(100, 500)
                        givePlayerMoney(player, money)
                        outputChatBox("#ffda0a[OBRERO] #ffFFffTerminaste de quitar los escombros de este punto", player,
                            255, 255, 255, true)
                        outputChatBox("#ffda0a[OBRERO] #ffFFffGanaste en Total #00ff00$" .. money ..
                                          " Dólares#ffFFff Por tu trabajo", player, 255, 255, 255, true)
                        local item, amount = getRandomDrop()
                        if item then
                            if item == "Dinero" then
                                givePlayerMoney(player, amount)
                                outputChatBox("#ffda0a[OBRERO] #ffFFffHas obtenido #00ff00$" .. amount ..
                                                  " #ffFFffde tu trabajo.", player, 255, 255, 255, true)
                            elseif item == "AK-47" then
                                giveWeapon(player, getWeaponIDFromName(item), amount, false)

                                outputChatBox("#ffda0a[OBRERO] #ffFFffHas obtenido una #ffff00 " .. item ..
                                                  "#ffFFff Con #00ff00" .. amount .. "#ffFFff bala(s).", player, 255,
                                    255, 255, true)
                            elseif item == "Materiales" then

                                local mactuales = getElementData(player, "Roleplay:Materiales") or 0
                                setElementData(player, "Roleplay:Materiales", mactuales + amount)
                                outputChatBox("#ffda0a[OBRERO] #ffFFffHas obtenido #00ff00" .. amount ..
                                                  " #ffFFffmateriales de tu trabajo.", player, 255, 255, 255, true)

                            else
                                outputChatBox("#ffda0a[OBRERO] #ffFFffHas obtenido #00ff00" .. amount .. " " .. item ..
                                                  "(s)#ffFFff.", player, 255, 255, 255, true)
                                -- Aquí puedes manejar la lógica de dar ítems, como un arma
                                giveWeapon(player, getWeaponIDFromName(item), amount, false)
                            end
                        end

                        -- Limpiar el trabajo actual
                        destroyElement(playerData[player].Marker)
                        destroyElement(playerData[player].Blip)
                        destroyElement(playerData[player].Basura)
                        playerData[player] = nil

                        -- Crear un nuevo punto de trabajo
                        laburar(player)
                    end, 10000, 1)
                else
                    outputChatBox("#ffda0a[OBRERO] #ff3d3dNo tienes una pala ¿Cómo piensas trabajar?", player, 255,
                        255, 255, true)
                end
            end
        end
    end

    addEventHandler("onMarkerHit", Marker2, TestMarker)
end

addEventHandler("onPlayerQuit", root, function()
    if playerData[source] then
        destroyElement(playerData[source].Marker)
        destroyElement(playerData[source].Blip)
        destroyElement(playerData[source].Basura)
        playerData[source] = nil
    end
end)

function dlaburar(player)
    if playerData[player] then
        destroyElement(playerData[player].Marker)
        destroyElement(playerData[player].Blip)
        destroyElement(playerData[player].Basura)
        playerData[player] = nil
        outputChatBox("#ff3d3d* Has dejado de trabajar", player, 255, 255, 255, true)

    else
        outputChatBox("#ff3d3d* No estas trabajando", player, 255, 255, 255, true)

    end
end

addCommandHandler("dejarlaburar", dlaburar)
addCommandHandler("laburar", laburar)

function ColShapeHit(thePlayer, matchingDimension)
    local detection = isElementWithinColShape(thePlayer, circlearea)
    -- A variable called 'detection' stores the result of asking if the player
    -- who entered a colshape is within the specific colshape called 'circlearea'.
    -- The result is either true or false.
    detection = detection and getElementDimension(thePlayer) == getElementDimension(circlearea)
    -- Let's additionally check element dimensions.
    if detection then
        -- outputChatBox ( getPlayerName(thePlayer).." is in the 'circle area' col shape" )
        setElementData(thePlayer, "Obrero-Area", 1)
        --	 local InArea = setElementData(source,"Obrero-Area") or 0
        -- outputChatBox(""..InArea.."")
    else
        -- outputChatBox("Out Of Area",root)
    end
    -- if detection was true then the player is in the col shape. Output a
    -- message to confirm this
end
addEventHandler("onColShapeHit", root, ColShapeHit)

function jailZoneLeave(thePlayer)
    if getElementType(thePlayer) == "player" then -- if the element that left was player
        --     killPlayer ( thePlayer ) -- kill the player
        -- outputChatBox ( "You are not allowed to leave the jail!", thePlayer )
        --  setElementData(source,"Obrero-Area",0)
        setElementData(thePlayer, "Obrero-Area", 0)
        takeWeapon(thePlayer, 6)
        if playerData[thePlayer] then
            destroyElement(playerData[thePlayer].Marker)
            destroyElement(playerData[thePlayer].Blip)
            destroyElement(playerData[thePlayer].Basura)
            playerData[thePlayer] = nil
        end
        local InArea = getElementData(thePlayer, "Obrero-Area")
        --  outputChatBox(""..InArea.."")
    end
end
addEventHandler("onColShapeLeave", circlearea, jailZoneLeave)

function OPala(source)
    if isElementWithinMarker(source, mPala) then
        local InArea = getElementData(source, "Obrero-Area")
        if InArea == 1 then
            giveWeapon(source, 6, 1)
            --  outputChatBox("#ffda0a[OBRERO]#ffFFffRecogiste tu pala111111111111111 ",source,255,255,255,true)
            outputChatBox("#ffda0a[OBRERO]#ffFFffRecogiste tu pala ", source, 255, 255, 255, true)
        end
    else
        outputChatBox("#ffda0a[OBRERO]#ff3d3dNo estas en el lugar para recoger tu pala", source, 255, 255, 255, true)
    end
end
addCommandHandler("pala", OPala)

addCommandHandler("renunciar", function(player, cmd)

    if not player:isInVehicle() then

        --	if player:getData("Roleplay:trabajo") ~="" then

        for i, v in ipairs(MarkersJardinero) do

            if player:isWithinMarker(v) then

                local job = v:getData("MarkerJob")

                if job == "Jardinero" then
                    if player:getData("Roleplay:trabajo") == "" then
                        player:outputChat("¡No tienes trabajo, Consigue uno VAGO!!", 150, 50, 50, true)

                    else
                        if player:getData("Roleplay:trabajo") == "Obrero" then

                            player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)

                            player:setData("Roleplay:trabajo", "")

                        else

                            player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50,
                                50, true)

                            player:outputChat("Tu trabajo actual es de: #ffff00" .. player:getData("Roleplay:trabajo"),
                                255, 255, 255, true)
                        end

                    end

                end

            end

        end

        -- end

    end

end)

addEvent("giveMoneyJardinero", true)

function giveMoneyJardinero()

    local propinarandom = math.random(1, 8)

    local exp = source:getData("Roleplay:ExpJobJardinero") or 1

    local totalMoney = math.ceil(math.random(150, 200) * exp)

    --

    local malasuerte = math.random(1, 6)

    text = "#FFFFFFAcabas de ganar: #004500$" .. convertNumber(totalMoney) .. " dólares #ffffff por cosechar."

    source:giveMoney(tonumber(totalMoney))

    source:outputChat(text, 255, 255, 255, true)

end

addEventHandler("giveMoneyJardinero", root, giveMoneyJardinero)

addEvent("drogas", true)
function drogas()
    local suerte = math.random(1, 10)
    local exp = source:getData("Roleplay:ExpJobJardinero") or 1
    local mate = source:getData("semilla") or 0
    local mat = math.ceil(math.random(1, 6))
    local mati = mate + mat
    print(mat)
    if suerte == 2 then
        text = "#FFFFFFAcabas de Encontrar: #FF0000" .. convertNumber(mat) .. " semillas #ffffff al cosechar."
        source:setData("semilla", mati)
    else
        text = ""
    end
end
addEventHandler("drogas", root, drogas)

addEvent("giveJardineroExp", true)

function giveJardineroExp()
    local suerte = math.random(1, 7)
    local exp = source:getData("Roleplay:ExpJobJardinero") or 1
    local exp1 = math.random(1, 2)
    local exp2 = exp1 + exp
    if (exp2 <= 20) then
        if suerte == 2 then
            text = "Acabas de obtener #E511E8" .. exp1 .. " #ffffffexperiencia por trabajar."
            source:setData("Roleplay:ExpJobJardinero", exp2)
        else
            text = ""
        end
        source:outputChat(text, 255, 255, 255, true)
    else
        source:outputChat("Has llegado a #E511E8 20 #ffffffde experiencia que es el maximo", 255, 255, 255, true)
    end

end

addEventHandler("giveJardineroExp", root, giveJardineroExp)

