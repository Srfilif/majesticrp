----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 25 Dec 2014
-- Resource: GTIhousing/storage.lua
-- Version: 1.0
----------------------------------------->>

local plrInvCache	-- Cache of Player Inventory
local houseInvCache	-- Cache of House Inventory

-- Render Inventory
-------------------->>

addEvent("GTIhousing.getHouseStorage", true)
addEventHandler("GTIhousing.getHouseStorage", root, function(plrInv, houseInv)
	-- Player Inventory
	guiGridListClear(housingGUI.gridlist[1])
	for i,v in ipairs(plrInv) do
		local row = guiGridListAddRow(housingGUI.gridlist[1])
		guiGridListSetItemText(housingGUI.gridlist[1], row, 1, getWeaponNameFromID(v[1]), false, false)
		guiGridListSetItemText(housingGUI.gridlist[1], row, 2, v[2], false, false)
	end
	plrInvCache = plrInv
	
	-- House Inventory
	guiGridListClear(housingGUI.gridlist[2])
	for i,v in ipairs(houseInv) do
		local row = guiGridListAddRow(housingGUI.gridlist[2])
		guiGridListSetItemText(housingGUI.gridlist[2], row, 1, getWeaponNameFromID(v[1]), false, false)
		guiGridListSetItemText(housingGUI.gridlist[2], row, 2, v[2], false, false)
	end
	houseInvCache = houseInv
end)

-- Transfer Between
-------------------->>

addEventHandler("onClientGUIClick", housingGUI.button[5], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(housingGUI.gridlist[1])
	if (not row or row == -1) then
		outputChatBox("Tienes que selecionar un objeto primero antes de guardarlo", 255, 125, 0)
		return
	end
	
	local toTransfer = plrInvCache[row+1][1]
	local amount = guiGridListGetItemText(housingGUI.gridlist[1], guiGridListGetSelectedItem(housingGUI.gridlist[1]), 2)
	triggerServerEvent("GTIhousing.transferToHouse", resourceRoot, getHouseID(), toTransfer, tonumber(amount))
	
	guiSetEnabled(housingGUI.button[5], false)
	setTimer(guiSetEnabled, 3000, 1, housingGUI.button[5], true)
end, false)

addEventHandler("onClientGUIClick", housingGUI.button[4], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(housingGUI.gridlist[2])
	if (not row or row == -1) then
		outputChatBox("Tienes que selecionar un objeto antes de retirarlo", 255, 125, 0)
		return
	end
	
	local toTransfer = houseInvCache[row+1][1]
	local amount = guiGridListGetItemText(housingGUI.gridlist[2], guiGridListGetSelectedItem(housingGUI.gridlist[2]), 2)
	triggerServerEvent("GTIhousing.transferToPlayer", resourceRoot, getHouseID(), toTransfer, tonumber(amount))
	
	guiSetEnabled(housingGUI.button[4], false)
	setTimer(guiSetEnabled, 3000, 1, housingGUI.button[4], true)
end, false)
