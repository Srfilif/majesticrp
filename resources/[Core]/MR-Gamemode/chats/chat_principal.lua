local antiSpam  = {} 

addEventHandler("onPlayerChat", root, function( message, _type )
	cancelEvent()
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
			source:outputChat("No puedes escribir, estás muteado.. ", 150, 0, 0)
			return
		end
		local tick = getTickCount()
		if (antiSpam[source] and antiSpam[source][1] and tick - antiSpam[source][1] < 2000) then
			source:outputChat("#ff3d3d* Espera 2 segundos para enviar un mensaje", 150, 0, 0,true)
			return
		end
		if _type == 0 then
			if message ~= "" and message ~= " " and message:len() >= 1 then
				if getElementData(source,"Muerto") == 1 then
                    outputChatBox("#ff3d3d* Tu personaje esta muerto o inconciente, no puedes hablar.",source,255,255,255,true)
                    return
                end
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local nick = _getPlayerNameR( source )
				local message2 = trunklateText( source, message )
				chatCol = ColShape.Sphere(x, y, z, 20)
				nearPlayers = chatCol:getElementsWithin("player") 
				--outputConsole("[Ingles] "..nick.." dice: "..message.."")
				outputDebugString("["..(source:getData("Roleplay:Idioma") or "Español").."] "..nick.." dice: "..message2.."", 0, 221, 250, 255)
				local preFind = message2:find("-")
				message3 = message2
				if preFind then
					local posFind = message2:find('-', preFind+1)
					if posFind ~= nil then 
						local color = string.format("#%.2X%.2X%.2X", 221, 250, 255)
						message3 = tostring(message2:sub(1,preFind).."#FF00D8"..message2:sub(preFind+1,posFind-1)..color..message2:sub(posFind,message2:len()))
					end
				end
				source:setData("TextInfo", {"dice: "..message3, 221, 250, 255})
				setTimer(function(p)
					if isElement(p) then
						p:setData("TextInfo", {"", 255, 0, 216})
					end
				end, 2000, 1, source)

				for _,v in ipairs(nearPlayers) do
					v:outputChat("["..(source:getData("Roleplay:Idioma") or "ESP").."] "..nick.." dice: #FFFFFF"..message3.."", 231, 217, 176, true)
				end
				if not source:isInVehicle() then 
					if not source:getData("NoDamageKill") == true then
						if exports["MR-LFacciones"]:getTaserCables(source) == false then
						end
					end
				end
				if (not antiSpam[source]) then
					antiSpam[source] = {}
				end
				antiSpam[source][1] = getTickCount()
				if isElement( chatCol ) then
					destroyElement( chatCol )
				end
			else
				source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
			end
		end
		if _type == 1 then
			if message ~= "" and message ~= " " and message:len() >= 1 then
				local pos = Vector3(source:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local nick = _getPlayerNameR( source )
				local message2 = trunklateText( source, message )
				chatCol = ColShape.Sphere(x, y, z, 20)
				nearPlayers = chatCol:getElementsWithin("player") 
				outputDebugString("* "..message2.." (("..nick.."))", 0, 249, 0, 255)
				for _,v in ipairs(nearPlayers) do
					v:outputChat("* "..message2.." (("..nick.."))", 249, 0, 255, true)
				end
				if (not antiSpam[source]) then
					antiSpam[source] = {}
				end
				antiSpam[source][1] = getTickCount()
				if isElement( chatCol ) then
					destroyElement( chatCol )
				end
			else
				source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
			end
		end
	end
end)

local antiSpamSusurro = {}

function chatSUSURRO( source, cmd, ... )
	if not source:getAccount():isGuest () then
		if (source:isMuted()) then
			return
		end
		local tick = getTickCount()
		if (antiSpamSusurro[source] and antiSpamSusurro[source][1] and tick - antiSpamSusurro[source][1] < 500) then
			--source:outputChat(" [ Argentina Roleplay ]: Espera 2 segundos para enviar un mensaje.. ", 150, 0, 0)
			return
		end
		local message = table.concat({...}, " ")
		if message ~= "" and message ~= " " and message:len() >= 3 then
			local pos = Vector3(source:getPosition())
			local x, y, z = pos.x, pos.y, pos.z
			local nick = _getPlayerNameR( source )
			local cuenta = source:getAccount():getName()
			local message2 = trunklateText( source, message )
			chatCol = ColShape.Sphere(x, y, z, 2)
			nearPlayers = chatCol:getElementsWithin("player") 
			outputDebugString(""..nick.." susurra: "..message2.."", 0, 165, 242, 255)
			for _,v in ipairs(nearPlayers) do
				v:outputChat(""..nick.." susurra: #FFFFFF"..message2.."", 165, 242, 255, true)
			end
			if (not antiSpamSusurro[source]) then
				antiSpamSusurro[source] = {}
			end
			antiSpamSusurro[source][1] = getTickCount()
			if isElement( chatCol ) then
				destroyElement( chatCol )
			end
		else
			source:outputChat("Debes escribir más de 1 carácteres.", 150, 0, 0)
		end
	end
end
addCommandHandler({"s", "susurro"}, chatSUSURRO)

function trunklateText(thePlayer, text, factor)
	local msg = (tostring(text):gsub("%u", string.lower))
	return (tostring(msg):gsub("^%l", string.upper))
end