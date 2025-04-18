----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 19 Dec 2013
-- Resource: GTIemployment/progress.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local math = math
local type = type
local pairs = pairs

local MAX_EXPERIENCE = 15000000	-- Max Experience Earned (L50)
local MAX_EXP_HOURS = 1500		-- Max Experience Time (L50)
local MAX_LEVEL = 50			-- Max Level
local HOURLY_EXP = 10000		-- Experience per Hour

local MINIMUM_WAGE = 30000		-- Starting Hourly Wage
local MAXIMUM_WAGE = 180000		-- Maximum Wage (L50)
local MULTIPLR_WAGE = 40000		-- Hourly Wage for multiplayer job

local MAX_WAGE_SPLR = 1.5		-- Percent over the expected wage a plr can earn
local MAX_WAGE_MPLR = 2.5			-- Percent over multiplayer wage a plr can earn

local PAYOUT_TIME = 60*60000	-- Time Between Payouts

--local money = {}				-- Job Bank Cache
local money = {}				-- Money Anti-cheat
local moneyTimer
local expPoints = {}			-- Experience Points Anti-cheat
local expTimer					-- Experience AC Timer
local jobHours = {}				-- Job Hours Cache

local multiplr_jobs = {
	["Mechanic"] = true,
	["Paramedic"] = true,
	["Police Officer"] = true,
}

addEvent("onPlayerJobProgressModified", true)

-- Job Data Exports
-------------------->>

function getJobRanks(job)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not Ranks[job]) then return false end
	return Ranks[job]
end

function getJobRankFromLevel(job, level)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not Ranks[job] or not Ranks[job][level]) then return false end
	return Ranks[job][level].name or false
end

function getJobMaxLevel(job)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not Ranks[job]) then return end
	local level = -1
	for lvl,tbl in pairs(Ranks[job]) do
		level = level + 1
	end
	return level
end

function getJobLevelFromProgress(job, progress)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not Ranks[job] or type(progress) ~= "number") then return false end
	local level = -1
	for lvl,tbl in pairs(Ranks[job]) do
		if (progress >= tbl.progress) then
			level = level + 1
		end
	end
	return level or false
end

function getJobLevelRequirement(job, level)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not Ranks[job]) then return false end
	if (not Ranks[job][level]) then level = getJobMaxLevel(job) end
	return Ranks[job][level].progress or false
end

function getJobUnitName(job)
	local RankBase = exports.GTIemployTable:getRankBase()
	if (not RankBase[job]) then return false end
	return RankBase[job].uName or false
end

-- Player Data Exports
----------------------->>

function getPlayerJobLevel(player, job)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not isElement(player) or not Ranks[job]) then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local progress = getPlayerJobProgress(player, job) or 0
	return getJobLevelFromProgress(job, progress)
end

function getPlayerJobRank(player, job)
	local level = getPlayerJobLevel(player, job)
	return getJobRankFromLevel(job, level)
end

function getPlayerJobProgress(player, job)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not isElement(player) or not Ranks[job]) then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local progress = GJD(account, "prog_"..string.lower(string.gsub(job," ",""))) or 0
	return progress
end

function getPlayerJobMoney(player, job)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not isElement(player) or not Ranks[job]) then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local cash = GJD(account, "money_"..string.lower(string.gsub(job," ",""))) or 0
	return cash
end

function modifyPlayerJobProgress(player, job, progress)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not isElement(player) or not Ranks[job] or type(progress) ~= "number") then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	if (isExperienceAntiCheatEnabled(player)) then return false end
	
	local curProg = GJD(account, "prog_"..string.lower(string.gsub(job," ",""))) or 0
	SJD(account, "prog_"..string.lower(string.gsub(job," ","")), curProg+progress)
	local unit = getJobUnitName(job)
	exports.GTIhud:drawNote("Prog"..math.random(1,1000), "+ "..exports.GTIutil:tocomma(progress).." "..unit, player, 255, 200, 0, 7500)
	
	--exports.GTIlogs:outputServerLog("CIV PROGRESS: "..getPlayerName(player).." + "..progress.." "..job.." progress earned", "civilians", player)
	
	triggerEvent("onPlayerJobProgressModified", player, job, progress)
	return true
end

-- Job Money
------------->>

function givePlayerJobMoney(player, job, amount)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not isElement(player) or not Ranks[job] or type(amount) ~= "number") then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local old_amount = amount
		-- Group Bonus
	local bonus
	--if (exports.GTIgroups:isPlayerInGroup(player)) then bonus = true end
	
	local amount = not bonus and amount or math.floor(amount * 1.1)
	
	
	local serial = getPlayerSerial(player)
	if (not money[getPlayerSerial(player)]) then money[getPlayerSerial(player)] = 0 end
	money[serial] = money[serial] + amount

	if (isMoneyAntiCheatEnabled(player)) then 
		outputChatBox("Anti-Cheat Triggered: You've gained a lot of money in this hour.", player, 255, 0, 0)
		local timeLeft = getTimerDetails(moneyTimer)
		local M = math.floor(timeLeft/60000)
		outputChatBox("You will not gain any more cash for the next "..M.." minutes.", player, 255, 0, 0)
		--exports.GTIgovt:outputAdminNotice("* (Security) "..getPlayerName(player).." triggered experience anti-cheat for "..job.." job")
		exports.GTIlogs:outputWebLog("[Security] "..getPlayerName(player).." triggered money anti-cheat for "..job.." job")
		return false 
	end
	
	local cash = GJD(account, "money_"..string.lower(string.gsub(job," ",""))) or 0
	SJD(account, "money_"..string.lower(string.gsub(job," ","")), cash+amount)
	
	givePlayerMoney(player, amount)
	
	exports.GTIhud:drawNote("Money"..math.random(1,1000), "+ $"..exports.GTIutil:tocomma(amount), player, 25, 255, 25, 7500)
	return true
end

function getPlayerOutstandingPay(player)
	if (not isElement(player)) then return false end
	--[[if (not money[player]) then return 0 end
	return money[player][2] or 0]]
	local serial = getPlayerSerial(player)
	return money[serial] or 0
end

	--[[ Auto-pay Wage Every Hour
setTimer(function()
	local mins = getRealTime().minute
	if (mins ~= 0) then return end
	for player,v in pairs(money) do
		_money = processWage(player, v[2]) or 0
		exports.GTIbank:modifyPlayerBankBalance(player, _money, v[1]..": Job Payment", true)
		exports.GTIhud:dm("EMPLOYMENT: Your "..v[1].." wage of $"..exports.GTIutil:tocomma(_money).." has been transferred to your bank account", player, 25, 255, 25)
	end
	money = {}
end, 60000, 0) ]]

	--[[ Auto-pay on resource stop
addEventHandler("onResourceStop", resourceRoot, function()
	for player,v in pairs(money) do
		_money = processWage(player, v[2])
		exports.GTIbank:modifyPlayerBankBalance(player, _money, v[1]..": Job Payment", true)
		exports.GTIhud:dm("EMPLOYMENT: Your "..v[1].." wage of $"..exports.GTIutil:tocomma(_money).." has been transferred to your bank account", player, 25, 255, 25)
	end
end)

	-- Auto-pay on resign
addEvent("onPlayerQuitJob", true)
addEventHandler("onPlayerQuitJob", root, function(old_job, resign)
	if (not resign or not money[source]) then return end
	local v = money[source]
	_money = processWage(source, v[2], old_job)
	exports.GTIbank:modifyPlayerBankBalance(source, _money, v[1]..": Job Payment", true)
	exports.GTIhud:dm("EMPLOYMENT: Your "..v[1].." wage of $"..exports.GTIutil:tocomma(_money).." has been transferred to your bank account", source, 25, 255, 25)
	money[source] = nil
end)

	-- Auto-pay on quit
addEventHandler("onPlayerQuit", root, function()
	if (not money[source]) then return end
	local v = money[source]
	_money = processWage(source, v[2])
	exports.GTIbank:modifyPlayerBankBalance(source, _money, v[1]..": Job Payment", true)
	exports.GTIhud:dm("EMPLOYMENT: Your "..v[1].." wage of $"..exports.GTIutil:tocomma(_money).." has been transferred to your bank account", source, 25, 255, 25)
	money[source] = nil
end) ]]

-- On Duty Hours
----------------->>

function getPlayerJobTime(player, job)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not isElement(player) or not Ranks[job]) then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	return GJD(account, "time_"..string.lower(string.gsub(job," ",""))) or 0
end

function modifyPlayerJobTime(player, job, seconds)
	local Ranks = exports.GTIemployTable:getRanks()
	if (not isElement(player) or not Ranks[job] or type(seconds) ~= "number") then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local secs = GJD(account, "time_"..string.lower(string.gsub(job," ",""))) or 0
	SJD(account, "time_"..string.lower(string.gsub(job," ","")), secs+seconds)
	return true
end

	-- Set Job Time
addEvent("onPlayerGetJob", true)
addEventHandler("onPlayerGetJob", root, function(job)
		-- Store Tick
	jobHours[source] = getTickCount()
		-- Set First Time Data if not exists
	if ((getPlayerJobTime(source, job) or 0) > 0) then return end
	local progress = getPlayerJobProgress(source, job)
	local RankBase = exports.GTIemployTable:getRankBase()
	if (not RankBase[job]) then return end
	local hourly_prog = RankBase[job].hProg
	if (job == "Police Officer") then
		hourly_prog = 17
	end
	local hours = math.floor((progress/hourly_prog)*3600)
	modifyPlayerJobTime(source, job, hours)
end)

	-- Store Hours Every 15 minutes
setTimer(function()
	for player,tick in pairs(jobHours) do
		local tick = (getTickCount() - tick)/1000
		local job = getPlayerJob(player, true)
		modifyPlayerJobTime(player, job, math.floor(tick))
		jobHours[player] = getTickCount()
	end
end, 60000*5, 0)

addEvent("onDatabaseLoad", true)
addEventHandler("onDatabaseLoad", root, function(database)
	if (database ~= employment) then return end
	for i,player in ipairs(getElementsByType("player")) do
		local job = getPlayerJob(player, true, true)
		if (job) then
				-- Store Tick
			jobHours[player] = getTickCount()
				-- Set First Time Data if not exists
			if ((getPlayerJobTime(player, job) or 0) > 0) then return end
			local progress = getPlayerJobProgress(player, job)
			local RankBase = exports.GTIemployTable:getRankBase()
			if (not RankBase[job]) then return end
			local hourly_prog = RankBase[job].hProg
			if (job == "Police Officer") then
				hourly_prog = 17
			end
			local hours = math.floor((progress/hourly_prog)*3600)
			modifyPlayerJobTime(player, job, hours)
		end
	end
end)

	-- Auto-set on resource stop
addEventHandler("onResourceStop", resourceRoot, function()
	for player,tick in pairs(jobHours) do
		local tick = (getTickCount() - tick)/1000
		local job = getPlayerJob(player, true)
		modifyPlayerJobTime(player, job, math.floor(tick))
	end
end)

	-- Auto-set on resign
addEvent("onPlayerQuitJob", true)
addEventHandler("onPlayerQuitJob", root, function(old_job)
	local tick = jobHours[source]
	if (not tick) then return end
	local tick = (getTickCount() - tick)/1000
	modifyPlayerJobTime(source, old_job, math.floor(tick))
	jobHours[source] = nil
end)

	-- Auto-set on quit
addEventHandler("onPlayerQuit", root, function()
	local tick = jobHours[source]
	if (not tick) then return end
	local tick = (getTickCount() - tick)/1000
	modifyPlayerJobTime(source, old_job, math.floor(tick))
	jobHours[source] = nil
end)

-- Experience System Exports
----------------------------->>

function getEmploymentLevelFromExp(exper)
	if (type(exper) ~= "number") then return false end
	
	for lvl=0,MAX_LEVEL do
		local expPoints = -math.sqrt(MAX_LEVEL^2-lvl^2)*(MAX_EXP_HOURS/MAX_LEVEL) + MAX_EXP_HOURS
		expPoints = expPoints/MAX_EXP_HOURS
		expPoints = expPoints*MAX_EXPERIENCE
		if (expPoints > exper) then
			return lvl-1
		end
	end
		return 50
end

function getEmploymentLevelRequirement(level)
	if (type(level) ~= "number") then return false end
	if (level > 50) then level = 50 end
	if (level == 0) then return 0 end
	
	local expPoints = -math.sqrt(MAX_LEVEL^2-level^2)*(MAX_EXP_HOURS/MAX_LEVEL) + MAX_EXP_HOURS
	expPoints = expPoints/MAX_EXP_HOURS
	expPoints = expPoints*MAX_EXPERIENCE
	return math.floor(expPoints)
end

function getHourlyExperience()
	return HOURLY_EXP
end

function getPlayerJobPayment(player, job)
	RankBase = exports.GTIemployTable:getRankBase()
	if (not isElement(player) or not RankBase[job]) then return false end
	local RankBase = exports.GTIemployTable:getRankBase()
	local levelPay = getPlayerHourlyPay(player)
	
	local hourlyPay = RankBase[job].basePay
	local payOffset = levelPay/MINIMUM_WAGE
	return hourlyPay*payOffset
end

function getPlayerHourlyPay(player)
	if (not isElement(player)) then return false end
	local level = getPlayerEmploymentLevel(player)
		-- Hourly Pay Formula
	local pay = -math.sqrt(MAX_LEVEL^2 - level^2) * ((MAXIMUM_WAGE-MINIMUM_WAGE)/1000)/MAX_LEVEL + MAXIMUM_WAGE/1000
	pay = math.floor(pay * 1000)
	
	return pay
end

function getPlayerEmploymentLevel(player)
	if (not isElement(player)) then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local experience = GJD(account, "experience") or 0
	return getEmploymentLevelFromExp(experience)
end

function getPlayerEmploymentExp(player, job)
	if (not isElement(player)) then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local Ranks = exports.GTIemployTable:getRanks()
	if (Ranks[job]) then
		local civExp = GJD(account, "exp_"..string.lower(string.gsub(job," ",""))) or 0
		return civExp
	end
	local civExp = GJD(account, "experience") or 0
	return civExp
end

function modifyPlayerEmploymentExp(player, experience, job)
	if (not isElement(player) or type(experience) ~= "number") then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
		-- Anti-Cheat
	local serial = getPlayerSerial(player)
	if (not expPoints[serial]) then expPoints[serial] = 0 end
	expPoints[serial] = expPoints[serial] + experience
	if (isExperienceAntiCheatEnabled(player)) then 
		outputChatBox("Anti-Cheat Triggered: You've gained a lot of experience points in this hour.", player, 255, 0, 0)
		local timeLeft = getTimerDetails(expTimer)
		local M = math.floor(timeLeft/60000)
		outputChatBox("You will not gain any more experience points or job progress for the next "..M.." minutes.", player, 255, 0, 0)
		
		--exports.GTIgovt:outputAdminNotice("* (Security) "..getPlayerName(player).." triggered experience anti-cheat for "..job.." job")
		exports.GTIlogs:outputWebLog("[Security] "..getPlayerName(player).." triggered experience anti-cheat for "..job.." job")
		return false 
	end
	
	local Ranks = exports.GTIemployTable:getRanks()
	if (Ranks[job]) then
		local civExp = GJD(account, "exp_"..string.lower(string.gsub(job," ",""))) or 0
		SJD(account, "exp_"..string.lower(string.gsub(job," ","")), civExp+experience)
	end
		-- Group Experience
	--if (exports.GTIgroups:isPlayerInGroup(player)) then
		--local groupID = exports.GTIgroups:getPlayerGroup(player)
		--exports.GTIgroups:modifyGroupExperience(groupID, experience)
	--end
	
	local civExp = GJD(account, "experience") or 0
	SJD(account, "experience", civExp+experience)
	exports.GTIhud:drawNote("EmExp"..math.random(1,1000), "+ "..exports.GTIutil:tocomma(experience).." Employment XP", player, 255, 200, 0, 7500)
	
	--exports.GTIlogs:outputServerLog("CIV EXP: "..getPlayerName(player).." + "..experience.." "..job.." experience earned", "civilians", player)
	return true
end

-- AntiCheat Functions
----------------------->>

function isExperienceAntiCheatEnabled(player)
	if (not isElement(player)) then return false end
	if (multiplr_jobs[getPlayerJob(player)]) then return false end
	if ((expPoints[getPlayerSerial(player)] or 0) > HOURLY_EXP * MAX_WAGE_SPLR) then
		return true
	end
	return false
end

function isMoneyAntiCheatEnabled(player)
	if (not isElement(player)) then return false end
	if (multiplr_jobs[getPlayerJob(player)]) then return false end
	if (money[getPlayerSerial(player)] > getPlayerExpectedWage(player) * MAX_WAGE_SPLR) then
		return true
	end
	return false
end

function getPlayerExpectedWage(player)
	local pay = getPlayerHourlyPay(player)
	local old_pay = pay
	local bonus
	--if (exports.GTIgroups:isPlayerInGroup(player)) then bonus = true end

	local pay = not bonus and pay or math.floor(pay * 1.1)
	return pay
end
	
	
expTimer = setTimer(function()
	for serial,_ in pairs(expPoints) do
		expPoints[serial] = 0
	end
end, 60000*60, 0)

moneyTimer = setTimer(function()
	for serial, _ in pairs(money) do
		money[serial] = 0
	end
end, 60000*60, 0)

function getPlayerOutstandingExp (player)
	local serial = getPlayerSerial(player)
	return expPoints[serial] or 0
end

--[[function processWage(player, amount, job)
	if (not isElement(player) or not amount) then return end
	local org_amt, max_wage = amount, nil
	if (not job) then job = getPlayerJob(player) end
	if (not multiplr_jobs[job]) then
		max_wage = getPlayerExpectedWage(player) * MAX_WAGE_SPLR
	else
		max_wage = MULTIPLR_WAGE * MAX_WAGE_MPLR
	end	
	if (amount > max_wage) then 
		exports.GTIlogs:outputWebLog("[Security] "..getPlayerName(player).." triggered money anti-cheat for "..job.." job (Earned $"..amount..", Max Wage: $"..max_wage..")")
		amount = max_wage 
	end
	return amount, org_amt - amount
end
]]	