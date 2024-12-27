----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 25 Dec 2014
-- Resource: GTIhousing/storage.slua
-- Version: 1.0
----------------------------------------->>

local SERVER_PORT = 22003
local inventory_online = {}	-- Is Database Online?
local inventory = {}		-- Account Data Cache

local db = dbConnect("sqlite", "database/inventory.db")
dbExec(db, "CREATE TABLE IF NOT EXISTS inventory(`id` INT NOT NULL, `name` TEXT, PRIMARY KEY(id))")

-- Inventory Exports
--------------------->>

function invSet(account, key, value)
	if (not account or not key) then return false end
	if (isGuestAccount(account) or type(key) ~= "string") then return false end
	local account = getAccountName(account)
	if (not inventory_online[account]) then	
		return false 
	end
	if (not inventory[account]) then
		inventory[account] = {}
		if (getServerPort() == SERVER_PORT) then
			dbExec(db, "INSERT INTO inventory(name) VALUES(?)", account)
		end
	end
	if (inventory["Console"] and inventory["Console"][key] == nil) then
		inventory["Console"][key] = true
		if (getServerPort() == SERVER_PORT) then
			dbExec(db, "ALTER TABLE inventory ADD `??` text", key)
		end
	end
	inventory[account][key] = value
	if (getServerPort() == SERVER_PORT) then
		if (value ~= nil) then
			dbExec(db, "UPDATE inventory SET `??`=? WHERE name=?", key, tostring(value), account)
		else
			dbExec(db, "UPDATE inventory SET `??`=NULL WHERE name=?", key, account)
		end
	end
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
