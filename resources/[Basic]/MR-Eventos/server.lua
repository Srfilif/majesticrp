------------------------------------------------------------------------------------
--  PROJECT:     Community of Social For Fun
--  RIGHTS:      All rights reserved by developers
--  FILE:        CSTevents/CSTevents_warp.slua
--  PURPOSE:     Warping for events
--  DEVELOPERS:  HouSsam<3
------------------------------------------------------------------------------------

eventMax = 50000
warp_warpedUsers = {}
warp_savePos = {}
warp_warpLimit = 0
warp_warps = 0
warp_event = false
wapx, wapy, wapz = 0, 0, 0
warp_dimension = 0
warp_interior = 336
warp_wantedStarsLimit = 1
warp_allowMultiple = false
warp_vipOnly = false
forbidJobTeams = nil
jobTeams = {}
warp_freeze = false
local eventDimension = 366
clientFeatures = {}
eventDimFeatures = {}
booleanList = {}
peopleWhoCanUseEventJetpack = {}
local actionAmount = 27
for i=1,actionAmount do
    booleanList[i] = false
end
--- BOOLEANLIST INFO ---
--1 = Freeze players
--2 = Freeze vehicles
--3 = Lock vehicles
--4 = Disable falling from bike
--5 = Disable shooting
--6 = Not synced, useless
--7 = Disable player damage
--8 = Disable vehicle damage

function onResourceStart()
    for k, v in ipairs(getElementsByType("player")) do
        if (getElementData(v, "e")) then
            removeElementData(v, "e")
        end
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onResourceStart)

function openEventPanel(source)
	local accName = getAccountName(getPlayerAccount(source)) 
	if (isElement(source) and getElementType(source) == "player") then
		if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
			triggerClientEvent(source, "showEMW", source, booleanList, warp_event, {warp_warps, warp_warpLimit})
		else
			outputChatBox("[ERROR] No tienes acceso a este panel!", source, 255, 0, 0)
		end
	end
end
addCommandHandler("eventm", openEventPanel)

function createEvent(player, limit, mul, vip, freeze, jtlist, forbid, pos)
	if (tonumber(limit)) then
		if (warp_event) then 
            outputChatBox("There is already an event going on. If this is an error, please hit stop event.", player, 255, 0, 0) 
            return 
        end
        wapx, wapy, wapz = pos[1], pos[2], pos[3]
        warp_dimension = pos[4]
        warp_interior = pos[5]
        warp_warpLimit = tonumber(limit)
        warp_warpedUsers = {}
        warp_savePos = {}
        warp_warps = 0
        warp_event = true
        warp_allowMultiple = mul
        warp_vipOnly = vip
        warp_freeze = freeze
        booleanList[1] = freeze
        forbidJobTeams = forbid
        jobTeams = jtlist
        if (tonumber(limit) > 0) then
            if (vip) then
                outputChatBox("A VIP only event has been created, type /eventwarp to be warped to the event ( limit: "..limit.." )", root, 0, 255, 0, true)
            else
                outputChatBox("Un evento fue creado!, Coloca /eventwarp para ser warpeado al evento ( cupos: "..limit.." )", root, 0, 255, 0, true)
            end
        else
            outputChatBox("You've created a testing eventwarp, to add people to the event use /event add", player, 0, 255, 0, true)
        end
    end
end

function preCreateEvent(limit, mul, vip, freeze, jtlist, forbid)
    local x, y, z = getElementPosition(client)
    local dim = getElementDimension(client)
    local int = getElementInterior(client)
    outputChatBox("[EVENT MANAGER] El eventwarp sera creado en 5 segundos", client, 0, 255, 0)
    setTimer(createEvent, 5000, 1, client, limit, mul, vip, freeze, jtlist, forbid, {x, y, z, dim, int})
end
addEvent("CSTevents.PreCreateEvent", true)
addEventHandler("CSTevents.PreCreateEvent", root, preCreateEvent)

function stopEvent(player)
    if (warp_event) then
        returnPlayersToLastLocation()
        warp_warpedUsers = {}
        warp_savePos = {}
        warp_warpLimit = 0
        warp_warps = 0
        warp_event = false
        warp_allowMultiple = false
        warp_vipOnly = false
        warp_freeze = false
        warp_aJT = nil
        warp_fJT = nil
        resetRaceStuff()
        outputChatBox("[EVENT MANAGER] Evento detenido", client, 255, 0, 0)
    end
end
addEvent("CSTevents.StopEvent", true)
addEventHandler("CSTevents.StopEvent", root, stopEvent)

function returnPlayersToLastLocation(player)
    if (player) then
        local accName = getAccountName(getPlayerAccount(player))
        if (not warp_savePos[accName]) then
            killPed(player)
            outputChatBox("No tienes posicion anterior!, se te dara kill instantaneamente", player, 0, 255, 255)
        else
            if (isPedWearingJetpack(player)) then setPedWearingJetpack(player, false) end
            if (isPedInVehicle(player)) then removePedFromVehicle(player) end
            local px, py, pz = warp_savePos[accName][1], warp_savePos[accName][2], warp_savePos[accName][3]
            local pint = warp_savePos[accName][4]
            local pdim = warp_savePos[accName][5]
            setElementInterior(player, pint)
            setElementPosition(player, px, py, pz)
            setElementDimension(player, pdim)
            toggleAllControls(player, true)
            removePlayerFromEvent(player)
            outputChatBox("Fuiste devuelto a tu posicion anterior", player, 0, 255, 255)
        end
    else
        for k,v in ipairs(getEventParticipants()) do
            local accName = getAccountName(getPlayerAccount(v))
            if (not warp_savePos[accName]) then
                killPed(v)
                outputChatBox("No tienes posicion anterior!, se te dara kill instantaneamente", v, 0, 255, 255)
            else
                if (isPedWearingJetpack(v)) then setPedWearingJetpack(v, false) end
                if (isPedInVehicle(v)) then removePedFromVehicle(v) end
                local px, py, pz = warp_savePos[accName][1], warp_savePos[accName][2], warp_savePos[accName][3]
                local pint = warp_savePos[accName][4]
                local pdim = warp_savePos[accName][5]
                setElementInterior(v, pint)
                setElementPosition(v, px, py, pz)
                setElementDimension(v, pdim)
                toggleAllControls(v, true)
                removePlayerFromEvent(v)
                outputChatBox("Fuiste devuelto a tu posicion anterior", v, 0, 255, 255)
            end
        end
    end
end

function addWarps(player, amount, mul, freeze, jtlist, forbid, pos)
    wapx, wapy, wapz = pos[1], pos[2], pos[3]
    warp_warpLimit = warp_warpLimit + amount
    warp_dimension = pos[4]
    warp_interior = pos[5]
    warp_allowMultiple = mul
    warp_vipOnly = vip
    warp_freeze = freeze
    booleanList[1] = freeze
    forbidJobTeams = forbid
    jobTeams = jtlist
    outputChatBox("There are "..amount.." warps remaining for the event, type /eventwarp to be warped to the event", root, 0, 255, 0)
end

function addMoreWarps(amount, mul, freeze, jtlist, forbid)
    if (amount) then
        if (warp_warps >= warp_warpLimit) then
            local x, y, z = getElementPosition(client)
            local dim = getElementDimension(client)
            local int = getElementInterior(client)
            outputChatBox("[EVENT MANAGER] Los warps seran activados en 5 segundos", client, 0, 255, 0)
            setTimer(addWarps, 5000, 1, client, amount, mul, freeze, jtlist, forbid, {x, y, z, dim, int})
        else
            outputChatBox("You can only perform this action when the warp limit has been reached", client, 255, 0, 0)
        end
    end
end
addEvent("CSTevents.AddWarps", true)
addEventHandler("CSTevents.AddWarps", root, addMoreWarps)

function warpPerson(player)
    local team = getPlayerTeam(player)
    if (warp_event == false) then return end
    if (isPlayerInEvent(player) and warp_allowMultiple == false) then
        outputChatBox("[EVENT MANAGER] Tu ya usaste /eventwarp", player, 0, 255, 0, true)
        return
    end
    --[[if (warp_vipOnly and not exports.CSTadmin:isPlayerDonator(player)) then
        outputChatBox("This event is for VIPs only", player, 0, 255, 0, true)
        return
        end]]--
    local playerTeam = getTeamName(team)
    local playerJob = getElementData(player, "CST.job")
    if (forbidJobTeams) or (forbidJobTeams == false) then
        if (forbidJobTeams) then
            for k,v in ipairs(jobTeams) do
                if (v == playerTeam) or (v == playerJob) then
                    outputChatBox("[EVENT MANAGER] Tu trabajo/equipo no esta aceptado en este evento!", player, 255, 0, 0)
                    return
                end
            end
        elseif (forbidJobTeams == false) then
            for k,v in ipairs(jobTeams) do
                if (v == playerTeam) or (v == playerJob) then
                    break
                elseif (k == #jobTeams) then
                    outputChatBox("[EVENT MANAGER] Tu trabajo/equipo no esta aceptado en este evento!", player, 255, 0, 0)
                    return
                end
            end
        end
    end
    if (tonumber(warp_warps) < tonumber(warp_warpLimit) and warp_event) then
        if (not getPedOccupiedVehicle(player)) then
            if (not isPlayerInEvent(player)) then
                local px, py, pz = getElementPosition(player)
                local pint, pdim = getElementInterior(player), getElementDimension(player)
                warp_savePos[getAccountName(getPlayerAccount(player))] = {px, py, pz, pint, pdim}
            end
            if (warp_interior == 0) then
                if (getElementInterior(player) ~= 0 ) then
                    setElementInterior(player, 0)
                end
                setElementPosition(player, wapx, wapy, wapz)
            else
                setElementInterior(player, warp_interior, wapx, wapy, wapz)
            end
            setElementDimension(player, warp_dimension)
            if (warp_freeze) then
                toggleAllControls(player, false)
                outputChatBox("[EVENT MANAGER] Tu estas congelado, trata de no hablar!", player, 0, 255, 255)
            end
            if (booleanList[11]) then
setPedWearingJetpack(player, true)

            else
                if (isPedWearingJetpack(player)) then
                    setPedWearingJetpack(player, false)

                end
            end
            addPlayerToEvent(player)
            warp_warps = warp_warps + 1
            if (tonumber(warp_warps) >= tonumber(warp_warpLimit)) then
                outputChatBox("[EVENT MANAGER] El evento esta lleno!", root, 0, 255, 0, true)
            end
        end
    else
        outputChatBox("[EVENT MANAGER] El evento alcanzo el limite de cupos " .. (warp_warpLimit) .. "", player, 0, 255, 0, true)
    end
end 
addCommandHandler("eventwarp", warpPerson)

function onAction(action, index, arg1, arg2)
    if (getElementDimension(client) == 336) then
        booleanList[index] = not booleanList[index]
        triggerClientEvent(client, "CSTevents.RefreshCData", client, booleanList)
        if (action == "TogglePlayerFreeze") then
            for k,v in ipairs(getEventParticipants()) do
                toggleAllControls(v, not booleanList[index])
            end
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] "..getPlayerName(client).." Los jugadores fueron congelados", v, 255, 0, 0)
                    else
                        outputChatBox("[EVENT MANAGER] "..getPlayerName(client).." Los jugadores fueron descongelados", v, 0, 255, 0)
                    end
                end
            end
        elseif (action == "ToggleVehicleFreeze") then
            for k,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
                setElementFrozen(v, booleanList[index])
            end
            for k,v in ipairs(getElementsByType("player")) do
                if (getElementDimension(v) == 336) then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] Los vehiculos del evento fueron congelados por "..getPlayerName(client), v, 255, 0, 0)
                    else
                        outputChatBox("[EVENT MANAGER] Los vehiculos del evento fueron descongelados por "..getPlayerName(client), v, 0, 255, 0)
                    end
                end
            end
        elseif (action == "ToggleVehicleLock") then
            for k,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
                setElementData(v, "l", booleanList[index])
            end
            for k,v in ipairs(getElementsByType("player")) do
                if (getElementDimension(v) == 336) then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] Los vehiculos del evento fueron bloqueados por "..getPlayerName(client), v, 255, 0, 0)
                    else
                        outputChatBox("[EVENT MANAGER] Los vehiculos del evento fueron desbloqueados por "..getPlayerName(client), v, 0, 255, 0)
                    end
                end
            end
        elseif (action == "ToggleFallingFromBike") then
            clientFeatures[1] = booleanList[index]
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] La caida de los vehiculos fue desactivada por "..getPlayerName(client), v, 0, 255, 0)
                    else
                        outputChatBox("[EVENT MANAGER] La caida de los vehiculos fue activada por  "..getPlayerName(client), v, 255, 0, 0)
                    end
                end
            end
            sendClientFeatures()
        elseif (action == "ToggleShooting") then
            for k,v in ipairs(getEventParticipants()) do
                if (booleanList[index]) then
                    toggleControl(v, "fire", false)
                    toggleControl(v, "vehicle_fire", false)
                    toggleControl(v, "vehicle_secondary_fire", false)
                else
                    toggleControl(v, "fire", true)
                    toggleControl(v, "vehicle_fire", true)
                    toggleControl(v, "vehicle_secondary_fire", true)
                end
            end
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] Las armas fueron bloqueadas por " ..getPlayerName(client), v, 0, 255, 0)
                    else
                        outputChatBox("[EVENT MANAGER] Las armas fueron desbloqueadas por " ..getPlayerName(client), v, 255, 0, 0)
                    end
                end
            end
        elseif (action == "TogglePlayerDamage") then
            clientFeatures[2] = booleanList[index]
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] El daño a los jugadores fue desactivado por "..getPlayerName(client), v, 0, 255, 0)
                    else
                        outputChatBox("[EVENT MANAGER] El daño a los jugadores fue activado por "..getPlayerName(client), v, 255, 0, 0)
                    end
                end
            end
            sendClientFeatures()
        elseif (action == "ToggleVehicleDamage") then
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] El daño de los vehiculos fue desactivado", v, 0, 255, 0)
                    else
                        outputChatBox("[EVENT MANAGER] El daño de los vehiculos fue activado", v, 255, 0, 0)
                    end
                end
            end
        elseif (action == "FixEventVehicles") then
            for k,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
                fixVehicle(v)
            end
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    outputChatBox("[EVENT MANAGER] Los vehiculos del evento fueron reparados por "..getPlayerName(client), v, 0, 255, 0)
                end
            end
        elseif (action == "ToggleVehicleFlying") then
            clientFeatures[3] = booleanList[index]
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] Los vehiculos del evento ahora pueden volar", v, 0, 255, 0)
                    else
                        outputChatBox("[EVENT MANAGER] Los vehiculos del evento ahora no pueden volar", v, 255, 0, 0)
                    end
                end
            end
            sendClientFeatures()
        elseif (action == "GivePlayersJetpack") then
            for k,v in ipairs(getEventParticipants()) do
                if (booleanList[index]) then
                    setPedWearingJetpack(v, true)

                    outputChatBox("[EVENT MANAGER] Los jugadores del evento obtuvieron jetpack "..getPlayerName(client), v, 0, 255, 0)
                else
                    setPedWearingJetpack(v, false)

                    outputChatBox("[EVENT MANAGER] Los jugadores del evento se les removio el jetpack "..getPlayerName(client), v, 255, 0, 0)
                end
            end
        elseif (action == "ToggleVehicleRampSpawning") then
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] Rampas activadas para los vehiclos nuevos", v, 0, 255, 0)
                    else
                        outputChatBox("[EVENT MANAGER] Rampas desactivadas para los vehiclos nuevos", v, 255, 0, 0)
                    end
                end
            end
        elseif (action == "WarpEventPlayersToEM") then
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    outputChatBox("[EVENT MANAGER] Los jugadores del evento fueron llevados hacia "..getPlayerName(client), v, 0, 255, 255)
                end
                local x, y, z, dim, int = getElementPosition(client)
                local dim = getElementDimension(client)
                local int = getElementInterior(client)
                local r = getPedRotation(client)
                x = x - math.sin(math.rad(r)) * 2
                y = y + math.cos(math.rad(r)) * 2
                for k,v in ipairs(getEventParticipants()) do
                    setElementPosition(v, x, y, z)
                    setElementInterior(v, int)
                    setElementDimension(v, dim)
                end
            end
        elseif (action == "ToggleVehicleLeaving") then
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] Ahora los jugadores del evento no podran bajar de sus vehiculos", v, 0, 255, 0)
                    else
                        outputChatBox("[EVENT MANAGER] Ahora los jugadores del evento podran bajar de sus vehiculos", v, 255, 0, 0)
                    end
                end
            end
        elseif (action == "ToggleCollisions") then
            clientFeatures[4] = booleanList[index]
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("[EVENT MANAGER] Las colisiones del evento fueron desactivadas", v, 0, 255, 0)
                    else
                        outputChatBox("[EVENT MANAGER] Las colisiones del evento fueron activadas", v, 255, 0, 0)
                    end
                end
            end
            sendClientFeatures()
        elseif (action == "ToggleWeapons") then
            clientFeatures[5] = booleanList[index]
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("Weapons are now disabled", v, 0, 255, 0)
                    else
                        outputChatBox("Weapons are now enabled", v, 255, 0, 0)
                    end
                end
            end
            sendClientFeatures()
        elseif (action == "ToggleTeamKilling") then
            for k,v in ipairs(getElementsByType("player")) do
                if getElementDimension(v) == 336 then
                    if (booleanList[index]) then
                        outputChatBox("Team-killing is now disabled", v, 255, 0, 0)
                    else
                        outputChatBox("Team-killing is now enabled", v, 0, 255, 0)
                    end
                end
            end
            clientFeatures[6] = booleanList[index]
            sendClientFeatures()
        elseif (action == "ChangeWeather") then
            if (arg1 and tonumber(arg1)) then
                for k,v in ipairs(getElementsByType("player")) do
                    if getElementDimension(v) == 336 then
                        outputChatBox("Weather has been changed", v, 0, 255, 0)
                    end
                    eventDimFeatures[1] = arg1
                    sendEventDimFeatures()
                end
            elseif (action == "ChangeWaveHeight") then
                if (arg1 and tonumber(arg1)) then
                    for k,v in ipairs(getElementsByType("player")) do
                        if getElementDimension(v) == 336 then
                            outputChatBox("Wave height has been changed", v, 0, 255, 0)
                        end
                        eventDimFeatures[2] = arg1
                        sendEventDimFeatures()
                    end
                end
            else
                exports.Texts:output("You must be in event dimension to perform this action", client, 255, 0, 0)
            end
        end
    end
end
addEvent("CSTevents.Action", true)
addEventHandler("CSTevents.Action", root, onAction)

function onSingleAction(action, players, arg1, arg2)
    if (action == "FreezePlayer") then
        if (#players == 1) then
            if (isElement(players[1])) then
                if (isElementFrozen(players[1])) then
                    eventControl(client, "", "freeze", getPlayerName(players[1]), "off")
                else
                    eventControl(client, "", "freeze", getPlayerName(players[1]), "on")
                end
            end
        end
    elseif (action == "KickPlayer") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                if (isPlayerInEvent(v)) then
                    eventControl(client, "", "kick", getPlayerName(v))
                else
                    outputChatBox("Not processing "..getPlayerName(v).." because: Player is not in event", client)
                end
            end
        end
    elseif (action == "GiveCash") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                if (v ~= client) then 
                    if (isPlayerInEvent(v)) then
                        eventPay(client, "", getPlayerName(v), arg1, arg2)
                    else
                        outputChatBox("Not processing "..getPlayerName(v).." because: Player is not in event", client)
                    end
                else
                    outputChatBox("Not processing "..getPlayerName(v).." because: You can't give money to yourself..", client)
                end
            end
        end
    elseif (action == "ToggleEventJetpack") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                if (not canPlayerUseEventJetpack(v)) then
                    peopleWhoCanUseEventJetpack[v] = true
                    outputChatBox("You can now use /eventjetpack", v, 0, 255, 0)
                    outputChatBox(getPlayerName(v).." can now use /eventjetpack", client, 0, 255, 0)
                else
                    outputChatBox("Not processing "..getPlayerName(v).." because: Player already has access to /eventjetpack", client)
                end
            end
        end
    elseif (action == "ToggleJetpack") then
        if (#players == 1) then
            if (isElement(players[1])) then
                if (isPedWearingJetpack(players[1])) then
                    setPedWearingJetpack(players[1], false)
                else
                    setPedWearingJetpack(players[1], true)
                end
            end
        end
    elseif (action == "SetHealth") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                setElementHealth(v, tonumber(arg1))
            end
        end
    elseif (action == "SetArmor") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                setPedArmor(v, tonumber(arg1))
            end
        end
    elseif (action == "ResendCF") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                if (isPlayerInEvent(v)) then
                    sendClientFeatures(v)
                else
                    outputChatBox("Not processing "..getPlayerName(v).." because: Player is not in event", client)
                end
            end
        end
    end
end
addEvent("CSTevents.SingleAction", true)
addEventHandler("CSTevents.SingleAction", root, onSingleAction)

function vehicleDamage()
    if (booleanList[8]) then
        if (isElement(source)) then
            setElementHealth(source, 1000)
        end
    end
end

function eventControl(player, _, arg, victim, bool)
    local accName = getAccountName(getPlayerAccount(player)) 
    if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
        local arg2 = victim
        if (victim) then
            victim = getPlayerFromName(victim)
        end
        if (arg == "dimension") then
            setElementDimension(player, eventDimension)
            outputChatBox("Changed dimension to " .. eventDimension, player, 0, 255, 255)
            sendEventDimFeatures(player)
        elseif (arg == "norm") then
            setElementDimension(player, 0)
            outputChatBox("Changed dimension to 0", player, 0, 255, 255)
            getNormalFeaturesState(player)
        elseif (arg == "return") then
            for a in pairs(getEventParticipants()) do
                if (isElement(a)) then
                    returnPlayersToLastLocation(a)
                end
            end
        elseif (arg == "freeze") then
            if (victim) then
                if (bool) then
                    if (tostring(bool) == "on") then
                        setElementFrozen(victim, true)
                        toggleAllControls (victim, false)
                        outputChatBox(getPlayerName(victim).." has been frozen.", player, 0, 255, 0)
                        outputChatBox("[Event Control] You have been frozen by "..getPlayerName(player)..".", victim, 0, 255, 255)
                    else
                        setElementFrozen(victim, false)
                        toggleAllControls (victim, true)
                        outputChatBox(getPlayerName(victim).." has been unfrozen.", player, 0, 255, 0)
                        outputChatBox("[Event Control] You have been unfrozen by "..getPlayerName(player)..".", victim, 0, 255, 255)
                    end
                else
                    exports.CSTtrivia:sendMessage("You must specify 'on' or 'off'", player, 255, 0, 0)
                end
            end
        elseif (arg == "kick") then
            if (victim) then
                if (isPlayerInEvent(victim)) then
                    returnPlayersToLastLocation(victim)
                    outputChatBox(getPlayerName(victim).." has been kicked from the event", player, 0, 255, 0)
                end
            end
        elseif (arg == "add") then
            if (victim) then
                if (not isPlayerInEvent(victim)) then
                    if (warp_event) then
                        if (warp_warps >= warp_warpLimit) then
                            addPlayerToEvent(victim)
                            removePedFromVehicle(victim)
                            setPedWearingJetpack(victim, false)
                            local px, py, pz = getElementPosition(victim)
                            local pint, pdim = getElementInterior(victim), getElementDimension(victim)
                            warp_savePos[getAccountName(getPlayerAccount(victim))] = {px, py, pz, pint, pdim}
                            setElementPosition(victim, wapx, wapy, wapz)
                            setElementInterior(victim, warp_interior)
                            setElementDimension(victim, warp_dimension)
                            warp_warps = warp_warps + 1
                            warp_warpLimit = warp_warpLimit + 1
                            outputChatBox("Added "..getPlayerName(victim).." successfully to the event", player, 0, 255, 0)
                            outputChatBox("You have been warped to the event by "..getPlayerName(player), victim, 0, 255, 255)
                        else
                            outputChatBox("You can only perform this action when the warp limit has been reached", player, 255, 0, 0)
                        end
                    else
                        outputChatBox("There isn't an event going on", player, 255, 0, 0)
                    end
                else
                    outputChatBox("This player is already in the event", player, 255, 0, 0)
                end
            end
        elseif (arg == "disable") then
            warp_warpLimit = warp_warps
            for k,v in ipairs(exports.CSTutil:getPlayersInDimension(336)) do
                exports.CSTtrivia:sendMessage("Event warps have been disabled by "..getPlayerName(player), v, 0, 255, 255)
            end
           -- exports.CSTadmin:writePlayerLog("(EM) "..getPlayerName(player).." disabled eventwarp", "events", player, victim)
        elseif (arg == "startrace") then
            if (not arg2) then
                arg2 = 1
            end
            if (getElementDimension(player) == 336 and tonumber(arg2) and (tonumber(arg2) == 1 or tonumber(arg2) == 2)) then
                startRace(player, tonumber(arg2))
            end
        elseif (arg == "racewinners") then
            raceWinners(player, arg2)
        elseif (arg == "resendcf") then
            outputChatBox("Client features have been resent", player)
            sendClientFeatures()
        elseif (arg == "destroyall") then
            for k,v in pairs(Evehs) do
                if (isElement(v)) then
                    destroyElement(v)
                end
                if (isElement(eventMarker)) then
                    destroyElement(eventMarker)
                    eventMarker = nil
                    eventMarkerCreator = nil
                    eventVehicle = nil
                end
            end
            Evehs = {}
            for k,v in pairs(roadblocks) do
                if (isElement(v[1])) then
                    destroyElement(v[1])
                end
                roadblocks[k] = nil
            end
            positions = {}
            for plyr in pairs(raceCreators) do
                triggerClientEvent(plyr, "CSTevents.UpdateMarkers", plyr, positions, markerType, markerSize)    
            end
            for i=1,actionAmount do
                booleanList[i] = false
            end
            destroyAllPickups()
            eventDimFeatures = {}
            clientFeatures = {}
        elseif (arg == "epd") then
            if (pickupDestroyers[getPlayerAccount(player)]) then
                pickupDestroyers[getPlayerAccount(player)] = nil
                outputChatBox("Pickup destroy disabled", player)
            else
                pickupDestroyers[getPlayerAccount(player)] = true
                outputChatBox("All the pickups you hit will be destroyed", player)
            end
        elseif (arg == "destroypickups") then
            destroyAllPickups()
            outputChatBox("All pickups have been destroyed", player)
        elseif (arg == "size") then
            local eventString = getEventString(player, {true, true, true, true})
            outputChatBox("Current event size: "..exports.CSTmisc:comma_value(math.floor(#eventString))..", max: "..exports.CSTmisc:comma_value(maxSize).." ("..math.floor((#eventString / maxSize) * 100).."% used)", player)
        end
    end
end
addCommandHandler("event", eventControl)

peopleTable = {}
countdown = false
function startCountdown(player, command, count)
	local accName = getAccountName(getPlayerAccount(player)) 
	if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
        if (countdown == false) then
            peopleTable = {}
            countdown = true
        if (not tonumber(count)) then
            count = 5
        end
            for _,v in ipairs(getElementsByType("player")) do
                if (getElementDimension(v) == getElementDimension(player) and getElementInterior(v) == getElementInterior(player)) then
                    table.insert(peopleTable, v)
                end
            end
            setTimer(showText, 1000, 1, count)
        end
    end
end
addCommandHandler("countd", startCountdown)

function showText(counting)
    if (counting == 0) then
        textItem = "GO GO GO"
    else
        textItem = tostring(counting)
    end
    for _,v in ipairs(peopleTable) do
        if (isElement(v)) then
            outputChatBox(textItem, v, math.random(255), math.random(255), math.random(255))
        end
    end
    if (counting == 0) then countdown = false counting = counting return end
    setTimer(showText, 1000, 1, counting-1)
end

function onPlayerLogin()
    if (isPlayerInEvent(source)) then
        if (getElementDimension(source) == warp_dimension) then
            triggerClientEvent(source, "CSTevents.ToggleClientFeature", source, clientFeatures)
            if (booleanList[11]) then
               setPedWearingJetpack(source, true)

            end
            setElementData(source, "e", true)
        else
            removePlayerFromEvent(source)
        end
    end
    if (getElementDimension(source) == 336) then
        sendEventDimFeatures(source)
    end
end
addEventHandler("onPlayerLogin", root, onPlayerLogin)

function onPlayerQuit()
    if (isPlayerInEvent(source)) then
        if (getElementDimension(source) ~= warp_dimension) then
            removePlayerFromEvent(source)
        end
    end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

function onPlayerWasted()
    if (isPlayerInEvent(source)) then
        toggleAllControls(source, true)
        removePlayerFromEvent(source)
    end
end
addEventHandler("onPlayerWasted", root, onPlayerWasted)

function addPlayerToEvent(player)
    if (isElement(player)) then
        if (warp_dimension == 336) then
            sendClientFeatures(player)
            sendEventDimFeatures(player)
        end
        setElementData(player, "e", true)
        warp_warpedUsers[getAccountName(getPlayerAccount(player))] = true
    end
end

function sendClientFeatures(player)
    if (player and isElement(player)) then
        triggerClientEvent(player, "CSTevents.ToggleClientFeature", player, clientFeatures)
    else
        for k,v in ipairs(getEventParticipants()) do
            triggerClientEvent(v, "CSTevents.ToggleClientFeature", v, clientFeatures)
        end
    end
end

function sendEventDimFeatures(player)
    if (player and isElement(player)) then
        triggerClientEvent(player, "CSTevents.SendEventDimFeature", player, eventDimFeatures)
    else
        for k,v in ipairs(getElementsByType("player")) do
            if getElementDimension(v) == 336 then
                triggerClientEvent(v, "CSTevents.SendEventDimFeature", v, eventDimFeatures)
            end
        end
    end
end

function getEventParticipants()
    local pTable = {}
    local index = 0
    for acc in pairs(warp_warpedUsers) do
        if (getAccountPlayer(getAccount(acc))) then
            index = index + 1
            pTable[index] = getAccountPlayer(getAccount(acc))
        end
    end
    return pTable
end

function removePlayerFromEvent(player)
    if (isElement(player)) then
        if (isPlayerInEvent(player)) then
            warp_warpedUsers[getAccountName(getPlayerAccount(player))] = nil
            warp_savePos[getAccountName(getPlayerAccount(player))] = nil
            triggerClientEvent(player, "CSTevents.ToggleClientFeature", player, {})
            getNormalFeaturesState(player)
            if (booleanList[11]) then
               setPedWearingJetpack(player, false)
            end
            if (booleanList[18]) then
                setElementCollisionsEnabled(player, true)
            end
            removeElementData(player, "e")
        end
    end
end

function isQuitJobDisabledForEvents()
    return booleanList[14]
end

function isEndShiftDisabledForEvents()
    return booleanList[15]
end

function isPlayerInEvent(player)
    if (warp_event) then
        for k,v in ipairs(getEventParticipants()) do
            if (v == player) then
                return true
            end
        end
    end
    return false
end

function cmd_leaveEvent(player)
if  getElementData ( player, "isPlayerRobbing") then exports.CSTtexts:output("You can't leave event while you are robbing!", 255, 0, 0) return end
    if (isPlayerInEvent(player)) then
        returnPlayersToLastLocation(player)
    else
        exports.CSTtexts:output("You are not in a event", 255, 0, 0)
    end
end
addCommandHandler("leaveevent", cmd_leaveEvent)

function canPlayerUseEventJetpack(player)
    if (getTeamName(getPlayerTeam(player)) == "Staff") or exports.CSTcem:isPlayerCm(player) or (isPlayerInEvent(player) and booleanList[11]) or (peopleWhoCanUseEventJetpack[player]) then
        return true
    end
    return false
end

function cmd_eventjetpack(player)
    if (isGuestAccount(getPlayerAccount(player))) then return end
    if (isPedWearingJetpack(player)) then
       setPedWearingJetpack(player, false)
        return
    end
    if (getElementDimension(player) ~= 336) then return end
    if (canPlayerUseEventJetpack(player)) then
        if (not isPedWearingJetpack(player)) then
           setPedWearingJetpack(player, true)

        end
    end
end
addCommandHandler("eventjetpack", cmd_eventjetpack)

function requestEventDimFeatures()
    triggerClientEvent(client, "CSTevents.SendEventDimFeature", client, eventDimFeatures)
end
addEvent("CSTevents.GetEventDimFeatures", true)
addEventHandler("CSTevents.GetEventDimFeatures", root, requestEventDimFeatures)

function getNormalFeaturesState(player)
    triggerClientEvent(client or player, "CSTevents.RemoveEventDimFeatures", client or player, {getWeather(), getWaveHeight()})
end
addEvent("CSTevents.GetNormalFeaturesState", true)
addEventHandler("CSTevents.GetNormalFeaturesState", root, getNormalFeaturesState)