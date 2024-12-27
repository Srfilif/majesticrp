local valoresJailOOC = {}
local tiempoTimers = {}

permisos = {
	["Administrador"]=true,
	["SuperModerador"]=true,
	["Moderador"]=true,
}

local posicionesOOC = {
	{227.35778808594, 110.12662506104, 999.015625},
	{223.06430053711, 108.76822662354, 999.015625},
	{219.26962280273, 109.43273925781, 999.015625},
	{215.07423400879, 109.84159851074, 999.015625},
}

addCommandHandler("jail", function(source, cmd, jugador, tiempo, ...)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			local player = getPlayerFromPartialName(jugador)
			if (player) and not isPlayerExists(player) then
				--if player ~= source then
					if tonumber(tiempo) then
						local razon = table.concat({...}, " ")
						if razon ~="" and razon~= " " then
							-- si se encuentra en un vehiculo lo saca del auto
							if player:isInVehicle() then
								player:removeFromVehicle(player:getOccupiedVehicle())
							end
							for i, v in ipairs(Element.getAllByType("player")) do
								v:outputChat("#ff8900"..source:getName().."#ffFFff metio en Jail OCC a #ffff3b"..player:getName().."#ffFFff Por "..tiempo.." minutos. #fd3939Razon:#ffFFff"..razon..".", 255, 255, 255, true)
							end
							--
							local lugarRandom = math.random(#posicionesOOC)
							local x, y, z = posicionesOOC[lugarRandom][1], posicionesOOC[lugarRandom][2], posicionesOOC[lugarRandom][3]
							player:setTeam(Team.getFromName("Jail OOC"))
							player:setInterior(10)
							player:setDimension(0)
							player:setPosition(x, y, z)
							player:setData("JailOOC", 0)
							--
							table.insert(valoresJailOOC, {AccountName(player), tonumber(tiempo*60)})
							tiempoTimers[player] = setTimer(bajarTiempoJails, 1000, 0, player)
						end
					end
				end
			end
		--end
	end
end
)

addCommandHandler("unjail", function(source, cmd, jugador, ...)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			local player = getPlayerFromPartialName(jugador)
			if (player) then
				if isPlayerExists(player) then
					local razon = table.concat({...}, " ")
					if razon ~="" and razon ~=" " then
						for i, v in ipairs(Element.getAllByType("player")) do
							v:outputChat("#ff8900"..source:getName().."#ffFFff Saco de Jail OOC a #ffff3b"..player:getName().." #fd3939Razón:#FFFFFF "..razon.."", 255, 255, 255, true)
						end
						player:outputChat("* Acabas de salir de jail", 50, 150, 50, true)
						player:setPosition(1742.7978515625, -1860.466796875, 13.578701019287)
						player:setInterior(0)
						player:setDimension(0)
						player:setTeam(nil)
						player:setData("JailOOC", 0)
						if isTimer(tiempoTimers[player]) then
							killTimer(tiempoTimers[player])
						end
						for i, v in ipairs(valoresJailOOC) do
							if AccountName(player) == v[1] then
								table.remove(valoresJailOOC, i, v[1])
							end
						end
					end
				end
			end
		end
	end
end)


addEventHandler("onPlayerQuit", getRootElement(), function()
	if isTimer(tiempoTimers[source]) then
		killTimer(tiempoTimers[source])
	end
end)

function setPlayerJail(player)
	if isElement(player) then
		if player:getType() == "player" then
			tiempoTimers[player] = setTimer(bajarTiempoJails, 1000, 0, player)
			player:setTeam(Team.getFromName("Jail OOC"))
			for i, v in ipairs(valoresJailOOC) do
				if AccountName(player) == v[1] then
					player:outputChat("* Tienes #FF0033"..v[2].."#FFFFFF segundos para salir de jail", 255, 255, 255, true)
				end
			end
		end
	end
end

addCommandHandler("jails", function(source)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			source:outputChat("* Jugadores encarcelados: ", 50, 150, 50, true)
			for i, v in ipairs(valoresJailOOC) do
				if i == 0 then
					source:outputChat("- Ninguno", 150, 50, 50, true)
				else
					source:outputChat(v[1].. " | Tiempo: "..v[2], 150, 50, 50, true)
				end
			end
		end
	end
end)

function isPlayerExists(player)
	for _, v in ipairs (valoresJailOOC) do
		if v[1] == player:getAccount():getName() then
			return true
		end
	end
	return false
end

function bajarTiempoJails(player)
	for i, v in ipairs(valoresJailOOC) do
		if player:getAccount():getName() == v[1] then
			if v[2] >= 1 then
				v[2] = v[2] - 1
				player:setData("JailOOC", v[2])
			end
			if v[1] and v[2] == 0 then
				table.remove(valoresJailOOC, i, v[1])
				local thePlayer = getPlayerFromAccountName(v[1])
				if (thePlayer) then
					if isTimer(tiempoTimers[thePlayer]) then
						killTimer(tiempoTimers[thePlayer])
					end

					thePlayer:setTeam(nil)
					thePlayer:outputChat("* Acabas de salir de jail", 50, 150, 50, true)
					thePlayer:setPosition(1749.271484375, 145.265625, 33.353542327881)
					thePlayer:setInterior(0)
					thePlayer:setDimension(0)
				end
			end
		end
	end
end

function getPlayerFromAccountName(name) 
    local acc = getAccount(name)
    if name and acc and not isGuestAccount(acc) then
        return getAccountPlayer(acc)
    else
        return false
    end
end

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