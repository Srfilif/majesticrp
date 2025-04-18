----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 25 Dec 2014
-- Resource: GTIhousing/storage.slua
-- Version: 1.0
----------------------------------------->>

local tip = {}

-- Get Player, House Inventory
------------------------------->>

addEvent("GTIhousing.getHouseStorage", true)
addEventHandler("GTIhousing.getHouseStorage", root, function(house)
	if (not client) then client = source end
	local plrInv = getPlayerInventory(client)
	local houseInv = getHouseInventory(house)
	triggerClientEvent(client, "GTIhousing.getHouseStorage", resourceRoot, plrInv, houseInv)
end)

-- Transfer Between
-------------------->>

addEvent("GTIhousing.transferToHouse", true)
addEventHandler("GTIhousing.transferToHouse", root, function(house, item, amount)
	if (tip[client]) then return end
	tip[client] = true
	setTimer(function(client) tip[client] = nil end, 3000, 1, client)
	-- Weapon Storage
	if (isItemWeapon(item)) then
		local slot = getSlotFromWeapon(item)
		local amount = amount or getPedTotalAmmo(client, slot)
		local houseInv = getHouseInventory(house)
		local exists
				
			-- Reset to what you actually have
		if (amount > getPedTotalAmmo(client, slot)) then
			amount = getPedTotalAmmo(client, slot)
		end
		
		-- Add Weapon to House
		for i,v in ipairs(houseInv) do	-- Check if Exists
			if (v[1] == item) then
				exists = true
				v[2] = v[2] + amount
				break
			end
		end
		if (not exists) then
			table.insert(houseInv, {item, amount})
		end
		setHouseInventory(house, houseInv)
		
		-- Take Ammo
		if (amount == getPedTotalAmmo(client, slot)) then
			takeWeapon(client, item)
		else
			takeWeapon(client, item, amount)
		end
		updateWeaponInInventory(client, item, getPedTotalAmmo(client, slot))
	end
	triggerEvent("GTIhousing.getHouseStorage", client, house)
end)

addEvent("GTIhousing.transferToPlayer", true)
addEventHandler("GTIhousing.transferToPlayer", root, function(house, item, amount)
	if (tip[client]) then return end
	tip[client] = true
	setTimer(function(client) tip[client] = nil end, 3000, 1, client)
	-- Weapon Storage
	if (isItemWeapon(item)) then
		local houseInv = getHouseInventory(house)
		local max_ammo = getWeaponMaxAmmo(client, item)
		if (type(max_ammo) ~= "number") then max_ammo = 1 end
		local slot = getSlotFromWeapon(item)
		local weapon = getPedWeapon(client, slot)
		local ammo = getPedTotalAmmo(client, slot)
		local exists
		
		-- Weapon Conflict Check
		if (isItemWeapon(weapon) and ammo > 0 and weapon ~= item) then
			outputChatBox("You must add your current "..getWeaponNameFromID(weapon).." to your storage before removing your "..getWeaponNameFromID(item).." to avoid losing it.", client, 255, 125, 0)
			return
		end
		
		-- Remove Weapon from House
		for i,v in ipairs(houseInv) do	-- Check if Exists
			if (v[1] == item) then
					-- Ammo Verification Process -->>
				amount = amount or v[2]
				if (amount > v[2]) then amount = v[2] end				-- Make sure you don't take out more than you have
				if (amount > max_ammo) then amount = max_ammo end		-- ...or more than the max ammo allowed
				
				if (weapon == item and (ammo + amount) > max_ammo) then -- ...even if you already have the weapon
					amount = max_ammo-ammo
				end
			
				v[2] = v[2] - amount
				exists = true
				if (v[2] == 0) then
					table.remove(houseInv, i)
				end
				break
			end
		end
		if (not exists) then
			outputChatBox("Error: Item not found. Cannot transfer.", client, 255, 25, 25)
			return
		end
		setHouseInventory(house, houseInv)
		
		-- Give Ammo
		giveWeapon(client, item, amount, true)
		updateWeaponInInventory(client, item, getPedTotalAmmo(client, slot))
	end
	triggerEvent("GTIhousing.getHouseStorage", client, house)
end)

-- Player Inventory
-------------------->>

function getPlayerInventory(player)
	if (not isElement(player)) then return false end
		-- Weapons
	local weapons = {}
	for i=0,11 do
		local weapon = getPedWeapon(player, i)
		local ammo = getPedTotalAmmo(player, i)
		if (weapon ~= 0 and ammo > 0) then
			table.insert(weapons, {weapon, ammo})
		end
	end
	return weapons
end

-- House Inventory
------------------->>

function getHouseInventory(house)
	if (not house or type(house) ~= "number") then return {} end
		-- Weapons
	local weapons = getHouseData(house, "inv.weapons") or ""
	if (#weapons == 0) then return {} end
	local weapons = split(weapons, ";")
	for i,v in ipairs(weapons) do
		weapons[i] = split(v, ",")
		weapons[i] = {tonumber(weapons[i][1]), tonumber(weapons[i][2])}
	end
	return weapons
end

function setHouseInventory(house, inventory)
	if (not house or type(house) ~= "number") then return false end
		-- Weapons
	for i,v in ipairs(inventory) do
		inventory[i] = table.concat(v, ",")
	end
	inventory = table.concat(inventory, ";")
	setHouseData(house, "inv.weapons", inventory)
	return true
end

function clearHouseInventory(house)
	if (not house or type(house) ~= "number") then return false end
	setHouseData(house, "inv.weapons", nil)
	return true
end