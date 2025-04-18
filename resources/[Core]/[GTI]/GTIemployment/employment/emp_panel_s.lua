----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 03 Dec 2013
-- Resource: GTIemployment/emp_panel.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local markerJob = {}			-- Job Name by Marker

DEFUALT_BLIP_ID = 56			-- Job Blip ID
BLIP_VISIBLE_DISTANCE = 450		-- Blip Visible Distance

-- Create Job Locations
------------------------>>

function createJobLocations(resource)
	if (resource ~= getThisResource() and resource ~= getResourceFromName("GTIemployTable")) then return end
		-- Destroy Old
	for i,v in ipairs(getElementsByType("marker", resourceRoot)) do
		destroyElement(v)
	end
	markerJob = {}
	for i,v in ipairs(getElementsByType("blip", resourceRoot)) do
		destroyElement(v)
	end
		
		-- And Create New
	local JobLoc = exports.GTIemployTable:getJobsTable("locations")
	for i,job in ipairs(JobLoc) do
		marker = createMarker(job.mLoc[1], job.mLoc[2], job.mLoc[3], "cylinder", 1.5, job.mCol[1], job.mCol[2], job.mCol[3], 150)
		markerJob[marker] = job.job
		setElementInterior(marker, job.mLoc[4] or 0)
		setElementDimension(marker, job.mLoc[5] or 0)
		--exports.MitchMisc:create3DText  ( job.job, { job.mLoc[1], job.mLoc[2], job.mLoc[3]+1 }, { job.mCol[1], job.mCol[2], job.mCol[3] }, { nil, true } )
		addEventHandler("onMarkerHit", marker, sendGUIJobData)
		addEventHandler("onMarkerLeave", marker, closeGUI)
		
		if (job.blipLoc) then
			local blip = createBlip(job.blipLoc[1], job.blipLoc[2], 0, (job.blipID or DEFUALT_BLIP_ID), 2, 255, 255, 255, 255, 0, BLIP_VISIBLE_DISTANCE)
			setElementInterior(blip, job.blipLoc[3] or 0)
			setElementDimension(blip, job.blipLoc[4] or 0)
		else
			createBlipAttachedTo(marker, (job.blipID or DEFUALT_BLIP_ID), 2, 255, 255, 255, 255, 0, BLIP_VISIBLE_DISTANCE)
		end
	end
end
addEventHandler("onResourceStart", root, createJobLocations)

-- Send Job Data
----------------->>

function sendGUIJobData(player, dim)
	if (getElementType(player) ~= "player" or not dim) then return end
	if (isPedInVehicle(player) or not isPedOnGround(player)) then return end
	
	local job = markerJob[source]
	local JobInfo = exports.GTIemployTable:getJobsTable()
	
	local rank_data = {}
	rank_data["ranks"] = getJobRanks(job)
	rank_data["level"] = getPlayerJobLevel(player, job)
	rank = getJobRankFromLevel(job, rank_data["level"])
	triggerClientEvent(player, "GTIemployment.sendGUIJobData", player, job, rank, JobInfo[job], rank_data)
end

function closeGUI(player,dim)
	if (getElementType(player) ~= "player" or not dim) then return end
	
	triggerClientEvent(player, "GTIemployment.closeJobsPanel", player, "left", "up", true)
end

-- Update Job Division
----------------------->>

function updateJobDivision(division)
	setPlayerJobDivision(client, division)
	
	local job = getElementData(client, "job")
	local r,g,b = getTeamColor(getPlayerTeam(client))
	exports.GTIhud:dm(job..": You have switched to the "..division.." division", client, r, g, b)
end
addEvent("GTIemployment.updateJobDivision", true)
addEventHandler("GTIemployment.updateJobDivision", root, updateJobDivision)

-- Update Uniform
------------------>>

function updateUniform(skinID)
	setPlayerJobUniform(client, skinID)
	
	local job = getElementData(client, "job")
	local r,g,b = getTeamColor(getPlayerTeam(client))
	exports.GTIhud:dm(job..": Uniform successfully changed!", client, r, g, b)
end
addEvent("GTIemployment.updateUniform", true)
addEventHandler("GTIemployment.updateUniform", root, updateUniform)

-- Set Player Job
------------------>>

function setPlayerJobFromPanel(job, division, skinID, no_event)
	local JobInfo = exports.GTIemployTable:getJobsTable()
	local jobData = JobInfo[job]
	local team = jobData.team or "Civiles"
	setPlayerJob(client, job, team, division, skinID, no_event)
	triggerClientEvent(client, "GTIemployment.closeJobsPanel", client, "left", "up", true)
end
addEvent("GTIemployment.setPlayerJob", true)
addEventHandler("GTIemployment.setPlayerJob", root, setPlayerJobFromPanel)

function toggleShiftFromPanel()
	local shift = togglePlayerShift(client)
	if (not shift) then
		triggerClientEvent(client, "GTIemployment.modShiftText", resourceRoot, "Start Shift")
	else
		triggerClientEvent(client, "GTIemployment.modShiftText", resourceRoot, "End Shift")
	end
end
addEvent("GTIemployment.togglePlayerShift", true)
addEventHandler("GTIemployment.togglePlayerShift", root, toggleShiftFromPanel)

function resignFromPanel()
	resign(client)
	triggerClientEvent(client, "GTIemployment.closeJobsPanel", resourceRoot, "left", "up", true)
	triggerClientEvent(client, "GTIemployment.closeProgressPanel", resourceRoot)
end
addEvent("GTIemployment.resign", true)
addEventHandler("GTIemployment.resign", root, resignFromPanel)