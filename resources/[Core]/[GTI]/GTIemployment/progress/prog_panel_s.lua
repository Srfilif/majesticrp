----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 19 Dec 2013
-- Resource: GTIemployment/panel.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Call Panel Info
------------------->>

function callPanelInfo()
	local ranks = {}
	ranks["job"] = getPlayerJob(client)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not Ranks[ranks["job"]]) then return end
	-- Current Job
	ranks["level"] 		= getPlayerJobLevel(client, ranks["job"])
	ranks["rank"] 		= getJobRankFromLevel(ranks["job"], ranks["level"])
	ranks["prog"] 		= getPlayerJobProgress(client, ranks["job"])
	ranks["req"] 		= getJobLevelRequirement(ranks["job"], ranks["level"]+1)
	ranks["unit"] 		= getJobUnitName(ranks["job"])
	ranks["jobexp"] 	= getPlayerEmploymentExp(client, ranks["job"])
	ranks["money"] 		= getPlayerJobMoney(client, ranks["job"]) 
	ranks["desc"] 		= getJobDataTable(ranks["job"]).desc
	ranks["ranks"] 		= getJobRanks(ranks["job"])
	ranks["duty"]		= getAccountData(getPlayerAccount(client), "isWorking")
	ranks["balance"]	= getPlayerOutstandingPay(client)
	ranks["expbalance"] = getPlayerOutstandingExp(client)
	ranks["hours"]		= getPlayerJobTime(client, ranks["job"])
	-- All Jobs
	ranks["civlvl"] 	= getPlayerEmploymentLevel(client)
	ranks["civexp"] 	= getPlayerEmploymentExp(client)
	ranks["lvlxpcur"] 	= getEmploymentLevelRequirement(ranks["civlvl"])
	ranks["lvlxpnxt"] 	= getEmploymentLevelRequirement(ranks["civlvl"]+1)
	ranks["jobList"] = {}
	for job,_ in pairs(Ranks) do
		table.insert(ranks["jobList"],job)
	end
	
	local JobInfo = exports.GTIemployTable:getJobsTable()
	local divisions = JobInfo[ranks["job"]].divisions
	
	triggerClientEvent(client, "GTIemployment.showPanel", client, ranks, {255, 200, 0}, divisions)
end
addEvent("GTIemployment.callPanelInfo", true)
addEventHandler("GTIemployment.callPanelInfo", root, callPanelInfo)

-- Return all Job Info
----------------------->>

function callAllJobInfo(job)
	local ranks = {}
	ranks["job"] 	= job
	ranks["level"] 	= getPlayerJobLevel(client, ranks["job"])
	ranks["rank"] 	= getJobRankFromLevel(ranks["job"], ranks["level"])
	ranks["prog"] 	= getPlayerJobProgress(client, ranks["job"])
	ranks["req"] 	= getJobLevelRequirement(ranks["job"], ranks["level"]+1)
	ranks["unit"] 	= getJobUnitName(ranks["job"])
	ranks["desc"] 	= getJobDataTable(ranks["job"]).desc
	ranks["ranks"]	= getJobRanks(ranks["job"])
	
	triggerClientEvent(client, "GTIemployment.returnAllJobInfo", client, ranks)
end
addEvent("GTIemployment.callAllJobInfo", true)
addEventHandler("GTIemployment.callAllJobInfo", root, callAllJobInfo)
