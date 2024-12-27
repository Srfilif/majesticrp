------------------------------------------->>
-- CST-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: CSTevents
-- Type: Client Side
-- Author: ChicoCST & RedBand
----------------------------------------->>

Evehs = {}
occupiedEvehs = {}
eventMarker = nil
eventMarkerCreator = nil
eventVehicle = nil
local HPM = nil
local SM = nil
locked = false
local randomMarker = nil
local randomBlipMarker = nil
local eventJetpackEnabled = false
local spawnerCreator = nil

function eventmarker(player, command, r, g, b, blip)
	local accName = getAccountName(getPlayerAccount(player)) 
	if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
		if (randomMarker and randomBlipMarker) then outputChatBox("There is already an event marker spawned.", player, 255, 0, 0) return end
		if (not tonumber(r)) then
			r, g, b = math.random(255), math.random(255), math.random(255)
		end
		if (not tonumber(blip)) then
			blip = 49
		end
		local x, y, z = getElementPosition(player)
		local dim, int = getElementDimension(player), getElementInterior(player)
		randomMarker = createMarker(x, y, z - 1, "checkpoint", 2, r, g, b, 150, root)
		randomBlipMarker = createBlip(x, y, z, blip, 2)
		setElementInterior(randomMarker, int)
		setElementDimension(randomMarker, dim)
		if (isElement(randomBlipMarker)) then
			setElementInterior(randomBlipMarker, int)
			setElementDimension(randomBlipMarker, dim)
		end
		outputChatBox("[EVENT MANAGER] Event Marker created.", player, 0, 255, 0)
	end
end
addCommandHandler("addmarker", eventmarker)

function eventmarker(player, command)
	local accName = getAccountName(getPlayerAccount(player)) 
	if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
		if (isElement(randomMarker)) or (isElement(randomMarker)) then
			if (isElement(randomMarker)) then destroyElement(randomMarker) end
			if (isElement(randomBlipMarker)) then destroyElement(randomBlipMarker) end
			randomMarker = nil
			randomBlipMarker = nil
			outputChatBox("Event Marker deleted.", player, 0, 255, 0)
		else
			outputChatBox("There is nothing to destroy", player, 0, 255, 0)
		end
	end
end
addCommandHandler("delmarker", eventmarker)

function spawnEventMarker(player, command, r, g, b, ...)
	local accName = getAccountName(getPlayerAccount(player)) 
	if isObjectInACLGroup ("user."..accName, aclGetGroup("EventManager")) then
		local arg1 = table.concat({...}, " ")
		if (not r) then outputChatBox("Syntaxis: /addem r g b modelo (color random usa /addem r r r modelo)", player, 255, 0, 0) return end
		if (not tonumber(r) and not tonumber(g) and not tonumber(b)) then
			if (tostring(r) and tostring(g) and tostring(b)) then
				if (tostring (r) ~= "r" and tostring (g) ~= "r" and tostring (b) ~= "r") then
					outputChatBox("To use a random color please use r r r", player, 255, 0, 0)
					return
				end
			end
			r, g, b = math.random(255), math.random(255), math.random(255)
		end
		if (eventMarker) then
			outputChatBox("An event marker is already spawned, check with "..tostring(eventMarkerCreator).." to make sure you can destroy it", player, 255, 0, 0)
			return false
		end
		if (not arg1 or not getVehicleModelFromName(arg1)) then
			outputChatBox("Specify a vehicle name to spawn!", player, 255, 0, 0)
			return false
		end
		local x, y, z = getElementPosition(player)
		local dim = getElementDimension(player)
		local int = getElementInterior(player)
		eventMarker = createMarker(x, y, z - 1, "cylinder", 2, tonumber(r), tonumber(g), tonumber(b), 200, root)
		setElementData(eventMarker, "rgb", r..","..g..","..b)
		setElementInterior(eventMarker, int)
		setElementDimension(eventMarker, dim)
		eventMarkerCreator = getPlayerName(player)
		spawnerCreator = getAccountName(getPlayerAccount(player))
		eventVehicle = getVehicleModelFromName(arg1)
		addEventHandler("onMarkerHit", eventMarker, givePlayerVehicle)
		exports.CSTtexts:output("You have created an event Marker.", player, 0, 255, 0)
	end
end
addCommandHandler("addem", spawnEventMarker)

function removeEventStuff()
    if (eventMarker) then
        destroyElement(eventMarker)
        eventMarker = nil
        eventMarkerCreator = nil
        eventVehicle = nil
        exports.CSTtexts:output("Marker destroyed!", client, 0, 255, 0)
    else
        if (Evehs) then
            for ind, veh in pairs(Evehs) do
                if (isElement(veh) and getElementType(veh) == "vehicle") then
                    local driver = getVehicleController(veh)
                    if (driver and isElement(driver)) then
                        exports.CSTtexts:output("Event vehicles destroyed by "..getPlayerName(client), driver, 255, 0, 0)
                    end
                    destroyElement(veh)
                end
            end
            Evehs = {}
        end
    end
end
addEvent("CSTevents.DelVehStuff", true)
addEventHandler("CSTevents.DelVehStuff", root, removeEventStuff)

function givePlayerVehicle(player, sameDim)
    if (not eventVehicle) then return end
    if (sameDim and player and isElement(player) and getElementType(player) == "player" and not isPedInVehicle(player)) then
        local x, y, z = getElementPosition(player)
        local int = getElementInterior(player)
        local dim = getElementDimension(player)
        local rot = getPedRotation(player)
        local color
        local rgb = getElementData(eventMarker, "rgb")
        if (rgb) then
            color = split(rgb, string.byte(","))
        end
        local veh = createEventVehicle(eventVehicle, x, y, z, 0, 0, rot, dim, int, spawnerCreator, color)
        warpPedIntoVehicle(player, veh)
    end
end

function createEventVehicle(id, x, y, z, rx, ry, rz, dim, int, creator, color)
    local vehicle = createVehicle(id, x, y, z, rx, ry, rz)
    if (vehicle) then
        setElementDimension(vehicle, dim)
        setElementInterior(vehicle, int)
        setElementData(vehicle, "creator", creator, false)
        setElementData(vehicle, "l", booleanList[3])
        if (booleanList[13]) then
            local ramp = createObject(1634, x, y, z)
            setElementDimension(ramp, dim)
            setElementInterior(ramp, int)
            attachElements(ramp, vehicle, 0, 7, -1.5 , 0, 0, 180)
            addEventHandler("onElementDestroy", vehicle, function() destroyElement(ramp) end)
        end
        addEventHandler("onVehicleDamage", vehicle, vehicleDamage)
        addEventHandler("onVehicleStartExit", vehicle, vehHijackExit)
        addEventHandler("onVehicleStartEnter", vehicle, vehHijackEnter)
        Evehs[#Evehs + 1] = vehicle
        -- Fuel Export here
        setElementData(vehicle, "Fuel", 100)
        setElementFrozen(vehicle, false)
        setVehicleEngineState(vehicle, true)
        if (color) then
            setVehicleColor(vehicle, color[1] or 255, color[2] or 255, color[3] or 255, color[4] or 255, color[5] or 255, color[6] or 255, color[7] or 255, color[8] or 255, color[9] or 255, color[10] or 255, color[11] or 255, color[12] or 255)
        end
        return vehicle
    end
end

function vehHijackEnter(ePlayer, seat, jacked)
    if (booleanList[22] and isPlayerInEvent(ePlayer)) then
        if (jacked) then
            cancelEvent()
        end
    end
end

function vehHijackExit(ePlayer, seat)
    if (booleanList[17] and isPlayerInEvent(ePlayer)) then
        cancelEvent()
    end
end

function fixall(player, command)
    local adminlevel = getElementData(player, "admin.number")
    if ((adminlevel >= 2) or exports.CSTcem:isPlayerCm(player)) then
        if (Evehs) then
            for ind, veh in pairs(Evehs) do
                if (isElement(veh)) then
                    fixVehicle(veh)
                end
            end
            exports.CSTtrivia:sendMessage("Vehicles Fixed", player, 255, 0, 0, 3000)
        end
    end
end
addCommandHandler("fixall", fixall)

function upgradeC(player, command)
    local adminlevel = getElementData(player, "admin.number")
    if ((adminlevel >= 2) or exports.CSTcem:isPlayerCm(player)) then
        if (Evehs) then
            for ind, veh in pairs(Evehs) do
                if (isElement(veh)) then
                    addVehicleUpgrade(veh, 1010)
                end
            end
            exports.CSTtrivia:sendMessage("Vehicles now have NITRO", player, 255, 0, 0, 3000)         
        end
    end
end
addCommandHandler("vehnitro", upgradeC)

function vehiclec(player, command)
    local adminlevel = getElementData(player, "admin.number")
    if ((adminlevel >= 2) or exports.CSTcem:isPlayerCm(player)) then
        if (Evehs) then
            if (#Evehs == 1) then
                outputChatBox("(EVENT) There is "..tonumber(#Evehs).." vehicle currently spawned up.", player, 0, 255, 255)
            elseif (#Evehs > 1) then
                outputChatBox("(EVENT) There are "..tonumber(#Evehs).." vehicles currently spawned up.", player, 0, 255, 255)
            elseif (#Evehs < 1) then
                outputChatBox("(EVENT) There are no vehicles currently spawned up.", player, 0, 255, 255)
            end
        end
    end
end
addCommandHandler("vc", vehiclec)

addEvent("eventDim", true)
addEventHandler("eventDim", root, 
    function()
        if (isElement(client)) then
            local dim = getElementDimension(client)
            if (dim ~= 336) then
                setElementDimension(client, 336)
                outputChatBox( "[EVENT MANAGER] Tu dimension ahora es la 336", client, 255, 120, 0)
                sendEventDimFeatures(player)
            elseif (dim == 336) then
                setElementDimension(client, 0)
                outputChatBox("[EVENT MANAGER] Volviste a la dimension 0", client, 255, 120, 0)
                getNormalFeaturesState(player)
            end
        end
    end
)