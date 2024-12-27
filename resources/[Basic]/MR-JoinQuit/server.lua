function JoinQuit(reason)
	for k, v in ipairs(getElementsByType("player")) do
		if eventName == "onPlayerJoin" then
			v:outputChat("#4F4545[INFO] #FFFFFF"..source:getName().." #1BC03AEntro al servidor!", 0, 0, 0, true)
		elseif eventName == "onPlayerQuit" then
			v:outputChat("#4F4545[INFO] #FFFFFF"..source:getName().." #C12E2ESalio del servidor! #FFFFFF("..reason..")", 0, 0, 0, true)
		end
	end
end
addEventHandler("onPlayerJoin", root, JoinQuit)
addEventHandler("onPlayerQuit", root, JoinQuit)