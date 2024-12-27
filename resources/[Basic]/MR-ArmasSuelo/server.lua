-----------------------------------------------------------
--  ___     ___ _ _ _  __   ___             __   ____    --
-- / __|_ _| __(_) (_)/ _| |   \ _____ __  / /  / /\ \   --
-- \__ \ '_| _|| | | |  _| | |) / -_) V / < <  / /  > >  --
-- |___/_| |_| |_|_|_|_|   |___/\___|\_/   \_\/_/  /_/   --
-----------------------------------------------------------                                                   
-- SrFilif Dev © 2023 | All rights reserved copyright 2023


local function createGroundWeapon(weaponid, ammo, clip, posX, posY, posZ, rotX, rotY, rotZ, interior, dimension)
	local temp = createElement("groundweapon")
	for i,p in ipairs(getElementsByType("player")) do
		triggerClientEvent(p,"GroundPickups:createGroundWeapon",p,temp,weaponid,ammo,clip,posX,posY,posZ,rotX,rotY,rotZ,interior,dimension)
	end
	return temp
end

local function destroyWeapons()

	for i,p in ipairs(getElementsByType("groundweapon")) do
		destroyElement(p)
	end

end

local function pickupWeapon(groundweapon,weaponid,ammo,clip)

	if client~=source then return end
	destroyElement(groundweapon)
	giveWeapon(client,weaponid,ammo,true)
setPedAnimation(client, "bomber", "bom_plant_2idle", -1, false, false, false, false)

end

local function dropWeapon(weaponid, ammo, clip, posX, posY, posZ, rotX, rotY, rotZ, interior, dimension)

	if client~=source then return end
	createGroundWeapon(weaponid, ammo, clip, posX, posY, posZ, rotX, rotY, rotZ, interior, dimension)
	takeWeapon(client,weaponid)
	setPedAnimation(client, "bomber", "bom_plant_2idle", -1, false, false, false, false)

end

local function initScript()

	addEvent("GroundPickups:pickupWeapon", true)
	addEvent("GroundPickups:dropWeapon", true)
	addEventHandler("GroundPickups:pickupWeapon",root,pickupWeapon)
	addEventHandler("GroundPickups:dropWeapon",root,dropWeapon)
	addEventHandler("onResourceStop",resourceRoot,destroyWeapons)

end

addEventHandler("onResourceStart",resourceRoot,initScript)