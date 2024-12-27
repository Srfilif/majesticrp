--[[
--------[COMANDOS para la gente fuera de la faccion---------

/llamar 911  [Cuando llamen al 911 les saldra esto "911 ¿Cuál es su emergencia" y ellos tienen que responder no se algo "Me robaron el carro" y le sale lo siguiente "Muy bien, espere a que la unidad policial llegue a su ubicacion, mantenga la calma" y a los policia les saldra lo siguiente:
Se ah recibido una llamada del número ..numero.
Usa /llamado [ID DE LA PERSONA QUE LLAMÓ] para acudir al llamado]
(Ya cuando usen el comando dicho les saldrá así)
Llamado [ID] : ..texto escrito por el que llamo

--
* A nombre le estan llamando (( nombre ))
]]

local EnLlamada = {}
local EnLlamada911 = {}
local ResponderLlamada = {}
local ApagarCelular = {}
local JugadorLlamada = {}
local TimerLlamada = {}

function llamarJugador(player, cmd, numero)
	if notIsGuest(player) then
		player:outputChat("* Tienes que loguear para usar esto", 255, 200, 0, true)
		return
	end
	if player:getData("Roleplay:Telefono") ~= "Si" then
		player:outputChat("* Tienes que tener un telefono para llamar", 255, 200, 0, true)
		return
	end
	if tostring(player:getData("Roleplay:NumeroTelefono")) == tostring(numero) then
		player:outputChat("* No te puedes llamar a ti mismo", 255, 200, 0, true)
		return
	end
	if string.len(numero) >= 2 then
		local thePlayer = getPlayerNumberCall(numero)
		if (thePlayer) then
			if ApagarCelular[thePlayer] == true then
				player:outputChat("* La persona que estas llamando, no ha contestado o tiene el celular apagado", 255, 200, 0, true)
				return
			end
			if EnLlamada[thePlayer] == true then
				player:outputChat("* Esta persona ya esta en una llamada, intentalo en otro momento", 255, 200, 0, true)
				return
			end
			EnLlamada[player] = true
			ResponderLlamada[thePlayer] = true
			JugadorLlamada[thePlayer] = player:getName()

			thePlayer:outputChat("* Estas recibiendo una llamada usa /contestar o /colgar", 255, 200, 0, true)
			player:triggerEvent("SoundsPhone", player, "LlamarSound")

			local x, y, z = getElementPosition(thePlayer)
			local chatCol = ColShape.Sphere(x, y, z, 10)
			local nearPlayers = chatCol:getElementsWithin("player")
			for k, v in ipairs(nearPlayers) do
				v:outputChat("* ".._getPlayerNameR(thePlayer).." esta recibiendo una llamada", 255, 200, 0, true)
				v:triggerEvent("SoundsPhone", root, "LlamadaSound", thePlayer)
			end
			if isElement(chatCol) then
				chatCol:destroy()
			end

			TimerLlamada[player] = setTimer(function(p, t, n)
				p:outputChat("* El numero que llamaste no da respuesta", 255, 200, 0, true)
				t:outputChat("* Tienes una llamada perdida", 255, 200, 0, true)
				ResponderLlamada[t] = nil
                EnLlamada[p] = nil
                JugadorLlamada[t] = nil
                player:triggerEvent("SoundsPhone", player, "stopLlamada")
                for k, i in ipairs(nearPlayers) do
                	i:triggerEvent("SoundsPhone", root, "stopLlamado", thePlayer)
                end
            end, 15000, 1, player, thePlayer)
		end
	end
end
addCommandHandler("llamar", llamarJugador)

function ApagarTelefono(player)
	if not notIsGuest( player ) then
		if ResponderLlamada[player] == nil or ResponderLlamada[player] == false then
			if ApagarCelular[player] == true then
				player:outputChat("Ya tienes el celular apagado.", 150, 50, 50, true)
			else
				ApagarCelular[player] = true
				MensajeRol(player, "apago su telefono.")
			end
		else
			player:outputChat("Tienes una llamada en este momento usa colgar para después apagar el celular", 150, 50, 50)
		end
	end
end
addCommandHandler("apagarcelular", ApagarTelefono)

function EncenderTelefono(player)
	if not notIsGuest( player ) then
		if ApagarCelular[player] == true then
			ApagarCelular[player] = nil
			MensajeRol(player, "encendio su telefono.")
		else
			player:outputChat("Ya tienes el celular encendido.", 150, 50, 50, true)
		end
	end
end
addCommandHandler("encendercelular", EncenderTelefono)

local MandarMensajesEnLLamada = {}

function colgarLlamada(player)
	if not notIsGuest( player ) then
		if ResponderLlamada[player] == true then
			local thePlayer = getPlayerFromPartialName(JugadorLlamada[player])
			if (thePlayer) then
				player:outputChat("Colgaste al número: "..thePlayer:getData("Roleplay:NumeroTelefono"), 150, 50, 50)
				thePlayer:outputChat("El número: "..player:getData("Roleplay:NumeroTelefono").." te ha colgado.", 150, 50, 50)
				--
				thePlayer:triggerEvent("SoundsPhone", thePlayer, "stopLlamada")
				--
				if isTimer(TimerLlamada[thePlayer]) then
					killTimer(TimerLlamada[thePlayer])
				end
				--
				TimerLlamada[thePlayer] = nil
				EnLlamada[thePlayer] = nil
				ResponderLlamada[thePlayer] = nil
				JugadorLlamada[thePlayer] = nil
				JugadorLlamada[player] = nil
				ResponderLlamada[player] = nil
				EnLlamada[player] = nil
				local x, y, z = getElementPosition( player )
				local chatCol = ColShape.Sphere(x, y, z, 10)
				local nearPlayers = chatCol:getElementsWithin("player")
				for index, v in ipairs(nearPlayers) do
					v:triggerEvent("SoundsPhone", getRootElement(  ), "stopLlamado", player)
				end
				if isElement(chatCol) then
					chatCol:destroy()
				end
			end
		end
	end
end
addCommandHandler("colgar", colgarLlamada)

function contestarLlamada(player)
	if not notIsGuest( player ) then
		if ResponderLlamada[player] == true then
			local thePlayer = getPlayerFromPartialName(JugadorLlamada[player])
			if (thePlayer) then
				player:outputChat("Acabas de contestar al número: "..thePlayer:getData("Roleplay:NumeroTelefono"), 50, 150, 50)
				thePlayer:outputChat("El número: "..player:getData("Roleplay:NumeroTelefono").." te ha contestado.", 50, 150, 50)
				--
				player:outputChat("usa /ll -mensaje--", 50, 150, 50)
				--
				thePlayer:triggerEvent("SoundsPhone", thePlayer, "stopLlamada")
				--
				if isTimer(TimerLlamada[thePlayer]) then
					killTimer(TimerLlamada[thePlayer])
				end
				--
				TimerLlamada[thePlayer] = nil
				EnLlamada[player] = true
				EnLlamada[thePlayer] = true
				ResponderLlamada[player] = true
				ResponderLlamada[thePlayer] = true
				MandarMensajesEnLLamada[thePlayer] = true
				MandarMensajesEnLLamada[player] = true
				JugadorLlamada[player] = thePlayer:getName()
				JugadorLlamada[thePlayer] = player:getName()
				local x, y, z = getElementPosition( player )
				local chatCol = ColShape.Sphere(x, y, z, 10)
				local nearPlayers = chatCol:getElementsWithin("player")
				for index, v in ipairs(nearPlayers) do
					v:triggerEvent("SoundsPhone", getRootElement(  ), "stopLlamado", player)
				end
				if isElement(chatCol) then
					chatCol:destroy()
				end
			end
		end
	end
end
addCommandHandler("contestar", contestarLlamada)

addCommandHandler("ll", function(player, cmd, ...)
	if not notIsGuest( player ) then
		if EnLlamada[player] == true and ResponderLlamada[player] == true then
			local msg = table.concat({...}, " ")
			local xd = trunklateText( player, msg )
			if msg ~="" and msg ~=" " then
				if EnLlamada911[player] == true then
					outputDebugString("[LLAMADA] ".. player:getName().." > Operadora: "..xd.." ", 0, 150, 0, 100)
					player:outputChat("* "..player:getName().." > Operadora: #FFFFFF"..msg, 0, 150, 0, true)
					setTimer(function(p)
						p:outputChat("Muy bien, espere a que la unidad policial llegue a su ubicacion, mantenga la calma", 0, 150, 0, true)
					
						for i, v in ipairs(Element.getAllByType("player")) do
							if v:getData("Roleplay:faccion") == "Policia" then
								v:outputChat("Se ah recibido una llamada del número ...", 150, 100, 100, true)
								v:outputChat("Usa /llamar "..player:getData("Roleplay:NumeroTelefono").." para acudir al llamado", 50, 150, 50, true)
							end
						end
					end, 1000, 1, player)
					setTimer(function(p)
						p:outputChat("* El número: Operadora te colgo", 150, 50, 50, true)
						EnLlamada911[p] = nil
						ResponderLlamada[p] = nil
						EnLlamada[p] = nil
					end, 3000, 1, player)
				else
					if EnLlamada[player] == true and MandarMensajesEnLLamada[player] == true then
						player:setData("TextInfo", {"> habla por telefono", 255, 0, 216})
						setTimer(function(p)
							p:setData("TextInfo", {"", 255, 0, 216})
						end, 2000, 1, player)
						local thePlayer = getPlayerFromPartialName(JugadorLlamada[player])
						if (thePlayer) then
							outputDebugString("[LLAMADA] ".._getPlayerNameR(player).." > ".._getPlayerNameR(thePlayer)..": "..xd.." ", 0, 150, 0, 100)
							player:outputChat("".._getPlayerNameR(player).." > "..thePlayer:getData("Roleplay:NumeroTelefono")..": #FFFFFF"..xd, 150, 0, 100, true)
							thePlayer:outputChat(""..player:getData("Roleplay:NumeroTelefono")..": #FFFFFF"..xd, 150, 0, 100, true)
						end
					end
				end
			end
		end
	end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	if ResponderLlamada[source] == true then
		local thePlayer = getPlayerFromPartialName(JugadorLlamada[source])
		if (thePlayer) then
			source:outputChat("Colgaste al número: "..thePlayer:getData("Roleplay:NumeroTelefono"), 150, 50, 50)
			thePlayer:outputChat("El número: "..source:getData("Roleplay:NumeroTelefono").." te ha colgado.", 150, 50, 50)
			--
			thePlayer:triggerEvent("SoundsPhone", thePlayer, "stopLlamada")
			--
			if isTimer(TimerLlamada[thePlayer]) then
				killTimer(TimerLlamada[thePlayer])
			end
			--
			TimerLlamada[thePlayer] = nil
			EnLlamada[thePlayer] = nil
			ResponderLlamada[thePlayer] = nil
			JugadorLlamada[thePlayer] = nil
			JugadorLlamada[source] = nil
			ResponderLlamada[source] = nil
			EnLlamada[source] = nil
			local x, y, z = getElementPosition( source )
			local chatCol = ColShape.Sphere(x, y, z, 10)
			local nearPlayers = chatCol:getElementsWithin("player")
			for index, v in ipairs(nearPlayers) do
				v:triggerEvent("SoundsPhone", getRootElement(  ), "stopLlamado", source)
			end
			if isElement(chatCol) then
				chatCol:destroy()
			end
		end
	end
	if EnLlamada[source] == true then
		EnLlamada[source] = nil
	end
	if ResponderLlamada[source] == true then
		ResponderLlamada[source] = nil
	end
	if EnLlamada911[source] == true then
		EnLlamada911[source] = nil
	end
	if MandarMensajesEnLLamada[source] == true then
		MandarMensajesEnLLamada[source] = nil
	end
	if JugadorLlamada[source] then
		JugadorLlamada[source] = nil
	end
end)

function trunklateText(thePlayer, text, factor)
    local msg = (tostring(text):gsub("%u", string.lower))
	return (tostring(msg):gsub("^%l", string.upper))
end

function getPlayerNumberCall(number)
    local number = number and tonumber(number) or nil
    if number then
        for _, player in ipairs(Element.getAllByType("player")) do
            local number_ = player:getData("Roleplay:NumeroTelefono")
            if tostring(number_):find(number, 1, true) then
				return player
            end
        end
    end
end

function verNumero(source)
	local numero = source:getData("Roleplay:NumeroTelefono")
	source:outputChat("[OPERADORA] Tu numero telefonico es: "..numero.."", 0, 150, 0)
end
addCommandHandler("numero", verNumero)

local antiSpamAnuncio = {}

function colocarAnuncio(source, cmd, ...)
	local msg = table.concat({...}, " ")
	local numero = source:getData("Roleplay:NumeroTelefono")
	if source:getData("Roleplay:Telefono") ~= "Si" then
		source:outputChat("No tienes un telefono para colocar un anuncio", 255, 200, 0, true)
		return
	end
	if msg == "" or msg == nil then
		source:outputChat("* Tienes que colocar el texto del anuncio antes de mandarlo", 255, 200, 0, true)
		return
	end
	local tick = getTickCount()
	if (antiSpamAnuncio[source] and antiSpamAnuncio[source][1] and tick - antiSpamAnuncio[source][1] < 900000) then
		return
		source:outputChat("* Espera 15 minutos antes de mandar otro anuncio", 255, 200, 0, true)
	end
	if getPlayerMoney(source) <= tonumber(650) then
		source:outputChat("* No tienes dinero suficiente para mandar un anuncio", 255, 200, 0)
		return
	end
	if isPlayerMuted(source) then
		source:outputChat("* No puedes enviar un anuncio si estas muteado", 255, 200, 0)
		return
	end
	outputDebugString("[ANUNCIO] ".. source:getName()..": "..msg.." ", 0, 150, 0, 100)
	exports["[POPLife]Discord"]:sendLogAnuncios("[FECHA: "..takeDate().."] | [ANUNCIO] ".. source:getName()..": "..msg.." ")
	takePlayerMoney(source, 650)
	for k, v in ipairs(getElementsByType("player")) do
		v:outputChat("#FFFFFF[#F1B80CAnuncio | Tel: "..numero.."#FFFFFF] "..msg.."", 255, 255, 255, true)
	end
	if (not antiSpamAnuncio[source]) then
		antiSpamAnuncio[source] = {}
	end
	antiSpamAnuncio[source][1] = getTickCount()
end
addCommandHandler("anuncio", colocarAnuncio)

function takeDate()
	local t = getRealTime();
	---
	local day = t.monthday;
	local month = t.month + 1;
	local year = t.year + 1900;
	---
	local hour = t.hour
	local min = t.minute
	local sec = t.second
	---
	return ""..day.."/"..month.."/"..year.." - "..hour..":"..min..":"..sec..""
end