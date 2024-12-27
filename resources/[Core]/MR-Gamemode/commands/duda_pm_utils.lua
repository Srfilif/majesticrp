------------------------------------------------- Pagar dinero
local antiSpamBug  = {} 
function bug_comando ( source )

	if not notIsGuest( source ) then

		local tick = getTickCount()

		if (antiSpamBug[source] and antiSpamBug[source][1] and tick - antiSpamBug[source][1] < 60000) then

			source:outputChat("No puedes usar este comando después de 60 segundos", 150, 0, 0)

			return

		end

		local posicion = Vector3(source:getPosition())

		local x, y, z = posicion.x, posicion.y, posicion.z

		source:setInterior(0)

		source:setDimension(0)

		source:setPosition(x, y, z+2)

		source:setAnimation()
	   source:outputChat("#ff3d3d[UN-STUCK] #ffFFffTe has desbugeado correctamente,Si sigues bugeado llama a un staff con /re", 150, 0, 0,true)


		if (not antiSpamBug[source]) then

			antiSpamBug[source] = {}

		end

		antiSpamBug[source][1] = getTickCount()

	end

end

addCommandHandler({"bug", "bugeado"}, bug_comando)
function enviarDinero(player, commandName, player2, monto)
	local destinatario = getPlayerFromPartialName(player2)
	if not destinatario then
		outputChatBox("* Este jugando no existe", player, 255, 200, 0, true)
		return
	end
	if destinatario then
	--	if tonumber(monto) == "" or monto == nil or string.find(monto, "-") or string.find(monto, ".") or string.find(",") then
		--	outputChatBox("* Introduce la cantidad de dinero que deseas enviar o Introduce valores positivos", player, 255, 200, 0, true)
		--	return
		--end
		if getPlayerMoney(player) < tonumber(monto) then
			outputChatBox("* No tienes la cantidad de dinero que deseas enviar", player, 255, 255, 0, true)
			print("".._getPlayerNameR(player).." Intento mandar dinero sin tenerlo en mano, caso sospechoso!")
			return
		end
		outputChatBox("Le entregaste #329632$"..convertNumber(monto).." dolares #FFFFFFa #FF9000".._getPlayerNameR(destinatario).."'", player, 255, 200, 0, true)
		outputChatBox("Recibiste #329632$"..convertNumber(monto).." dolares #FFFFFF de parte de #FF9000".._getPlayerNameR(player)..".", destinatario, 255, 200, 0, true)
		givePlayerMoney(destinatario, monto)
		takePlayerMoney(player, monto)
		outputDebugString("[Banco] ".._getPlayerNameR(player).." > ".._getPlayerNameR(destinatario).." $"..monto.."", 0, 111, 183, 255)
	end
end
addCommandHandler({"dardinero", "pagar"}, enviarDinero)

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

local antiSpamAyuda  = {} 
function payuda ( source )
	if not notIsGuest( source ) then
		local tick = getTickCount()
		if (antiSpamAyuda[source] and antiSpamAyuda[source][1] and tick - antiSpamAyuda[source][1] < 10000) then
			source:outputChat("No puedes usar este comando después de 5 segundos", 150, 0, 0)
			return
		end
		source:outputChat("Acabar de enviar una petición de ayuda a los administradores", 150, 0, 0)
		message_staffs(source)
		if (not antiSpamAyuda[source]) then
			antiSpamAyuda[source] = {}
		end
		antiSpamAyuda[source][1] = getTickCount()
	end
end
addCommandHandler({"payuda"}, payuda)

function message_staffs(player)
	if isElement(player) then
		for i, v in ipairs(getElementsByType("player")) do
			local accName = getAccountName ( getPlayerAccount ( v ) )
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) then
				v:outputChat("#FC921AEl Jugador: #00FF00*["..player:getData("ID").."]".. removeColorCoding(_getPlayerNameR(player)).." #FC921Anecesita ayuda", 255, 255, 255, true)
				v:outputChat("¡Usa /ir [Nombre_Apellido o ID] para ir donde el!", 255, 255, 255, true)
			end
		end
	end
	return false
end

function mensaje(sourcePlayer, command, who, ...)
	if not notIsGuest(sourcePlayer) then
		local targetPlayer

		-- Check if 'who' is a number (assuming it's an ID)
		if tonumber(who) then
			targetPlayer = getElementByID(who)
		else
			targetPlayer = getFromName(sourcePlayer, who)
		end

		if (targetPlayer and isElement(targetPlayer) and getElementType(targetPlayer) == "player") then
			if targetPlayer ~= sourcePlayer then
				-- Rest of your existing code remains unchanged
				-- ...

			else
				sourcePlayer:outputChat("[#F26E03MP#FFFFFF] #F26E03>>#FFFFFF No tienes amigos para enviar mps? #F26E03<<", 255, 255, 255, true)
			end
		else
			sourcePlayer:outputChat("* [Nombre_Apellido o ID] [Mensaje] ", 150, 0, 0)
		end
	end
end
addCommandHandler({ "mp", "mensaje", "pm" }, mensaje)
-- Crear una tabla para almacenar los mensajes privados
local privateMessages = {}
local antiSpamPM  = {} 
local MP = {}
-- Función para manejar el comando /mp
function onPrivateMessage(player, cmd, targetID, ...)
    local message = table.concat({...}, " ") -- Unir los argumentos del mensaje
    local ply = getPlayerFromName(targetID)
    
    
    if not targetID or not ply then
        outputChatBox("Jugador no encontrado.", player, 255, 0, 0)
        return
    end
    
    if MP[targetPlayer] then
        player:outputChat("* El jugador " .. getPlayerName(targetPlayer) .. " tiene deshabilitados los mensajes", 150, 50, 50, true)
        return
    end
    if MP[ply] then
        player:outputChat("* El jugador " .. getPlayerName(ply) .. " tiene deshabilitados los mensajes", 150, 50, 50, true)
        return
    end
    
     if ply then
      
        privateMessages[ply] = message
        outputChatBox("#fcba03[MP] #00FF00-> " .. getPlayerName(ply) .. " (ID: " .. getElementData(ply, "ID") .."): #ffFFff: " .. message, player, 255, 255, 0,true)
        outputChatBox("#fcba03[MP] #ff3d3d<- " .. getPlayerName(player) .. " (ID: " .. getElementData(player, "ID") ..  "): #ffFFff:" .. message, ply, 255, 255, 0,true)
        
       
     else
      local targetPlayer = getPlayerFromID(targetID)
        
    if targetPlayer then
        privateMessages[targetPlayer] = message
   outputChatBox("#fcba03[MP] #00FF00-> " .. getPlayerName(targetPlayer) .. " (ID: " .. getElementData(targetPlayer, "ID") .."): #ffFFff: " .. message, player, 255, 255, 0,true)
        outputChatBox("#fcba03[MP] #ff3d3d<- " .. getPlayerName(player) .. " (ID: " .. getElementData(player, "ID") ..  "): #ffFFff:" .. message, targetPlayer, 255, 255, 0,true)
        
    else
        outputChatBox("Jugador no encontrado o no está conectado.", player, 255, 0, 0)
    end
    end   

end
addCommandHandler("mp", onPrivateMessage)

-- Función para obtener un jugador por su ID
function getPlayerFromID(playerID)
    for _, player in ipairs(getElementsByType("player")) do
        if getElementData(player, "ID") == tonumber(playerID) then
            return player
        end
    end
    return false
end


function staffs_onServer(source)
	if not notIsGuest( source ) then
		source:outputChat("#ffFFff== MIEMBROS DEL EQUIPO #00FF00CONECTADOS #ffFFff==", 66, 57, 76,true)
		for _, v in ipairs(Element.getAllByType("player")) do
			local accName = getAccountName ( getPlayerAccount ( v ) )
			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerator" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderator" ) ) then
				if v:getData("Admin:Disponible") == true then
                    source:outputChat("#ffFFff", 255, 255, 255, true)
					source:outputChat("#42644C".._getPlayerNameR(v).." #FFFFFF[#FF0033"..getACLFromPlayer(v).."#FFFFFF]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler({"admins", "staffs","staff","moderadores"}, staffs_onServer)
addCommandHandler("vermp",function(player)
	local accName = getAccountName ( getPlayerAccount ( player ) )
	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperMod" ) ) then
		if vermps[player] == nil then
			vermps[player] = true
			player:outputChat("Ahora puedes ver los mps",0,255,0,true)
		else
			player:outputChat("Ya no puedes ver los mps",255,0,0,true)
			vermps[player] = nil
		end
	end
end)
local antiSpamPM  = {} 
local MP = {}


addEventHandler("onPlayerQuit", getRootElement(), function()
	if MP[source] == true then
		MP[source] = nil
	end
end)

function no_mp( player )
	if not notIsGuest( player ) then
		if MP[player] == true then
			MP[player] = nil--
			player:outputChat("Los mensajes mediante MP han sido #00FF00Activados.", 255, 255, 255, true)
		else
			MP[player] = true
			player:outputChat("Los mensajes mediante MP han sido #FF0033Desactivados.", 255, 255, 255, true)
		end
	end
end
addCommandHandler("nomp", no_mp)

------------------------------------------------- Sistema de dudas

local antiSpamDuda  = {}

local responderDuda = {}

local adminDuda = {}



function dude_command( thePlayer, commandName, ... )

	if not notIsGuest( thePlayer ) then

		local msg = table.concat({...}, " ")

		if msg ~= "" and msg ~= " " then

			local tick = getTickCount()

			if (antiSpamDuda[thePlayer] and antiSpamDuda[thePlayer][1] and tick - antiSpamDuda[thePlayer][1] < 30000) then

				return

				thePlayer:outputChat("Espera 30 segundos para enviar una duda", 150, 0, 0, true)

			end

			thePlayer:outputChat("#FC921A¡#FFFFFFAcabas de enviar tu Duda#FC921A!", 255, 255, 255, true)

			thePlayer:outputChat("#FC921A[Duda]#FFFFFF: "..msg, 255, 255, 255, true)

			-- admins

			message_admins_duda(thePlayer, msg)

		end

		if (not antiSpamDuda[thePlayer]) then

			antiSpamDuda[thePlayer] = {}

		end

		antiSpamDuda[thePlayer][1] = getTickCount()

	end

end

addCommandHandler({"duda"}, dude_command)



function message_admins_duda(player, msg)

	if isElement(player) then

		for i, v in ipairs(getElementsByType("player")) do

			local accName = getAccountName ( getPlayerAccount ( v ) )

			if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) then

				v:outputChat("#FC921AEl Jugador: #00FF00*["..player:getData("ID").."]".. removeColorCoding(_getPlayerNameR(player)).." #FC921Aacaba de enviar su duda", 255, 255, 255, true)

				v:outputChat("#FC921A[Duda del Jugador]#FFFFFF"..msg, 255, 255, 255, true)

				v:outputChat("¡Usa /responderduda [Nombre_Apellido o ID]", 255, 255, 255, true)

				responderDuda[v] = true

				adminDuda[v] = _getPlayerNameR(player)

			end

		end

	end

	return false

end



function responder_duda( player, cmd, p )

	local accName = getAccountName ( getPlayerAccount ( player ) )

	if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Ayudante" ) ) then

		if responderDuda[player] == true then

			if tonumber(p) then

				local jugador = getPlayerFromPartialNameID(p)

				if (jugador) then

					jugador:outputChat("¡El ("..getACLFromPlayer(player)..") ".._getPlayerNameR(player).." ah respondido tu duda!", 255, 255, 255, true)

					message_admins("¡El ("..getACLFromPlayer(player)..") ".._getPlayerNameR(player).." ah respondido la duda del jugador: "..adminDuda[player].."!", 50, 150, 50, true)

				end

			else

				local jugador = getPlayerFromPartialName(p)

				if (jugador) then

					jugador:outputChat("¡El ("..getACLFromPlayer(player)..") ".._getPlayerNameR(player).." ah respondido tu duda!", 255, 255, 255, true)

					message_admins("¡El ("..getACLFromPlayer(player)..") ".._getPlayerNameR(player).." ah respondido la duda del jugador: "..adminDuda[player].."!", 50, 150, 50, true)

				end

			end

			adminDuda[player] = nil

			responderDuda[player] = nil

		end

	end

end

addCommandHandler({"responderduda", "rduda"}, responder_duda)



function message_admins(msg, r, g, b, val)

	for i, v in ipairs(getElementsByType("player")) do

		local accName = getAccountName ( getPlayerAccount ( v ) )

		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "Admin" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "SuperModerador" ) ) or isObjectInACLGroup ("user."..accName, aclGetGroup ( "Moderador" ) ) then

			v:outputChat(msg, r, g, b, val)

		end

	end

	return false

end

------------------------------------------------- PM

local antiSpamPM  = {} 

local MP = {}



function mensaje(sourcePlayer, command, who, ...)

	if not notIsGuest( sourcePlayer ) then

		if tonumber(who) then

			local targetPlayer = getPlayerFromPartialNameID(who)

			if ( targetPlayer ) then 

				if targetPlayer ~= sourcePlayer then

					if MP[targetPlayer] == true then

						sourcePlayer:outputChat("* El jugador ".._getPlayerNameR(targetPlayer).." tiene desahabilitado los mensajes", 150, 50, 50, true)

					else

						local msg = table.concat({...}, " ")

						if msg ~= "" and msg ~= " " then

						local tick = getTickCount()

							if (antiSpamPM[sourcePlayer] and antiSpamPM[sourcePlayer][1] and tick - antiSpamPM[sourcePlayer][1] < 2000) then

								return

							end

							if MP[sourcePlayer] == true then

								sourcePlayer:outputChat("#FF0033[ADVERTENCIA] #FFFFFFTienes los mensajes desahabilitados, activalos para que te pueda responder.", 255, 255, 255, true)

							end

							sourcePlayer:outputChat("#FFFFFF[#6FB7FFMP#FFFFFF]#FFAD36".. removeColorCoding(_getPlayerNameR(sourcePlayer)).."#FFFFFF > ".. removeColorCoding(_getPlayerNameR(targetPlayer))..": ".. msg.."", 203, 129, 0, true)

							targetPlayer:outputChat("#FFFFFF[#6FB7FFMP#FFFFFF]#FFAD36".. removeColorCoding(_getPlayerNameR(sourcePlayer)).."#FFFFFF: ".. msg.."", 203, 129, 0, true)

							outputDebugString("".. _getPlayerNameR(sourcePlayer).." > ".. _getPlayerNameR(targetPlayer)..": ".. msg.."", 0, 111, 183, 255)

						end

						if (not antiSpamPM[sourcePlayer]) then

							antiSpamPM[sourcePlayer] = {}

						end

						antiSpamPM[sourcePlayer][1] = getTickCount()

					end

				end

			else

				sourcePlayer:outputChat("* [Nombre_Apellido o ID] [Mensaje] ", 150, 0, 0)

			end

		else

			local targetPlayer = getPlayerFromPartialName(who)

			if ( targetPlayer ) then 

				if targetPlayer ~= sourcePlayer then

					if MP[targetPlayer] == true then

						sourcePlayer:outputChat("* El jugador ".._getPlayerNameR(targetPlayer).." tiene desahabilitado los mensajes", 150, 50, 50, true)

					else

						local msg = table.concat({...}, " ")

						if msg ~= "" and msg ~= " " then

						local tick = getTickCount()

							if (antiSpamPM[sourcePlayer] and antiSpamPM[sourcePlayer][1] and tick - antiSpamPM[sourcePlayer][1] < 2000) then

								return

							end

							if MP[sourcePlayer] == true then

								sourcePlayer:outputChat("#FF0033[ADVERTENCIA] #FFFFFFTienes los mensajes desahabilitados, activalos para que te pueda responder.", 255, 255, 255, true)

							end

							sourcePlayer:outputChat("#FFFFFF[#6FB7FFMP#FFFFFF]#FFAD36".. removeColorCoding(_getPlayerNameR(sourcePlayer)).."#FFFFFF > ".. removeColorCoding(_getPlayerNameR(targetPlayer))..": ".. msg.."", 203, 129, 0, true)

							targetPlayer:outputChat("#FFFFFF[#6FB7FFMP#FFFFFF]#FFAD36".. removeColorCoding(_getPlayerNameR(sourcePlayer)).."#FFFFFF: ".. msg.."", 203, 129, 0, true)

							outputDebugString("".. _getPlayerNameR(sourcePlayer).." > ".. _getPlayerNameR(targetPlayer)..": ".. msg.."", 0, 111, 183, 255)

						end

						if (not antiSpamPM[sourcePlayer]) then

							antiSpamPM[sourcePlayer] = {}

						end

						antiSpamPM[sourcePlayer][1] = getTickCount()

					end

				end

			else

				sourcePlayer:outputChat("* [Nombre_Apellido o ID] [Mensaje] ", 150, 0, 0)

			end

		end

	end

end

addCommandHandler({"mp", "mensaje"}, mensaje)



addEventHandler("onPlayerQuit", getRootElement(), function()

	if MP[source] == true then

		MP[source] = nil

	end

end)



function no_mp( player )

	if not notIsGuest( player ) then

		if MP[player] == true then

			MP[player] = nil--

			player:outputChat("Los mensajes mediante MP han sido #00FF00Activados.", 255, 255, 255, true)

		else

			MP[player] = true

			player:outputChat("Los mensajes mediante MP han sido #FF0033Desactivados.", 255, 255, 255, true)

		end

	end

end

addCommandHandler("nomp", no_mp)
