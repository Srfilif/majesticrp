----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 03 Dec 2013
-- Resource: GTIemployment/employment.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

UNEMPLOYED_TEAM = "Civiles"	-- Unemployed Team
ODR, ODG, ODB = 255, 255, 255			-- Off-Duty Color
MIN_CRIM_DISTANCE = 150					-- Minimal criminal distance

addEvent("onPlayerGetJob", true)
addEvent("onPlayerQuitJob", true)
addEvent("onPlayerJobDivisionChange", true)

-- Job Functions
----------------->>

function getPlayerJob(player, isWorking, isValid)
	if (not isElement(player)) then return false end
	local job = getElementData(player, "job")
	if (job == "" or not job) then return false end

	local JobInfo = exports.GTIemployTable:getJobsTable()
	if (isValid and not JobInfo[job]) then return false end

	if (isWorking) then
		local working = getElementData(player, "isWorking")
		if (working == 1) then
			return job
		else
			return false
		end
	end

	return job
end

function getJobDataTable(job)
	local JobInfo = exports.GTIemployTable:getJobsTable()
	if (not JobInfo[job]) then return false end
	return JobInfo[job]
end

function setPlayerJob(player, job, team, division, skinID, no_event)
	if (not isElement(player)) then return end
	local account = getPlayerAccount(player)
	local oldJob = getElementData(player, "job") or false
	if (oldJob == "") then oldJob = false end

	if (skinID) then
		setElementModel(player, skinID)
		setAccountData(account, "jobskin", skinID)
	end

	if (job == division) then division = nil end
	exports.GTIhud:drawMissionText("job", job..(division and ", "..division or ""), player, r, g, b)
	playSoundFrontEnd(player, 11)

	setAccountData(account, "job", job)
	setElementData(player, "job", job)
	setAccountData(account, "isWorking", 1)
	setElementData(player, "isWorking", 1)
	local old_division = getPlayerJobDivision(player)
	setPlayerJobDivision(player, division or job)

	if (no_event) then return true end
	triggerEvent("onPlayerQuitJob", player, oldJob, true, old_division or false)
	triggerClientEvent(player, "onClientPlayerQuitJob", player, oldJob, true, old_division or false)
	triggerEvent("onPlayerGetJob", player, job, true, division or false)
	triggerClientEvent(player, "onClientPlayerGetJob", player, job, true, division or false)
	return true
end

-- Divisions
------------->>

function getPlayerJobDivision(player)
	if (not isElement(player)) then return false end
	local division = getElementData(player, "division")
	if (division == "" or not division) then return false end
	return division
end

function setPlayerJobDivision(player, division)
	triggerEvent("onPlayerJobDivisionChange", player, getPlayerJobDivision(player), division)
	triggerClientEvent(player, "onClientPlayerJobDivisionChange", player, getPlayerJobDivision(player), division)
	setElementData(player, "division", division)
	local account = getPlayerAccount(player)
	setAccountData(account, "division", division)
	return true
end

function isJobDivisionUnlocked(player, job, division)
	local JobInfo = exports.GTIemployTable:getJobsTable()
	if (JobInfo[job]) then return false end

	local level = getPlayerJobLevel(player, job)
	if (not level) then return false end

	if (JobInfo[job].divisions) then
		for i,div in ipairs(JobInfo[job].divisions) do
			if (division == div[1] and level < div[2]) then
				return false
			end
		end
	end
	return true
end

-- Uniform
----------->>

function setPlayerJobUniform(player, skinID)
	setElementModel(player, skinID)
	local account = getPlayerAccount(player)
	setAccountData(account, "jobskin", skinID)
	return true
end

-- End Shift and Resign
------------------------>>

function togglePlayerShift(player)
	if (not isElement(player)) then return false end
	
	if (getElementData(player, "repairing")) then	
		exports.GTIhud:dm("You cannot change your shift while repairing a vehicle.", player, 255, 125, 0)
		return
	end	
		-- Stop Police from Changing Shift
	if (exports.GTIutil:isPlayerInTeam(player, "Law Enforcement") and isPlayerNearCriminal(player)) then
		exports.GTIhud:dm("You cannot change your shift while near a criminal.", player, 255, 125, 0)
		return
	end
	
	if (exports.GTIemployment:getPlayerJob(player) == "Police Officer") then
		if ( getElementInterior(player) ~= 0 or getElementDimension(player) ~= 0 ) then
			exports.GTIhud:dm("You cannot change your shift while you are inside an interior.", player, 255, 125, 0)
		return end
	end
		
	local account = getPlayerAccount(player)
	local job = getPlayerJob(player)
	if (getPlayerJob(player, true)) then
			-- End Shift
		local skin = getAccountData(account, "skin")
		if (not skin) then
			repeat until setElementModel(player, math.random(312))
			setAccountData(account, "skin", getElementModel(player))
		else
			--setElementModel(player, skin)
		end
		exports.GTIhud:dm("Terminaste tu trabajo como "..job, player, 255, 255, 255)

		setAccountData(account, "isWorking", 0)
		setElementData(player, "isWorking", 0)
		local division = getPlayerJobDivision(player)

		triggerEvent("onPlayerQuitJob", player, job, false, division)
		triggerClientEvent(player, "onClientPlayerQuitJob", player, job, false, division)
		return false
	else
			-- Start Shift
		local skin = getAccountData(account, "jobskin")
		if (skin) then
			--setElementModel(player, skin)
		end
		exports.GTIhud:dm("Volviste a tu trabajo como "..job, player, 255, 255, 255)

		setAccountData(account, "isWorking", 1)
		setElementData(player, "isWorking", 1)
		local division = getPlayerJobDivision(player)

		triggerEvent("onPlayerGetJob", player, job, false, division)
		triggerClientEvent(player, "onClientPlayerGetJob", player, job, false, division)
		return true
	end
end

function resign(player, hideMessage, ignore_event)
	if (not isElement(player)) then return false end
	local account = getPlayerAccount(player)
	local job = getElementData(player, "job")
	local skin = getAccountData(account, "skin")

	if (getElementData(player, "repairing")) then	
		exports.GTIhud:dm("You cannot resign while repairing a vehicle.", player, 255, 125, 0)
		return false
	end
	
	if (not skin) then
		repeat until setElementModel(player, math.random(312))
		setAccountData(account, "skin", getElementModel(player))
	else
		--setElementModel(player, skin)
	end
	
	setAccountData(account, "job", "")
	setElementData(player, "job", "")
	setAccountData(account, "isWorking", 0)
	setElementData(player, "isWorking", 0)
	local division = getPlayerJobDivision(player)
	setPlayerJobDivision(player)

	if (not ignore_event) then
		triggerEvent("onPlayerQuitJob", player, job, true, division)
		triggerClientEvent(player, "onClientPlayerQuitJob", player, job, true, division)
	end
	return true
end

-- Save Job Data
----------------->>

function restoreJobData(_, account)
	if (isGuestAccount(account)) then return end
	local job = getAccountData(account, "job") or ""
	setElementData(source, "job", job)

	local isWorking = getAccountData(account, "isWorking") or 0
	setElementData(source, "isWorking", isWorking)

	local division = getAccountData(account, "division")
	setElementData(source, "division", division)

	if (isWorking == 1) then
		local jobskin = getAccountData(account, "jobskin")
		if (jobskin) then
			--setTimer(setElementModel, 500, 1, source, jobskin)
		end
		triggerEvent("onPlayerGetJob", source, job, true, division)
		triggerClientEvent(source, "onClientPlayerGetJob", source, job, true, division)
	else
		if (job ~= "") then
		end
	end
end
addEventHandler("onPlayerLogin", root, restoreJobData)

-- Utilities
------------->>

function isPlayerNearCriminal(player)
	local x1,y1,z1 = getElementPosition(player)
	for k,crim in ipairs(getElementsByType("player")) do
		local x2,y2,z2 = getElementPosition(crim)
		if (getDistanceBetweenPoints3D(x1,y1,z1, x2,y2,z2) <= MIN_CRIM_DISTANCE) then
			if (exports.GTIcriminals:isCriminal(crim)) then return true end
		end
	end
	return false
end

addEventHandler("onPlayerGetJob", root,
	function (job)
		setElementData(source, "_job", job)
	end
)

addEventHandler("onPlayerQuitJob", root,
	function (job)
		setElementData(source, "_job", "")
	end
)

addEventHandler("onResourceStart", resourceRoot,
	function ()
		for i,v in ipairs ( getElementsByType("player") ) do
			setElementData(v, "_job", getElementData(v, "job") )
		end
	end
)
