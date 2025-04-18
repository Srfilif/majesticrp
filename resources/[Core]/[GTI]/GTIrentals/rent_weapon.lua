----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 07 Mar 2015
-- Resource: GTIrentals/rent_weapon.slua
-- Version: 1.0
----------------------------------------->>

local weap_rest = {}	-- Restrictions Table by Pickup
local weap_data = {}	-- Weapon ID and Ammo by Pickup

local models = {[1] = 331, [2] = 333, [3] = 334, [4] = 335, [5] = 336, [6] = 337, [7] = 338, [8] = 339, [9] = 341,
	[10] = 321, [11] = 322, [12] = 323, [14] = 325, [15] = 326, [44] = 368, [45] = 369, [46] = 371, [40] = 364, [43] = 367
}

addEvent("onPlayerGetJob",true)

-- Create Pickups
------------------>>

addEventHandler("onResourceStart", root, function(resource)
	resource = getResourceName(resource)
	if (resource ~= "GTIrentals" and resource ~= "GTIrentalTable") then return end
	
	for i,v in ipairs(getElementsByType("pickup", resourceRoot)) do
		destroyElement(v)
	end
	weap_data = {}
	weap_rest = {}
	
	for i,v in ipairs(exports.GTIrentalTable:weaponsTable()) do
		local pickup = createPickup(v.pos[1], v.pos[2], v.pos[3]+1, 3, models[v.id] or getOriginalWeaponProperty(v.id, "std", "model"), 0)
		local int = v.pos[4] or 0
		local dim = v.pos[5] or 0
		
		setElementInterior(pickup,int)
		setElementDimension(pickup,dim)
		addEventHandler("onPickupHit", pickup, function() cancelEvent() end)
		local col = createColSphere(v.pos[1], v.pos[2], v.pos[3]+1, 1)
		weap_data[col] = {v.id, v.ammo}
		weap_rest[col] = {v.res,int,dim}
	end
end)

-- Rent Weapon
--------------->>

addEventHandler("onColShapeHit", resourceRoot, function(hitEl)
	if (not isElement(hitEl)) then return false end
	if (getElementType(hitEl) ~= "player") then return false end
	if (getPedOccupiedVehicle(hitEl)) then return false end
	
	player = hitEl
	
	if weap_data[source] then
		local int,dim = weap_rest[source][2] or 0, weap_rest[source][3] or 0
		local pInt,pDim = getElementInterior(player),getElementDimension(player)
		
		--Check if int and dim are same as player
		if ((int ~= pInt) or (dim ~= pDim)) then return end
	end
	
	if (not weap_rest[source]) then return end
	
	local res = weap_rest[source][1]
	local passed
	local reason;
	if (not res) then 
		passed = true 
	else
		for i,v in ipairs(res) do
				-- Police Officer Check
			if (v == "Police") then
				if (exports.GTIpoliceArrest:canPlayerArrest(player)) then
					passed = true; break
				else
					reason = "Law Enforcement"
				end
			end
				-- Occupation Check
			if (v == exports.GTIemployment:getPlayerJob(player, true)) then
				passed = true; break
			else
				reason = v.."s"
			end
			if (string.find(v, ";")) then
				v = split(v, ";")
				-- Level Check
					-- Police Level Check
				if (v[1] == "Police") then
					if (exports.GTIpoliceArrest:canPlayerArrest(player)	and exports.GTIemployment:getPlayerJobLevel(player, "Police Officer") >= tonumber(v[2])) then
						passed = true; break
					else
						reason = "L"..v[2].." Law Enforcement"
					end
					-- Job Level Check
				elseif (tonumber(v[2])) then
					if (v[1] == exports.GTIemployment:getPlayerJob(player, true) and exports.GTIemployment:getPlayerJobLevel(player, v[1]) >= tonumber(v[2])) then
						passed = true; break
					else
						reason = "L"..v[2].." "..v[1].."s"
					end
					-- Job Division Check
				elseif (not tonumber(v[2])) then
					if (v[1] == exports.GTIemployment:getPlayerJob(player, true) and v[2] == exports.GTIemployment:getPlayerJobDivision(player)) then
						passed = true; break
					else
						reason = v[1].."s of the "..v[2].." division"
					end
				end
			end
		end
	end

	if (not passed) then
		exports.GTIhud:dm("This weapon is restricted to "..reason.." only.", player, 255, 25, 25)
		return
	end
		
	
	bindKey(player, "z", "down", pickupWeapon, source)
	local r,g,b = getPlayerNametagColor(player)
	exports.GTIhud:drawNote("GTIrentals", "Press [Z] to pick up this weapon", player, r, g, b, 7000)
end)

addEventHandler("onColShapeLeave", resourceRoot, function(player)
	if (not isElement(player) or getElementType(player) ~= "player") then return end
	if (not isKeyBound(player, "z", "down", pickupWeapon)) then return end
	unbindKey(player, "z", "down", pickupWeapon)
	exports.GTIhud:drawNote("GTIrentals", nil, player)
end)

addEventHandler("onPlayerGetJob", root, function()
	if (not isElement(source)) then return end
	unbindKey(source,"z","down",pickupWeapon)
	exports.GTIhud:drawNote("GTIrentals",nil,source)
end)
addEventHandler("onPlayerQuitJob", root, function()
	if (not isElement(source)) then return end
	unbindKey(source,"z","down",pickupWeapon)
	exports.GTIhud:drawNote("GTIrentals",nil,source)
end)
addEventHandler("onPlayerChangeDivision", root, function()
	if (not isElement(source)) then return end
	unbindKey(source,"z","down",pickupWeapon)
	exports.GTIhud:drawNote("GTIrentals",nil,source)
end)

function pickupWeapon(player, _, _, source)
	playSoundFrontEnd(player, 6)
	exchangeWeapon(player, weap_data[source][1], weap_data[source][2])
end

-- Exchange Weapon
------------------->>

function exchangeWeapon(player, weapon, ammo)
	local slot = getSlotFromWeapon(weapon)
	local plr_weapon = getPedWeapon(player, slot)
	if (plr_weapon ~= 0 and plr_weapon ~= weapon) then
		local plr_ammo = getPedTotalAmmo(player, slot)
		if (plr_ammo ~= 0) then 
			addWeaponToStorage(player, plr_weapon, plr_ammo)
		end
	end
	
	takeWeapon(player, plr_weapon)
	takeWeapon(player, weapon)
	giveWeapon(player, weapon, ammo, true)
	addRentedWeapon(player, weapon)
	return true
end

--[[function takeBackWeapon(player, weapon, ammo)
	removeWeaponFromStorage(player, weapon)
	
	local slot = getSlotFromWeapon(weapon)
	local plr_weapon = getPedWeapon(player, slot)
	if (plr_weapon ~= 0) then
		takeWeapon(player, plr_weapon)
	end
	
	takeWeapon(player, weapon)
	giveWeapon(player, weapon, ammo, true)
	removeRentedWeapon(player, weapon)
	return true
end--]]

-- Stored Weapons
------------------>>
local db = dbConnect("sqlite", "database/rentals.db")
dbExec(db, "CREATE TABLE IF NOT EXISTS `inventory`(`id` INT NOT NULL, `name` TEXT, PRIMARY KEY(id))")

local inventory_online = {}	-- Is Database Online?
local inventory = {}		-- Account Data Cache

-- Inventory Exports
--------------------->>

function invSet(account, key, value)
	if (not account or not key) then return false end
	if (isGuestAccount(account) or type(key) ~= "string") then return false end
	local account = getAccountName(account)
	if (not inventory_online[account]) then	return false end

	if (not inventory[account]) then
		inventory[account] = {}
		dbExec(db, "INSERT INTO `inventory`(id, name) VALUES(?,?)", math.random(0, 99999), account)
	end
	--end
	
	if (inventory["Console"] and inventory["Console"][key] == nil) then
		inventory["Console"][key] = true
		dbExec(db, "ALTER TABLE `inventory` ADD `??` text", key)
	end
	--end
	
	inventory[account][key] = value

	if (value ~= nil) then
		dbExec(db, "UPDATE `inventory` SET `??`=? WHERE name=?", key, tostring(value), account)
	else
		dbExec(db, "UPDATE `inventory` SET `??`=NULL WHERE name=?", key, account)
	end
	--end
	return true
end

function invGet(account, key)
	if (not account or not key) then return nil end
	if (isGuestAccount(account) or type(key) ~= "string") then return nil end
	local account = getAccountName(account)
	if (not inventory_online[account]) then	return nil end
	
	if (inventory[account] == nil) then return nil end
	if (inventory[account][key] == nil) then return nil end
	
	return tonumber(inventory[account][key]) or inventory[account][key]
end

function getStoredWeapons(player)
	local account = getPlayerAccount(player)
	local weapons = invGet(account, "rentals.storage") or ""
	local weapTable = {}
	weapTable = split(weapons, ";")
	for i,weap in ipairs(weapTable) do
		weap = split(weap, ",")
		weapTable[i] = {tonumber(weap[1]), tonumber(weap[2])}
	end
	return weapTable
end

function addWeaponToStorage(player, weapon, ammo)
		-- Follow Global Max Ammo Limits
	if (ammo > (getWeaponMaxAmmo(player, weapon) or 1)) then
		ammo = getWeaponMaxAmmo(player, weapon) or 1
	end
	local weapons = getStoredWeapons(player)
	for i,weap in ipairs(weapons) do
		if (weap[1] == weapon) then
			ammo = weap[2]+ammo
			if (ammo > getWeaponMaxAmmo(player, weapon)) then
				ammo = getWeaponMaxAmmo(player, weapon)
			end
			weapons[i] = {weapon, ammo}
			setStoredWeapons(player, weapons)
			return true
		end
	end
	
	table.insert(weapons, {weapon, ammo})
	setStoredWeapons(player, weapons)
	return true
end

--[[function removeWeaponFromStorage(player, weapon)
	local weapons = getStoredWeapons(player)
	for i,weap in ipairs(weapons) do
		if (weap[1] == weapon) then
			table.remove(weapons, i)
			setStoredWeapons(player, weapons)
			return true
		end
	end
	return false
end--]]

function setStoredWeapons(player, weapons)
	local weapTable = {}
	for i,weap in ipairs(weapons) do
		weapTable[i] = table.concat(weap, ",")
	end
	local weapString = table.concat(weapTable, ";")
	if (weapString == "") then weapString = nil end
	
	local account = getPlayerAccount(player)
	invSet(account, "rentals.storage", weapString)
	return true
end

-- Rented Weapons
------------------>>

function getRentedWeapons(player)
	local account = getPlayerAccount(player)
	local weapons = invGet(account, "rentals.rentweap") or ""
	local weapTable = {}
	weapTable = split(weapons, ",")
	for i,weap in ipairs(weapTable) do
		weapTable[i] = tonumber(weap)
	end
	return weapTable
end

function addRentedWeapon(player, weapon)
	local weapons = getRentedWeapons(player)
	for i,weap in ipairs(weapons) do
		if (weap == weapon) then
			return true
		end
	end
	table.insert(weapons, weapon)
	setRentedWeapons(player, weapons)
	return true
end

function removeRentedWeapon(player, weapon)
	local weapons = getRentedWeapons(player)
	for i,weap in ipairs(weapons) do
		if (weap == weapon) then
			table.remove(weapons, i)
			setRentedWeapons(player, weapons)
			return true
		end
	end
	return false
end

function removeAllRentedWeapons(player)
	local weapons = getRentedWeapons(player)
	for i,weap in ipairs(weapons) do
		takeWeapon(player, weap)
	end
	setRentedWeapons(player, {})
	return true
end

function setRentedWeapons(player, weapons)
	local weapons = table.concat(weapons, ",")
	local account = getPlayerAccount(player)
	if (weapons == "") then weapons = nil end
	invSet(account, "rentals.rentweap", weapons)
	return true
end

-- Return Weapons on Quit
-------------------------->>

function returnAllStoredWeapons(_, resign)
	removeAllRentedWeapons(source)
	local weapons = getStoredWeapons(source)
	for i,weap in ipairs(weapons) do
			-- Take Current Weapon
		local slot = getSlotFromWeapon(weap[1])
		local plr_weapon = getPedWeapon(source, slot)
		takeWeapon(source, plr_weapon)
			-- Return Stored Weapon
		giveWeapon(source, weap[1], weap[2])
	end
	setStoredWeapons(source, {})
end
addEvent("onPlayerQuitJob", true)
addEventHandler("onPlayerQuitJob", root, returnAllStoredWeapons)
addEventHandler("onPlayerJobDivisionChange", root, returnAllStoredWeapons)
addEventHandler("onPlayerArrested", root, returnAllStoredWeapons)

local weaponLimits = {
	-- Pistols
	[22] = 9999,		-- Pistol
	[23] = 9999,		-- Silenced Pistol
	[24] = 9999,		-- Desert Eagle
	-- Shotguns
	[25] = 9999,		-- Shotgun
	[26] = 9999,		-- Sawn-Off Shotgun
	[27] = 9999,		-- SPAZ-12 Combat Shotgun
	-- Sub-Machine Guns
	[28] = 9999,	-- Uzi
	[29] = 9999,	-- MP5
	[32] = 9999,	-- Tec-9
	-- Assault Rifles
	[30] = 9999,	-- AK-47
	[31] = 9999,	-- M4
	-- Rifles
	[33] = 9999,		-- Country Rifle
	[34] = 9999,		-- Sniper Rifle
	-- Heavy Weapons
	[35] = 9999,		-- Rocket Launcher
	[36] = 9999,		-- Heat-Seaking RPG
	[37] = 9999,	-- Flamethrower
	[38] = 9999,	-- Minigun
	-- Projectiles
	[16] = 9999,		-- Grenade
	[17] = 9999,		-- Tear Gas
	[18] = 9999,		-- Molotov Cocktails
	[39] = 9999,		-- Satchel Charges
	-- Special 1
	[41] = 9999,	-- Spraycan
	[42] = 9999,	-- Fire Extinguisher
	[43] = 9999,		-- Camera
}

-- Weapon Limit Functions
-------------------------->>

function getWeaponMaxAmmo(player, weapon)
	if (not isElement(player)) then return false end
	
	local multi = 1	
	if (type(weapon) == "number" and weapon <= 47) then
		return math.floor( (weaponLimits[weapon] or 1) * multi )
	else
		local limit2 = {}
		for weap,ammo in pairs(weaponLimits) do
			limit2[weap] = math.floor( ammo * multi )
		end
		return limit2
	end
end