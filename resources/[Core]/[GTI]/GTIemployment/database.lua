----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 19 Dec 2013
-- Resource: GTIemployment/database.slua
-- Version: 2.5
----------------------------------------->>

local ipairs = ipairs
local type = type
local tonumber = tonumber

local db = dbConnect("sqlite", "database/job_progress.db")
dbExec(db, "CREATE TABLE IF NOT EXISTS `employment`(`id` INT NOT NULL, `name` TEXT, PRIMARY KEY(id))")

local jobdata = {}		-- 'employment' Database Cache

local SERVER_PORT = 22013

addEvent("onDatabaseLoad", true)	-- Triggers when the database is ready

-- Database Cache
------------------>>

addEventHandler("onResourceStart", resourceRoot, function()
	dbQuery(cacheJobDatabase, {}, db, "SELECT * FROM `employment`")
end)

function cacheJobDatabase(qh)
	local result = dbPoll(qh, 0)
	jobdata["Console"] = {}
	for i,row in ipairs(result) do
		jobdata[row.name] = {}
		for column,value in pairs(row) do
			if (column ~= "id" or column ~= "name") then
				jobdata["Console"][column] = true
				if (value == "true") then value = true end
				if (value == "false") then value = false end
				jobdata[row.name][column] = value
			end
		end
	end
	database1_online = true
	triggerEvent("onDatabaseLoad", resourceRoot, "employment")
end

-- Database Exports
-------------------->>

function SJD(account, key, value)
	if (not account or not key) then return false end
	if (isGuestAccount(account) or type(key) ~= "string") then return false end
	
	local account = getAccountName(account)
	if (type(jobdata[account]) ~= "table") then
		jobdata[account] = {}
		if (getServerPort() == SERVER_PORT) then
			dbExec(db, "INSERT INTO `employment`(id, name) VALUES(?,?)", math.random(0, 99999), account)
		end
	end
	
	if (jobdata["Console"][key] == nil) then
		if (getServerPort() == SERVER_PORT) then
			dbExec(db, "ALTER TABLE `employment` ADD `??` text", key)
		end
		jobdata["Console"][key] = true
	end
	
	jobdata[account][key] = value
	if (getServerPort() == SERVER_PORT) then
		if (value ~= nil) then
			dbExec(db, "UPDATE `employment` SET `??`=? WHERE name=?", key, tostring(value), account)
		else
			dbExec(db, "UPDATE `employment` SET `??`=NULL WHERE name=?", key, account)
		end
	end
	return true
end

function GJD(account, key)
	if (not account or not key) then return nil end
	if (isGuestAccount(account) or type(key) ~= "string") then return nil end
	
	local account = getAccountName(account)
	if (jobdata[account] == nil) then return nil end
	if (jobdata[account][key] == nil) then return nil end
	
	return tonumber(jobdata[account][key]) or jobdata[account][key]
end

addEvent("onAccountDelete")
addEventHandler("onAccountDelete", root, function(account)
	dbExec(db, "DELETE FROM `employment` WHERE name=?", account)
	jobdata[account] = nil
end)