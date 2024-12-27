----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 09 Nov 2014
-- Resource: GTIhousing/housing.slua
-- Version: 1.0
----------------------------------------->>

local activeID = {}	-- Current House ID

-- Show Housing Panel
---------------------->>

addEventHandler("onPickupHit", resourceRoot, function(player)
	if (isPedInVehicle(player)) then return end
	exports.GTIhud:drawNote("HouseMsg", "Presiona 'f' par abrir el panel de casas", player, 30, 160, 115, 5000)
	if (not isKeyBound(player, "z", "up", showHousingPanel)) then
		bindKey(player, "f", "up", showHousingPanel)
	end
	activeID[player] = source
end)

function showHousingPanel(player)
	if (not activeID[player] or not isElement(activeID[player])) then return end
	unbindKey(player, "f", "up", showHousingPanel)
	exports.GTIhud:drawNote("HouseMsg", nil, player)
	
	local x,y = getElementPosition(player)
	local px,py = getElementPosition(activeID[player])
	if (isPedInVehicle(player) or getDistanceBetweenPoints2D(x,y,px,py) >= 2) then activeID[player] = nil return end
	
		-- Home GUI Information
	local house = {}
	house["id"] 		= getElementData(activeID[player], "id")
	local id 			= house["id"]
	house["interior"] 	= getHouseData(id, "interior")
	local name 			= getHouseData(id, "name") or false
	house["address"] 	= (name and name.."\n" or "")..getHouseData(id, "address")
	local owner			= getHouseData(id, "owner")
	if (owner) then
		local player = getAccountPlayer(getAccount(owner)) or "Sin Dueño"
		local _owner = getAccountData(getAccount(owner),"lastname") or "Sin Dueño"
		house["owner"] 	= player and getPlayerName(player) or "Sin Dueño"
	else
		house["owner"]	= "Sin Dueño"
	end
	house["value"] 		= getHouseData(id, "value")
	
		-- Home Ownership
	house["isOwner"] 	= doesPlayerOwnHouse(player, id)
	house["forSale"] 	= isHouseForSale(id)
	house["saleCost"]	= getHouseSaleCost(id)
	house["boughtFor"] 	= getHouseData(id, "bought_for")
		-- Home Rental
	house["forRent"] 	= isHouseForRent(id)
	house["renter"] 	= getHouseRenter(id)
	house["rent"] 		= getHouseRentCost(id)
		-- Admin Functions
	house["locked"]		= isHouseLocked(id)
	house["access"]		= canPlayerAccessHouse(player, id)

	triggerClientEvent(player, "GTIhousing.showHousingPanel", resourceRoot, house, activeID[player])
end

addEvent("GTIhousing.closePanel", true)
addEventHandler("GTIhousing.closePanel", root, function()
	activeID[client] = nil
end)

-- Enter House
--------------->>

addEvent("GTIhousing.enterHouse", true)
addEventHandler("GTIhousing.enterHouse", root, function(id)
	if (isHouseLocked(id) and not canPlayerAccessHouse(client, id)) then
		outputChatBox("Esta casa esta cerrada, No puedes entrar", client, 255, 125, 0)
		return
	end	
	local int = getHouseInterior(id)
	warpIntoHouseInterior(client, int, id)
	activeID[client] = nil
end)

-- Buy House
------------->>

addEvent("GTIhousing.buyHouse", true)
addEventHandler("GTIhousing.buyHouse", root, function(house)
	local bought = buyHouse(client, house)
	if (not bought) then return end
	triggerClientEvent("GTIhousing.closePanel", resourceRoot, house)
	activeID[client] = nil
end)

-- Sell House
-------------->>

addEvent("GTIhousing.sellHouse", true)
addEventHandler("GTIhousing.sellHouse", root, function(house, toPublic, value)
	if (toPublic) then
		sellHouse(client, house, value)
	else
		sellHouse(client, house)
	end
end)

addEvent("GTIhousing.revokeSale", true)
addEventHandler("GTIhousing.revokeSale", root, function(house)
	revokeSale(client, house)
	triggerClientEvent("GTIhousing.closePanel", resourceRoot, house)
end)
