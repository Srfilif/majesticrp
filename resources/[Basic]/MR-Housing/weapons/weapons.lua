----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 25 Dec 2014
-- Resource: GTIhousing/storage.slua
-- Version: 1.0
----------------------------------------->>

local tip = {}

local weaponSlots = {
	[0] = {0, 1},
	[1] = {2, 3, 4, 5, 6, 7, 8, 9},
	[2] = {22, 23, 24},
	[3] = {25, 26, 27},
	[4] = {28, 29, 32},
	[5] = {30, 31},
	[6] = {33, 34},
	[7] = {35, 36, 37, 38}, --Minigun slot
	[8] = {16, 17, 18, 39},
	[9] = {41, 42, 43},
	[10] = {10, 11, 12, 14, 15},
	[11] = {44, 45, 46},
}

-- Weapons Inventory
--------------------->>

function getWeaponsInventory(player)
	if (not isElement(player)) then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local weap = invGet(account, "weapons.inventory")
	if (not weap) then return {} end
	weap = split(weap, ";")
	
	local weapons = {}
	for i,weapon in ipairs(weap) do
		local weapon = split(weapon, ",")
		weapons[tonumber(weapon[1])] = tonumber(weapon[2])
	end
	
	return weapons	
end

function getWeaponAmmoFromInventory(player, weapon)
	if (not isElement(player) or type(weapon) ~= "number") then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local plr_inv = getWeaponsInventory(player)
	return plr_inv[weapon] or 0
end

function updateWeaponInInventory(player, weapon, ammo)
	if (not isElement(player) or type(weapon) ~= "number" or type(ammo) ~= "number") then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local plr_inv = getWeaponsInventory(player)
	plr_inv[weapon] = ammo
	
	setWeaponsInventory(player, plr_inv)
	return true
end

function setWeaponsInventory(player, inventory)
	if (not isElement(player) or type(inventory) ~= "table") then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local weapons = {}
	for i=1,46 do
		if (inventory[i]) then
			table.insert(weapons, 
				table.concat({i, inventory[i]}, ",")
			)
		end
	end
	weapons = table.concat(weapons, ";")
	invSet(account, "weapons.inventory", weapons)
	return true
end

giveWeapon_ = giveWeapon
function giveWeapon(player, weapon, ammo, setAsCurrent)
	-- Fix MTA flamethrower ammo bug
	if (weapon == 37) then
		return giveWeapon_(player, weapon, math.floor(ammo/10), setAsCurrent or false)
	else
		return giveWeapon_(player, weapon, ammo, setAsCurrent or false)
	end
end

local weaponLimits = {
	-- Pistols
	[22] = 750,		-- Pistol
	[23] = 750,		-- Silenced Pistol
	[24] = 750,		-- Desert Eagle
	-- Shotguns
	[25] = 600,		-- Shotgun
	[26] = 600,		-- Sawn-Off Shotgun
	[27] = 600,		-- SPAZ-12 Combat Shotgun
	-- Sub-Machine Guns
	[28] = 3500,	-- Uzi
	[29] = 3500,	-- MP5
	[32] = 3500,	-- Tec-9
	-- Assault Rifles
	[30] = 2500,	-- AK-47
	[31] = 2500,	-- M4
	-- Rifles
	[33] = 250,		-- Country Rifle
	[34] = 250,		-- Sniper Rifle
	-- Heavy Weapons
	[35] = 15,		-- Rocket Launcher
	[36] = 15,		-- Heat-Seaking RPG
	[37] = 1500,	-- Flamethrower
	[38] = 2500,	-- Minigun
	-- Projectiles
	[16] = 25,		-- Grenade
	[17] = 25,		-- Tear Gas
	[18] = 25,		-- Molotov Cocktails
	[39] = 25,		-- Satchel Charges
	-- Special 1
	[41] = 5000,	-- Spraycan
	[42] = 5000,	-- Fire Extinguisher
	[43] = 500,		-- Camera
}

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

function isItemWeapon(item)
	return getWeaponNameFromID(item) ~= "Fist"
end

function wasWeaponRented(player, weapon)
	if (not isElement(player) or not weapon or type(weapon) ~= "number") then return false end
	local rentals = exports.GTIrentals:getRentedWeapons(player)
	for i,weap in ipairs(rentals) do
		if (weap == weapon) then return true end
	end
	return false
end