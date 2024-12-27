----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 24 Dec 2014
-- Resource: GTIhousing/manage.lua
-- Version: 1.0
----------------------------------------->>

-- Toggle Manage Function
-------------------------->>

addEventHandler("onClientGUIClick", housingGUI.scrollpane[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	if (source == housingGUI.button[6]) then
		triggerServerEvent("GTIhousing.toggleLockState", resourceRoot, getHouseID())
		guiSetEnabled(housingGUI.button[6], false)
		setTimer(guiSetEnabled, 1000, 1, housingGUI.button[6], true)
	return end
	
	if (source == housingGUI.button[7]) then
		guiSetText(transferGUI.button[1], "Transferir")
		guiBringToFront(transferGUI.window[1])
		guiSetVisible(transferGUI.window[1], true)
	return end
end)

-- Update Lock State
--------------------->>

addEvent("GTIhousing.updateLockState", true)
addEventHandler("GTIhousing.updateLockState", root, function(locked)
	if (locked) then
		guiSetText(housingGUI.button[6], "Desbloquear Casa")
		guiSetText(housingGUI.label[20], "Esta casa esa bloqueada. Desbloquear?")
	else
		guiSetText(housingGUI.button[6], "Bloquear Casa")
		guiSetText(housingGUI.label[20], "Esta casa esa desbloqueada. Bloquear?")
	end
end)

-- Storage Warning
------------------->>

function showStorageWarning2()
	guiBringToFront(storwarn2GUI.window[1])
	guiSetVisible(storwarn2GUI.window[1], true)
end

addEventHandler("onClientGUIClick", storwarn2GUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	openTransferHousePanel("left", "up", true)
end, false)

addEventHandler("onClientGUIClick", storwarn2GUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(storwarn2GUI.window[1], false)
end, false)
