----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 29 Dec 2014
-- Resource: GTIhousing/vehicles.lua
-- Version: 1.0
----------------------------------------->>

local restricted_types = {
	["Plane"] = true,
	["Helicopter"] = true,
	["Boat"] = true,
	["Train"] = true,
	["Trailer"] = true,
}

-- Get Vehicles
---------------->>

addEvent("GTIhousing.getPlayerVehicles", true)
addEventHandler("GTIhousing.getPlayerVehicles", root, function()
	if (not client) then client = source end
	local account = getPlayerAccount(client)
	local vehData = exports["[POPlife]ComplementoGaraje"]:getAccountVehicles(account) or {}
	local vehTable = {}
	
	for vehKey,vehID in pairs(vehData) do
		local int = string.gsub(vehKey, "vehicle", "")
		local int = tonumber(int)
		if (int) then
			vehTable[int] = {}
			vehTable[int][1] = exports.GTIvehicles:getVehicleData(vehID, "vehicleID")
			if (not restricted_types[ getVehicleType(vehTable[int][1]) ]) then
				vehTable[int][2] = exports.GTIvehicles:getVehicleData(vehID, "health")
				if (exports.GTIvehicles:isVehicleSpawned(vehID)) then
					--vehTable[int][3] = true	-- Paint Active Cars Blue
					local vehicle = exports.GTIvehicles:getVehicleByID(vehID)
					vehTable[int][2] = getElementHealth(vehicle)
				end
			else
				vehTable[int] = nil
			end
		end
	end
	triggerClientEvent(client, "GTIhousing.getPlayerVehicles", resourceRoot, vehTable)
end)

-- Update Vehicle Info
----------------------->>

addEvent("GTIhousing.updateVehicleInfo", true)
addEventHandler("GTIhousing.updateVehicleInfo", root, function(vehID)
	local vehInfo = {}
	local vehID = exports.GTIvehicles:getVehicleIDFromSlot(client, vehID)
	if (not vehID) then return end
	
	-- Vehicle Name
	vehInfo["name"] = exports.GTIvehicles:getVehicleData(vehID, "vehicleID")
	vehInfo["name"] = getVehicleNameFromModel(tonumber(vehInfo["name"]))
	
	-- Vehicle Location (Zone)
	local vehicle = exports.GTIvehicles:getVehicleByID(vehID)
	if (not isElement(vehicle)) then
		local pos = exports.GTIvehicles:getVehicleData(vehID, "position")
		pos = split(pos, ",")
		x,y,z = tonumber(pos[1]), tonumber(pos[2]), tonumber(pos[3])
	else
		x,y,z = getElementPosition(vehicle)
	end
	local district, city = getZoneName(x,y,z), getZoneName(x,y,z, true)
	if (district == "Unknown") then district = "San Andreas" end
	if (city == "Unknown") then city = "San Andreas" end
	vehInfo["zone"] = district..", "..city
	
	triggerClientEvent(client, "GTIhousing.updateVehicleInfo", resourceRoot, vehInfo)
end)

-- Spawn Vehicle
----------------->>

addEvent("GTIhousing.spawnVehicle", true)
addEventHandler("GTIhousing.spawnVehicle", root, function(slot, house)
	local vehID = exports.GTIvehicles:getVehicleIDFromSlot(client, slot)
		-- If Vehicle Is Spawned
	if (exports.GTIvehicles:isVehicleSpawned(vehID)) then
		-- Empty Vehicle
		local vehicle = exports.GTIvehicles:getVehicleByID(vehID)
		for seat,plr in pairs(getVehicleOccupants(vehicle)) do
			removePedFromVehicle(plr)
		end
	else
		exports.GTIvehicles:spawnPlayerVehicle(client, slot)
	end
	local vehicle = exports.GTIvehicles:getVehicleByID(vehID)
	local x,y,z,rot = getHouseGaragePosition(house)
	setElementPosition(vehicle, x, y, z+1)
	setElementRotation(vehicle, 0, 0, rot)
	
	warpPedIntoVehicle(client, vehicle)
	
	exports.GTIhud:dm("You have spawned your "..getVehicleName(vehicle), client, 15, 142, 242)
	
	triggerClientEvent(client, "GTIhousing.closePanel", resourceRoot)
end)
