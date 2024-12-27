----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 07 Nov 2014
-- Resource: GTIhousing/housing.slua
-- Version: 1.0
----------------------------------------->>

local houses = {}		-- Table of House Icons
local addresses = {}	-- Table of IDs by Address

SERVER_SALE = 0.9	-- Deflation from Original Value for server sales
HOUSE_LIMIT = 3		-- Limit on number of houses a player can own
HOUSE_LIMIT_DONOR = 5	-- House Limit (Premium Feature)

local house_acl = {
	["Admin"] = true,
	["Carlos_Mulet"] = true,
}

-- Load Houses
--------------->>

function loadHouses(houseData)
	for id in pairs(houseData) do
		if (id ~= 0) then
				-- Create House Icon
			local loc = getHouseData(id, "location")
			local loc = split(loc, ",")
			local x,y,z,int,dim = tonumber(loc[1]), tonumber(loc[2]), tonumber(loc[3]), tonumber(loc[4]), tonumber(loc[5])
			local for_sale = isHouseForSale(id)
			local house = createPickup(x, y, z, 3, (for_sale and 1273 or 1272), 0)
			setElementInterior(house, int)
			setElementDimension(house, dim)
			houses[id] = house
				-- Set Element Data
			setElementData(house, "id", id)
			local value = getHouseData(id, "sale_cost") or getHouseData(id, "value")
			if (not isHouseForSale(id)) then
				value = getHouseData(id, "bought_for") or getHouseData(id, "sale_cost")
			end
			setElementData(house, "value", value)
			local address = getHouseData(id, "address")
			setElementData(house, "address", address)
				-- Associate Address
			addresses[address] = id
			
			createHouseInterior(id, getHouseInterior(id))
		end
	end
end

-- Create/Delete House
----------------------->>

function createHouse(player, address, location, garage, int_id, value)
		-- Get Next ID
	local id = getNextAvailibleID()
	
	if (addresses[address]) then
		outputChatBox("Una casa con este nombre ya existe, utiliza uno diferente", player, 255, 25, 25)
		return
	end
	
		-- Create House
	local x,y,z,int,dim = unpack(location)
	local house = createPickup(x, y, z, 3, 1273, 0)
	setElementInterior(house, int)
	setElementDimension(house, dim)
	
	setElementData(house, "id", id)
	setElementData(house, "value", value)
	setElementData(house, "address", address)
	houses[id] = house
	
	createHouseInterior(id, int_id)
	
		-- Add to Database
	setHouseData(id, "name", nil)
	setHouseData(id, "address", address)
	setHouseData(id, "location", table.concat(location, ","))
	setHouseData(id, "garage", table.concat(garage, ","))
	setHouseData(id, "interior", int_id)
	setHouseData(id, "value", value)
	setHouseData(id, "for_sale", 1)
	setHouseData(id, "bought_for", nil)
	setHouseData(id, "sale_cost", value)
	setHouseData(id, "for_rent", 0)
	setHouseData(id, "renter", nil)
	setHouseData(id, "rent_cost", nil)
	addresses[address] = id
	
	outputChatBox("HOUSING: "..address.." fue creada correctamente.", player, 25, 255, 25)
	return true
end

function deleteHouse(player, house)
	if (not isElement(player) or not house or type(house) ~= "number") then 
		return 
	end
	if (not houses[house]) then
		exports.GTIhud:dm("Invalid House ID Provided", player, 255, 125, 0)
		return
	end
	local owner = getHouseOwner(house)
	if (owner) then
	end
	local x, y, z = getHousePosition(house)
	print("CASAS: "..getHouseAddress(house).." Borrada correctamente")
	addresses[getElementData(houses[house], "address")] = nil
	destroyElement(houses[house])
	houses[house] = nil
	removeHouseData(house)
	return true
end

function borrarCasa(player, cmd, id)
	if (not house_acl[getAccountName(getPlayerAccount(player))]) then return end
	deleteHouse(player, tonumber(id))
end
addCommandHandler("deletehouse", borrarCasa)

function reloadHouse(id)
	local x,y,z,int,dim = getHousePosition(id)
		-- Destroy House
	destroyElement(houses[id])
	houses[id] = nil
		-- Recreate House
	local house = createPickup(x, y, z, 3, (isHouseForSale(id) and 1273 or 1272), 0)
	setElementInterior(house, int)
	setElementDimension(house, dim)
	
	setElementData(house, "id", id)
	if (isHouseForSale(id)) then
		setElementData(house, "value", getHouseData(id, "sale_cost") or getHouseData(id, "value"))
	else
		setElementData(house, "value", getHouseData(id, "bought_for") or getHouseData(id, "sale_cost"))
	end
	setElementData(house, "address", getHouseData(id, "address"))
	houses[id] = house
	return true
end

-- Get House ID
---------------->>

function getHouseIDFromAddress(address)
	if (not address or type(address) ~= "string") then return false end
	return addresses[address] or false
end

function getHouseFromID(id)
	if (not id or type(id) ~= "number") then return false end
	return houses[id] or false
end

-- Get House Data
------------------>>

function getHousePosition(id)
	if (not id or type(id) ~= "number") then return false end
	local x,y,z = getElementPosition(houses[id])
	local int = getElementInterior(houses[id])
	local dim = getElementDimension(houses[id])
	return x, y, z, int, dim
end

function getHouseGaragePosition(id)
	if (not id or type(id) ~= "number") then return false end
	local loc = getHouseData(id, "garage")
	local loc = split(loc, ",")
	return tonumber(loc[1]), tonumber(loc[2]), tonumber(loc[3]), tonumber(loc[4])
end

function getHouseInterior(id)
	if (not id or type(id) ~= "number") then return false end
	return getHouseData(id, "interior") or false
end

function getHouseAddress(id)
	if (not id or type(id) ~= "number") then return false end
	return getHouseData(id, "address") or false
end

function getHouseOriginalValue(id)
	if (not id or type(id) ~= "number") then return false end
	return getHouseData(id, "value") or false
end

-- Home Ownership
------------------>>

function doesPlayerOwnHouse(player, house)
	if (not isElement(player) or not house or type(house) ~= "number") then return false end
	local owner = getHouseOwner(house)
	local player = getPlayerAccount(player)
	return owner == player or false
end	

function getHouseOwner(id)
	if (not id or type(id) ~= "number") then return false end
	local owner = getHouseData(id, "owner") or false
	if (owner) then 
		return getAccount(owner)
	else
		return false
	end	
end

function getHouseSaleCost(id)
	if (not id or type(id) ~= "number") then return false end
	return getHouseData(id, "sale_cost") or getHouseOriginalValue(id)
end

function isHouseForSale(id)
	if (not id or type(id) ~= "number") then return false end
	return getHouseData(id, "for_sale") == 1 or false
end

-- Buy/Sell House
------------------>>

function buyHouse(player, house)
	if (not isElement(player) or not house or type(house) ~= "number") then return false end
		-- Check Money
	local money = getPlayerMoney(player)
	local cost = getHouseSaleCost(house)
	if (cost > money) then
		outputChatBox("No tienes el dinero suficiente, nesecitas $"..tocomma(cost-money).." de dinero.", client, 255, 125, 0)
		return false
	end
	local houses = #getPlayerTotalHouses(player)
	local houseLimit = getPlayerMaxHouses(player)
	if (houses >= houseLimit) then
		outputChatBox("No puedes comprar esta casa. Alcanzaste el limite "..(houseLimit > HOUSE_LIMIT and "premium " or "basico").." de ("..houseLimit.." Casas) por Jugador", client, 255, 125, 0)
		return
	end
	takePlayerMoney(player, cost)
		-- Give Money to Owner
	local owner = getHouseOwner(house)
	if (owner) then
		givePlayerMoney(player, cost)
		local plr = getAccountPlayer(owner)
		if (plr) then
			exports.GTIhud:dm("HOUSING: Your house at "..getHouseAddress(house).." has been sold to "..getPlayerName(player).." for $"..tocomma(cost), plr, 25, 255, 25)
		end
		removeOwnerCache(getAccountName(owner), house)
	end	
	local account = getPlayerAccount(player)
	local accName = getAccountName(account)
	setHouseData(house, "owner", accName)
	setHouseData(house, "for_sale", 0)
	setHouseData(house, "bought_for", cost)
	addOwnerCache(accName, house)	
	reloadHouse(house)
	outputChatBox("Felicidades! Ahora eres el nuevo dueño de "..getHouseAddress(house).."!", player, 25, 255, 25)
	return true
end

function tocomma(number)
	while true do
		number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return number
end

function sellHouse(player, house, value)
	if (not isElement(player) or not house or type(house) ~= "number") then return false end
	if (value and type(value) == "number") then
		setHouseData(house, "sale_cost", value)
	else
		removeOwnerCache(getAccountName(getHouseOwner(house)), house)
		setHouseData(house, "owner", nil)
		value = math.floor(getHouseData(house, "value") * SERVER_SALE)
		setHouseData(house, "sale_cost", value)
		givePlayerMoney(player, value)
	end
	setHouseData(house, "for_sale", 1)
	clearHouseInventory(house)
	
	outputChatBox(getHouseAddress(house).." fue colocada a la venta por $"..tocomma(value), player, 25, 255, 25)
	reloadHouse(house)
	return true
end

function revokeSale(player, house)
	if (not isElement(player) or not house or type(house) ~= "number") then return false end
	setHouseData(house, "for_sale", 0)
	outputChatBox("Removiste tu casa "..getHouseAddress(house).." de la venta!", player, 255, 125, 25)
	reloadHouse(house)
	return true
end

-- Lock/Unlock State
--------------------->>

function isHouseLocked(id)
	if (not id or type(id) ~= "number") then return false end
	return getHouseData(id, "locked") or false
end

function setHouseLocked(id, state)
	if (not id or type(id) ~= "number" or type(state) ~= "boolean") then return false end
	setHouseData(id, "locked", state)
	return true
end

-- House Access
---------------->>

function canPlayerAccessHouse(player, house)
	if (not isElement(player) or not house or type(house) ~= "number") then 
		return true 
	end
	-- House for Sale
	if (isHouseForSale(house)) then 
		return true 
	end
	-- House Unlocked
	if (not isHouseLocked(house)) then 
		return true 
	end
	-- House Locked & Is Owner
	if (doesPlayerOwnHouse(player, house)) then 
		return true 
	end
end

-- Ownership Change
-------------------->>

function setHouseOwner(house, owner)
	if (not house or type(house) ~= "number" or not owner or not getAccount(owner)) then return false end
	setHouseData(house, "owner", owner)
	clearHouseInventory(house)
	return true
end

-- House Limit
--------------->>

-- House Limit
--------------->>

function getPlayerMaxHouses(player)
	if (not isElement(player)) then return end
	return HOUSE_LIMIT
end

function getAccountMaxHouses(account)
	if (not account or isGuestAccount(account)) then return false end
	if (exports.GTIpremium:isAccountPremium(account, "max_houses")) then return HOUSE_LIMIT_DONOR end
	return HOUSE_LIMIT
end

-- Home Rentals
---------------->>

function getHouseRenter(id)
	if (not id or type(id) ~= "number") then return false end
	local renter = getHouseData(id, "renter") or false
	if (renter) then 
		return getAccount(renter)
	else
		return false
	end	
end

function getHouseRentCost(id)
	if (not id or type(id) ~= "number") then return false end
	return getHouseData(id, "rent_cost") or false
end

function isHouseForRent(id)
	if (not id or type(id) ~= "number") then return false end
	return getHouseData(id, "for_rent") == 1 or false
end

-- Miscellaneous
----------------->>

function getPlayerHousingNetWorth(player)
	if (not isElement(player)) then return false end
	local houses = getPlayerTotalHouses(player)
	
	local worth = 0
	for i,house in ipairs(houses) do
		local value = getHouseOriginalValue(house)
		local pprice = getHouseData(house, "bought_for") or 0
		if (value > pprice) then
			worth = worth + value
		else
			worth = worth + pprice
		end
	end
	return worth
end