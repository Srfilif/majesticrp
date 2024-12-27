----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 24 Dec 2014
-- Resource: GTIhousing/manage.slua
-- Version: 1.0
----------------------------------------->>

-- Toggle Lock State
--------------------->>

addEvent("GTIhousing.toggleLockState", true)
addEventHandler("GTIhousing.toggleLockState", root, function(house)
	local locked = not isHouseLocked(house)
	setHouseLocked(house, locked)
	outputChatBox("Ahora "..(locked and "Bloqueaste" or "Desbloqueaste").." tu casa", client, 25, 255, 25)
	triggerClientEvent(client, "GTIhousing.updateLockState", resourceRoot, locked)
end)