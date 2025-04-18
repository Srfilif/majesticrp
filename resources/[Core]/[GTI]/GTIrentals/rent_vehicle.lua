----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 07 Mar 2015
-- Resource: GTIrentals/rent_vehicle.slua
-- Version: 1.0
----------------------------------------->>

local veh_rest = {}				-- Restrictions Table by Vehicle
local cust_col = {}				-- Vehicles with Custom Colors
local cols = {}					-- Collisions around the vehicles
local veh_cols = {}				-- Vehicle attached to col.
local rentVehicles = {}			-- Storage of Job Vehicles by Player
local activeRentals = {}		-- Storage of Players by Job Vehicle
local vehicle_index = {}		-- Vehicle indexing.
local MAX_HR_PAYMENT = 1000		-- Highest Amount to charge per hour
local MAX_RENT_COST = 7500		-- Highest Amount to charge, period
local groupVehicles = {}
DEFAULT_COST = 20000
addEvent("onPlayerQuitJob",true)
addEvent("onPlayerGetJob",true)

-- Create Vehicles
------------------->>

addEventHandler("onResourceStart",root,function(resource)
	resource = getResourceName(resource)
	if (resource ~= "GTIrentals" and resource ~= "GTIrentalTable") then return end
	
	for k,v in ipairs(getElementsByType("vehicle",resourceRoot)) do
		if (getElementData(v,"rental")) then
			destroyElement(v)
		end
	end
	veh_rest = {}
	
	for k,v in ipairs(exports.GTIrentalTable:vehiclesTable()) do
		local vehicle = createVehicle(v.id,v.pos[1],v.pos[2],v.pos[3],0,0,(v.pos[4] or 0))
		if (v.col and #v.col > 0) then
			setVehicleColor(vehicle, v.col[1],v.col[2],v.col[3],v.col[4],v.col[5],v.col[6])
			cust_col[vehicle] = true
		end
		
		setVehicleDamageProof(vehicle,true)
		setElementData(vehicle,"rental",true)
		setTimer(setElementFrozen,500,1,vehicle,true)
		veh_rest[vehicle] = v.res
		vehicle_index[vehicle] = k
	end
end)

-- Vehicle Restrictions
------------------------>>

addEventHandler("onVehicleStartEnter", resourceRoot, function(player, seat)
	if (not getElementData(source, "rental")) then return end
	if (seat ~= 0) then cancelEvent() return end
	local res = veh_rest[source]
	if (not res) then return end
	local reason;
	for i,v in ipairs(res) do
			-- Police Officer Check
		if (v == "Police") then
			if (exports.GTIpoliceArrest:canPlayerArrest(player)) then
				return
			else
				reason = "Law Enforcement"
			end
		end
			-- Occupation Check
		if (v == exports.GTIemployment:getPlayerJob(player, true)) then
			return
		else
			reason = v.."s"
		end
		if (string.find(v, ";")) then
			v = split(v, ";")
			-- Level Check
				-- Police Level Check
			if (v[1] == "Police") then
				if (exports.GTIpoliceArrest:canPlayerArrest(player)	and exports.GTIemployment:getPlayerJobLevel(player, "Police Officer") >= tonumber(v[2])) then
					return
				else
					reason = "L"..v[2].." Law Enforcement"
				end
				-- Job Level Check
			elseif (v[1] == "Group") then
				if ( exports.GTIgroups:getPlayerGroup(player) == tonumber(v[2]) ) then
					groupVehicles[source] = true
					return
				else
					reason = exports.GTIgroups:getGroupName( tonumber(v[2]) ) .. " members"
				end
			elseif (tonumber(v[2])) then
				if (v[1] == exports.GTIemployment:getPlayerJob(player, true) and exports.GTIemployment:getPlayerJobLevel(player, v[1]) >= tonumber(v[2])) then
					return
				else
					reason = "L"..v[2].." "..v[1].."s"
				end
				-- Job Division Check
			elseif (not tonumber(v[2])) then
				if (v[1] == exports.GTIemployment:getPlayerJob(player, true) and v[2] == exports.GTIemployment:getPlayerJobDivision(player)) then
					return
				else
					reason = v[1].."s of the "..v[2].." division"
				end
			end
		end
	end
	cancelEvent()
	exports.GTIhud:dm("Este vehiculo esta restringido para "..reason..".", player, 255, 25, 25)
end)

-- Duplicate Vehicle
--------------------->>

addEventHandler("onVehicleEnter",resourceRoot,
function(player,seat)
	if (seat ~= 0 or not getElementData(source,"rental")) then return end
	destroyRental(player)
	
	local x,y,z = getElementPosition(source)
	
	colshape = createColSphere(x,y,z,7)
	cols[colshape] = {col = colshape, veh = source}
	veh_cols[source] = colshape
	
	addEventHandler("onColShapeLeave",colshape,
		function(hitEl)
			if not cols[source] then return end
			if cols[source].veh ~= hitEl then return end
			setTimer(createNewRental,500,1,vehicle_index[hitEl],hitEl)
			
			if cols[source] and isElement(cols[source].col) then
				destroyElement(cols[source].col)
				veh_cols[cols[source].col] = nil
				cols[source] = nil
			end
		end
	)
	
	setVehicleDamageProof(source,false)
	removeElementData(source,"rental",true)
	veh_rest[source] = nil
	rentVehicles[player] = source
	activeRentals[source] = {owner = player, duration = getRealTime().timestamp}
	
	setElementData(source,"owner",getAccountName(getPlayerAccount(player)))
	setElementData(source,"Fuel",100)
	setElementFrozen(source,false)
	
	triggerClientEvent("GTIrentals.removeGhostmode",source)
end)

addEventHandler("onElementDestroy",root,
function()
	if cols[source] and isElement(cols[source]) then
		veh_cols[cols[source].col] = nil
		destroyElement(cols[source].col)
		cols[source] = nil
	end
end)

function createNewRental(index,hitEl)
	if index then
		local vehicles = exports.GTIrentalTable:vehiclesTable()
		local _vehicle = vehicles[index]
		if not _vehicle then return false end
		
		local vehicle = createVehicle(_vehicle.id,_vehicle.pos[1],_vehicle.pos[2],_vehicle.pos[3]+1,0,0,(_vehicle.pos[4] or 0))
		if (_vehicle.col and #_vehicle.col > 0) then
			setVehicleColor(vehicle, _vehicle.col[1],_vehicle.col[2],_vehicle.col[3],_vehicle.col[4],_vehicle.col[5],_vehicle.col[6])
			cust_col[vehicle] = true
		end
		setElementFrozen(vehicle,true)
		setVehicleDamageProof(vehicle,true)
		setElementData(vehicle,"rental",true)
		veh_rest[vehicle] = _vehicle.res
		vehicle_index[vehicle] = index
	end
end

-- Destroy Rental Vehicle
-------------------------->>

function destroyRental(player)
	local vehicle = rentVehicles[player]
	if (vehicle and isElement(vehicle)) then
		if ( groupVehicles[vehicle] ) then groupVehicles[vehicle] = nil 
			activeRentals[vehicle] = nil
			rentVehicles[player] = nil
		
			triggerClientEvent("GTIrentals.destroyRental", vehicle)
			setTimer(function(vehicle)
				destroyElement(vehicle)
			end, 500, 1, vehicle)
		
			if veh_cols[vehicle] and isElement(veh_cols[vehicle]) then
				createNewRental(vehicle_index[vehicle],vehicle)
				destroyElement(veh_cols[vehicle])
				cols[veh_cols[vehicle]] = nil
				veh_cols[vehicle] = nil
			end
			return 
		end
		--Calculate rental costs
		local rent_time = getVehicleRentTime(vehicle)
		local rent_cost = math.floor(getHourlyRentalCost(vehicle) * rent_time)
		if (rent_cost > MAX_RENT_COST) then rent_cost = MAX_RENT_COST end
		
		--Is the vehicle destroyed?
		local destroyed
		if (getElementHealth(vehicle) <= 250) then
			--Check if the last attacker was the player, and charge replacement fees.
			if (exports.GTIdamage:getLastVehicleAttacker(vehicle) == player) then
				rent_cost = getVehicleCost(vehicle) * (10/100) 
				destroyed = true
			end
		end
		
		--Charge the player
		if (rent_cost > 0) then
			takePlayerMoney(player,rent_cost,"Rentals: "..getVehicleName(vehicle).." rental cost.")
			
			if destroyed then
				outputChatBox("* Tu vehiculo rentado fue destruido",player,255,25,25)
				outputChatBox("* Costo de la renta vehicular: $"..exports.GTIutil:tocomma(rent_cost),player,255,25,25)
			else
				outputChatBox("* Costo de la renta vehicular: $"..exports.GTIutil:tocomma(rent_cost).." ("..getVehicleRentTime(vehicle,true).." minutos)",player,255,255,25)
			end
		end
		
		--Clean up
		activeRentals[vehicle] = nil
		rentVehicles[player] = nil
		
		triggerClientEvent("GTIrentals.destroyRental", vehicle)
		setTimer(function(vehicle)
			destroyElement(vehicle)
		end, 500, 1, vehicle)
		
		if veh_cols[vehicle] and isElement(veh_cols[vehicle]) then
			createNewRental(vehicle_index[vehicle],vehicle)
			destroyElement(veh_cols[vehicle])
			cols[veh_cols[vehicle]] = nil
			veh_cols[vehicle] = nil
		end
	end
end
addEvent("GTIrentals.destroyRental_", true)
addEventHandler("GTIrentals.destroyRental_", root, destroyRental)

function getVehicleRentTime(vehicle,mins)
	if (not activeRentals[vehicle]) then return false end
	local duration = activeRentals[vehicle].duration
	
	if (mins) then
		return math.floor( (getRealTime().timestamp - duration) / 60)
	end
	return ((getRealTime().timestamp - duration) / 3600)
end

function getHourlyRentalCost(vehicle)
	local payment
	local _vehicle
	
	if isElement(vehicle) then
		_vehicle = getElementModel(vehicle)
	else
		_vehicle = vehicle
	end
	
	payment = math.floor(getVehicleCost(_vehicle) / 333)
	if (payment > MAX_HR_PAYMENT) then payment = MAX_HR_PAYMENT end
	
	return payment
end

addEventHandler("onPlayerQuit", root, function()
	destroyRental(source)
end)

addCommandHandler("djv", function(player)
	local vehicle = rentVehicles[player]
	if (not isElement(vehicle)) then return end
	if (exports.GTIutil:getElementSpeed(vehicle) > 5 and getVehicleOccupant(vehicle) == player) then 
		outputChatBox("No puedes destruir el vehiculo rentado si lo estan ocupado o si va en velocidad", player, 255, 128, 0)
	return end
	
	triggerEvent("onRentalVehicleHide", vehicle, player)
	triggerClientEvent(player, "onClientRentalVehicleHide", vehicle, player)
	destroyRental(player)
end)

-- Rental Exports
------------------>>

function isVehicleRental(vehicle)
	if (activeRentals[vehicle]) then return true end
	return false
end

function getVehicleOwner(vehicle)
	if (activeRentals[vehicle]) then
		return activeRentals[vehicle].owner or false
	end
	return false
end

function getPlayerRentalVehicle(player)
	return rentVehicles[player] or false
end

-- Conditions
------------------>>

function cleanUp(player)
	if not player or not isElement(player) then return end
	
	destroyRental(player)
end
addEventHandler("onPlayerQuitJob",root,function() cleanUp(source) end)
addEventHandler("onPlayerGetJob",root,function() cleanUp(source) end)
addEventHandler("onPlayerWasted",root,function() cleanUp(source) end)
addEventHandler("onPlayerJobDivisionChange",root,function() cleanUp(source) end)

addEventHandler("onVehicleExplode",root,
function()
	if isVehicleRental(source) then
		local owner = getVehicleOwner(source)
		destroyRental(owner)
	end
end)


function waterCheck()
	for k,v in pairs(rentVehicles) do
		if (isElement(v) and isElementInWater(v)) then
			destroyRental(k)
		end
	end
end
setTimer(waterCheck,3000,0)

local rentalBlip = {}
function markingRentals(player)
    if ( rentalBlip[player] ) then
        for i, blips in ipairs ( rentalBlip[player] ) do
			if (isElement(blips)) then
                destroyElement(blips)
            end
        end
		rentalBlip[player] = nil
    else
        for _, vehicles in ipairs ( getElementsByType("vehicle") ) do
			if ( getElementData(vehicles, "rental") ) then
				local x, y, z = getElementPosition(vehicles)
				local blip = createBlip ( x, y, z, 0, 2, 255, 125, 0, 255, 0, 1000, player )
					if not ( rentalBlip[player] ) then 
						rentalBlip[player] = {} 
					end
				table.insert(rentalBlip[player], blip)
			end     
		end
	end
end
addCommandHandler ("markrentals", markingRentals)

function getVehicleCost(ID)
	local vehPrices = getVehiclePriceTable()
	for category,v in pairs(vehPrices) do
		for i,v in ipairs(vehPrices[category]) do
			if (v.id == ID) then
				return v.cost
			end
		end
	end
	return DEFAULT_COST
end