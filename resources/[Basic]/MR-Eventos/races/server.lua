positions = {}
winners = {}
raceParticipants = {}
raceCreators = {}
markerType = "checkpoint"
markerSize = 10
raceType = 1
raceStarted = false

function addMarker(player)
	local accName = getAccountName(getPlayerAccount(player)) 
    if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
        if (getElementDimension(player) == 336) then
            if (not raceStarted) then
                local x, y, z = getElementPosition(player)
                table.insert(positions, {math.floor(x), math.floor(y), math.floor(z)})
                outputChatBox("Coordinates taken, total markers: "..#positions, player)
                for plyr in pairs(raceCreators) do
                    triggerClientEvent(plyr, "CSTevents.AddCheck", plyr, {#positions, x, y, z}, markerType, markerSize)
                end
            else
                exports.CSTtexts:output("You can't use this when a race is going on", 255, 0, 0)
            end
        end
    end
end
addCommandHandler("addcheck", addMarker)

function startRace(player, commandName, mode)
    local accName = getAccountName(getPlayerAccount(player)) 
    if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
        if (getElementDimension(player) == 336) then
            if (warp_event) then
                if (not raceStarted) then
                    raceStarted = true
                    commandName = 1
                    for k,v in ipairs(getEventParticipants()) do
                        raceParticipants[v] = true
                        triggerClientEvent(v, "CSTevents.CreateRaceStuff", v, positions, markerType, markerSize, raceType)
                    end
                    outputChatBox("Los marcadores de la carrera fueron creados para todos los jugadores", player, 0, 255, 0)
                else
                    outputChatBox("La carrera ya esta en marcha!", player, 255, 0, 0)
                end
            else
                outputChatBox("Tienes que iniciar el /eventwarp antes de comenzar la carrera!", player, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("startrace", startRace)

function onPlayerQuit()
    if (raceParticipants[source]) then
        raceParticipants[source] = nil
    end
    if (raceCreators[source]) then
        raceCreators[source] = nil
    end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

function resetRaceStuff()
    for player in pairs(raceParticipants) do
        if (player) then
            triggerClientEvent(player, "CSTevents.DestroyRaceStuff", player)
        end
    end
    raceParticipants = {}
    positions = {}
    winners = {}
    raceStarted = false
end

function setWinner()
    if (not winners[1]) then 
        for k,v in ipairs(getElementsByType("player")) do
            if getElementDimension(v) == 336 then
                if (raceType == 1) then
                    if (v == client) then
                        outputChatBox("Ganaste la Carrera!", v, 0, 255, 0)
                    else
                        outputChatBox(getPlayerName(client).." Fue el Ganador!", v, 0, 255, 255)
                    end
                end
            else
                if (v == client) then
                    outputChatBox("Ganaste la Carrera!", v, 0, 255, 0)
                else
                    outputChatBox(getPlayerName(client).." Fue el Ganador!", v, 0, 255, 255)
                end
            end
        end
    end
    table.insert(winners, getAccountName(getPlayerAccount(client)))
end
addEvent("CSTevents.SetRaceWinner", true)
addEventHandler("CSTevents.SetRaceWinner", root, setWinner)

function raceWinners(src, amount)
    local accName = getAccountName(getPlayerAccount(src)) 
    if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
        if (winners[1]) then
            if (not tonumber(amount)) then
                outputChatBox("Syntax: /event racewinners [1-"..#winners.."]", src)
                return
            end
            outputChatBox("Place: Ingame Name (Account Name)", src)
            for i=1, tonumber(amount) do
                if (winners[i]) then
                    local player = getAccountPlayer(getAccount(winners[i]))
                    local playerName = "Player Offline"
                    if (player) then
                        playerName = getPlayerName(player)
                    end
                    outputChatBox(i..": "..playerName.." ("..winners[i]..")", src)
                end
            end
        else
            outputChatBox("Todavia no hay ganadores en la carrera!", src, 255, 0, 0)
        end
    end
end

function delCheck(player)
    local accName = getAccountName(getPlayerAccount(player)) 
    if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
        if (getElementDimension(player) == 336) then
            if (#positions > 0) then
                positions[#positions] = nil
                outputChatBox("Check "..(#positions + 1).." has been deleted", player)
                for plyr in pairs(raceCreators) do
                    triggerClientEvent(plyr, "CSTevents.DelPrevCheck", plyr)    
                end
            end
        end
    end
end
addCommandHandler("delcheck", delCheck)

function showChecks(player)
    local accName = getAccountName(getPlayerAccount(player)) 
    if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
        if (getElementDimension(player) == 336) then
            if (raceCreators[player]) then
                raceCreators[player] = nil
                outputChatBox("showchecks: false", player)
                triggerClientEvent(player, "CSTevents.UpdateMarkers", player, {})
            else
                raceCreators[player] = true
                outputChatBox("showchecks: true", player)
                triggerClientEvent(player, "CSTevents.UpdateMarkers", player, positions, markerType, markerSize)
            end
        end
    end
end
addCommandHandler("showchecks", showChecks)

function deleteAllChecks(player)
    local accName = getAccountName(getPlayerAccount(player)) 
    if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
        if (getElementDimension(player) == 336) then
            outputChatBox("All checkpoints were deleted", player)
            positions = {}
            for plyr in pairs(raceCreators) do
                triggerClientEvent(player, "CSTevents.DestroyRaceStuff", player)
            end
        end
    end
end
addCommandHandler("delallchecks", deleteAllChecks)

function updateChecks(player)
    local accName = getAccountName(getPlayerAccount(player)) 
    if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
        if (getElementDimension(player) == 336) then
            for plyr in pairs(raceCreators) do
                triggerClientEvent(plyr, "CSTevents.UpdateMarkers", plyr, positions, markerType, markerSize)    
            end
        end
    end
end
addCommandHandler("updatechecks", updateChecks)

function rmsize(player, _, size)
    if (hasObjectPermissionTo(player, "command.givevehicle", false) or exports.CSTcem:isPlayerCm(player)) then
        if (getElementDimension(player) == 336) then
            if (size and tonumber(size) and tonumber(size) <= 50) then
                markerSize = size
                for plyr in pairs(raceCreators) do
                    triggerClientEvent(plyr, "CSTevents.UpdateMarkers", plyr, positions, markerType, markerSize)    
                end
                outputChatBox("Marker size set to "..size, player, 0, 255, 0)
            else
                outputChatBox("Syntax is: /rmtype [1-50] Current marker size: "..markerSize, player, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("rmsize", rmsize)

function rmtype(player, _, mtype)
    if (hasObjectPermissionTo(player, "command.givevehicle", false) or exports.CSTcem:isPlayerCm(player)) then
        if (getElementDimension(player) == 336) then
            if (mtype and (mtype == "checkpoint" or mtype == "ring")) then
                markerType = mtype
                for plyr in pairs(raceCreators) do
                    triggerClientEvent(plyr, "CSTevents.UpdateMarkers", plyr, positions, markerType, markerSize)    
                end
                outputChatBox("Marker type set to "..mtype, player, 0, 255, 0)
            else
                outputChatBox("Syntax is: /rmtype [checkpoint - ring] Current marker type: "..markerType, player, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("rmtype", rmtype)