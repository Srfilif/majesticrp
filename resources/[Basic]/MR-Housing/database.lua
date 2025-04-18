----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 07 Nov 2014
-- Resource: GTIhousing/database.slua
-- Version: 1.0
----------------------------------------->>

local SERVER_PORT = 22013

local ipairs = ipairs
local type = type
local tonumber = tonumber

-- Database Start
------------------>>

local db = dbConnect("sqlite", "database/houses.db")
dbExec(db, "CREATE TABLE IF NOT EXISTS housing(id INT NOT NULL, PRIMARY KEY(id))")

local database1_online	-- Is 'housing' Database Online?

local housing = {}		-- 'housing' Database Cache
local houseOwners = {}	-- Table of House IDs by Owner
local maxHouseID = 0	-- Highest Available Housing ID
local DEFAULT_DELETE = 2592000 -- 30 days

addEvent("onDatabaseLoad", true)	-- Triggers when the database is ready

-- Database Cache
------------------>>

addEventHandler("onResourceStart", resourceRoot, function()
	dbQuery(function(qh)
		local result = dbPoll(qh, 0)
		housing[0] = {}
		for i,row in ipairs(result) do
			housing[row.id] = {}
			for column,value in pairs(row) do
				if (column ~= "id") then
					housing[0][column] = true
					if (value == "true") then value = true end
					if (value == "false") then value = false end
					housing[row.id][column] = value
					
					if (maxHouseID < row.id) then
						maxHouseID = row.id
					end
				end
			end
				-- Add House Owners
			addOwnerCache(row.owner, row.id)
		end
		triggerEvent("onDatabaseLoad", resourceRoot, "housing")
		loadHouses(housing)
	end, db, "SELECT * FROM `housing`")
end)

-- Database Exports
-------------------->>

function setHouseData(id, key, value)
	if (not id or not key) then return false end
	if (type(id) ~= "number" or type(key) ~= "string") then return false end
	if (type(housing[id]) ~= "table") then
		housing[id] = {}
		if (getServerPort() == SERVER_PORT) then
			dbExec(db, "INSERT INTO housing(id) VALUES(?)", id)
		end
	end
	
	if (housing[0][key] == nil) then
		if (getServerPort() == SERVER_PORT) then
			dbExec(db, "ALTER TABLE housing ADD `??` text", key)
		end
		housing[0][key] = true
	end
	
	housing[id][key] = value
	if (value ~= nil) then
		if (getServerPort() == SERVER_PORT) then
			dbExec(db, "UPDATE housing SET `??`=? WHERE id=?", key, tostring(value), id)
		end
	else
		if (getServerPort() == SERVER_PORT) then
			dbExec(db, "UPDATE housing SET `??`=NULL WHERE id=?", key, id)
		end
	end
	if (maxHouseID < id) then maxHouseID = id end
	return true
end

function removeHouseData(id)
	if (not id or type(id) ~= "number") then return false end
		-- Remove from Owner Cache
	local owner = getHouseData(id, "owner")
	removeOwnerCache(owner, id)
	
	housing[id] = nil
	dbExec(db, "DELETE FROM housing WHERE `id`=?", id)
	return true
end

function getHouseData(id, key)
	if (not id or not key) then return nil end
	if (type(id) ~= "number" or type(key) ~= "string") then return nil end
	
	if (housing[id] == nil) then return nil end
	if (housing[id][key] == nil or housing[id][key] == "nil") then return nil end
	
	return tonumber(housing[id][key]) or housing[id][key]
end

function getNextAvailibleID()
	return maxHouseID+1
end

-- Owner Cache
--------------->>

function addOwnerCache(owner, id)
	if (not houseOwners[owner]) then houseOwners[owner] = {} end
	for i,v in ipairs(houseOwners[owner]) do
		if (v == id) then return true end
	end
	table.insert(houseOwners[owner], id)
	return true
end

function removeOwnerCache(owner, id)
	if (not houseOwners[owner]) then return end
	for i,v in ipairs(houseOwners[owner]) do
		if (v == id) then
			table.remove(houseOwners[owner], i)
			return true
		end
	end
	return false
end

function getPlayerTotalHouses(player)
	if (not isElement(player)) then return end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return end
	local account = getAccountName(account)
	return houseOwners[account] or {}
end

function getAccountTotalHouses(account)
	if (not account or isGuestAccount(account)) then return end
	local account = getAccountName(account)
	return houseOwners[account] or {}
end