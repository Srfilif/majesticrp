local valoresArresto = {}
local tiempoArrestos = {}

local posicionesJail = {
	[1]={227.35778808594, 110.12662506104, 999.015625},
	[2]={223.06430053711, 108.76822662354, 999.015625},
	[3]={219.26962280273, 109.43273925781, 999.015625},
	[4]={215.07423400879, 109.84159851074, 999.015625},
}

addCommandHandler("arrestar", function(player, cmd, who, money, time, id)
	if not notIsGuest( player ) then
		if getPlayerFaction( player, "Policia" ) or getPlayerDivision( player, "S.W.A.T." ) or getPlayerDivision( player, "DIC" ) or getPlayerFaction( player, "Gobierno" ) then
			if tonumber(time) and tonumber(money) then
				local thePlayer = getPlayerFromPartialName(who)
				if (thePlayer) and not isPlayerExistsArresto(thePlayer) then
					--if thePlayer ~= player then
						if tonumber(id) >= 1 and tonumber(id) <= 6 then
							--
							thePlayer:outputChat("Has sido arrestado por ".._getPlayerNameR(player).." por "..tonumber(time).." minutos con una multa de $"..money, 150, 50, 50, true)
							--
							player:outputChat("Metistea ".._getPlayerNameR(thePlayer).." a la carcel por "..tonumber(time).." minutos y lo multaste por $"..money, 50, 150, 50, true)
							--
							if thePlayer:isInVehicle() then
								thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())
							end
							thePlayer:takeMoney(tonumber(money))
							local x, y, z = posicionesJail[tonumber(id)][1], posicionesJail[tonumber(id)][2], posicionesJail[tonumber(id)][3]
							thePlayer:setPosition(x, y, z)
							thePlayer:setDimension(0)
							thePlayer:setInterior(10)
							--
							table.insert(valoresArresto, {AccountName(thePlayer), tonumber(time*60)})
							--
							tiempoArrestos[thePlayer] = setTimer(bajarTimeArresto, 1000, 0, thePlayer)
						else
							player:outputChat("* Debes colocar el número de celda que estara el preso: 1-4", 150, 50, 50, true)
						end
						--end
					else
						player:outputChat("Puedes colocar el número de celda del 1-6", 150, 50, 50, true)
						player:outputChat("Syntax: /arrestar [Nombre] [Money] [Time] [Celda]", 255, 255, 255, true)
					end
				end
			end
		end
	end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	if isTimer(tiempoArrestos[source]) then
		killTimer(tiempoArrestos[source])
	end
end)

function setPlayerJailPolice(player)
	if isElement(player) then
		if player:getType() == "player" then
			tiempoArrestos[player] = setTimer(bajarTimeArresto, 1000, 0, player)
			for i, v in ipairs(valoresArresto) do
				if AccountName(player) == v[1] then
					player:outputChat("* Tienes #FF0033"..v[2].."#FFFFFF segundos para salir de la carcel", 255, 255, 255, true)
				end
			end
		end
	end
end

function isPlayerExistsArresto(player)
	for _, v in ipairs (valoresArresto) do
		if v[1] == AccountName(player) then
			return true
		end
	end
	return false
end

function bajarTimeArresto(player)
	for i, v in ipairs(valoresArresto) do
		if AccountName(player) == v[1] then
			if v[2] >= 1 then
				v[2] = v[2] - 1
				setElementData(player, "JailOOC", v[2])
			end
			if v[1] and v[2] == 0 then
				table.remove(valoresArresto, i, v[1])
				setElementData(player, "JailOOC", 0)
				print(v[1].." ha sido removida de la tabla de carcel")
				local thePlayer = getPlayerFromPartialName(v[1])
				if (thePlayer) then
					if isTimer(tiempoArrestos[thePlayer]) then
						killTimer(tiempoArrestos[thePlayer])
					end
					thePlayer:setTeam(nil)
					thePlayer:outputChat("* Acabas de salr de la carcel", 50, 150, 50, true)
					thePlayer:setPosition(634.666015625, -571.5078125, 16.3359375)
					thePlayer:setInterior(0)
					thePlayer:setDimension(0)
				end
			end
		end
	end
end
local barras = {}
local nextID = 1 -- Contador para asignar IDs únicos a las barreras

addCommandHandler("barra", function(p, cmd)
    if not notIsGuest(p) then
        if getPlayerFaction(p, "Policia") or getPlayerFaction(p, "S.W.A.T.") or getPlayerFaction(p, "DIC") then
            local pos = Vector3(p:getPosition())
            local x, y, z = pos.x, pos.y, pos.z
            local rot = Vector3(p:getRotation())
            local rz = rot.z
            local dim = p:getDimension()
            local int = p:getInterior()
            
            -- Crear la barrera con ID único
            local barrera = Object(1459, x, y, z - 0.45, 0, 0, rz, false)
            barrera:setData("Object:Barra", true)
            barrera:setData("Barra:ID", nextID)
            barrera:setCollisionsEnabled(true)
            barrera:setFrozen(true)
            barrera:setDimension(dim)
            barrera:setInterior(int)
			barrera:setBreakable(false)
            
            barras[nextID] = barrera
            outputChatBox("#3458eb[SAPD]#ffFFff* Barrera creada con ID: " .. nextID, p, 0, 255, 0,true)
            nextID = nextID + 1
        end
    end
end)

addCommandHandler("eliminarbarra", function(p, cmd, id)
    if not notIsGuest(p) then
        if getPlayerFaction(p, "Policia") or getPlayerFaction(p, "S.W.A.T.") or getPlayerFaction(p, "DIC") then
            if id then
                -- Buscar y eliminar barrera por ID
                id = tonumber(id)
                local barrera = barras[id]
                if barrera and isElement(barrera) then
                    destroyElement(barrera)
                    barras[id] = nil
                    outputChatBox("#ff3d3d* Barrera con ID " .. id .. " eliminada.", p, 0, 255, 0,true)
                else
                    outputChatBox("#ff3d3d* No se encontró una barrera con el ID especificado.", p, 255, 0, 0,true)
                end
            else
                -- Eliminar la barrera más cercana
                local pos = Vector3(p:getPosition())
                local closestBarrera, closestDistance = nil, 1 -- Rango de 1 unidad
                for _, barrera in pairs(barras) do
                    if isElement(barrera) then
                        local dist = (Vector3(barrera:getPosition()) - pos).length
                        if dist < closestDistance then
                            closestBarrera = barrera
                            closestDistance = dist
                        end
                    end
                end
                
                if closestBarrera then
                    local id = closestBarrera:getData("Barra:ID")
                    destroyElement(closestBarrera)
                    barras[id] = nil
                    outputChatBox("#3458eb[SAPD]#ffFFff* Se eliminó la barrera más cercana con ID: " .. id, p, 0, 255, 0,true)
                else
                    outputChatBox("#ff3d3d* No se encontró ninguna barrera cercana.", p, 255, 0, 0,true)
                end
            end
        end
    end
end)


addCommandHandler("barreras", function(p, cmd)
    if not notIsGuest(p) then
        if getPlayerFaction(p, "Policia") or getPlayerFaction(p, "S.W.A.T.") or getPlayerFaction(p, "DIC") then
            local count = 0
            outputChatBox("#ffff3d=== Barreras Activas ===", p, 0, 255, 255,true)
            for id, barrera in pairs(barras) do
                if isElement(barrera) then
                    local pos = Vector3(barrera:getPosition())
                    outputChatBox("ID: " .. id .. " | Posición: " .. string.format("%.2f, %.2f, %.2f", pos.x, pos.y, pos.z), p, 0, 255, 0,true)
                    count = count + 1
                end
            end
            if count == 0 then
                outputChatBox("#ff3d3d* No hay barreras activas.", p, 255, 0, 0,true)
            end
        end
    end
end)
local conos = {}
local nextConoID = 1 -- Contador para asignar IDs únicos a los conos

addCommandHandler("cono", function(p, cmd)
    if not notIsGuest(p) then
        if getPlayerFaction(p, "Policia") or getPlayerFaction(p, "S.W.A.T.") or getPlayerFaction(p, "DIC") then
            local pos = Vector3(p:getPosition())
            local x, y, z = pos.x, pos.y, pos.z
            local rot = Vector3(p:getRotation())
            local rz = rot.z
            local dim = p:getDimension()
            local int = p:getInterior()

            -- Crear el cono con ID único
            local cono = Object(1238, x, y, z - 0.6, 0, 0, rz, false)
            cono:setData("Object:Cono", true)
            cono:setData("Cono:ID", nextConoID)
            cono:setCollisionsEnabled(true)
            cono:setFrozen(true)
            cono:setDimension(dim)
            cono:setInterior(int)
            cono:setData("destructible", false) -- Evitar destrucción manual

            conos[nextConoID] = cono
            outputChatBox("Cono creado con ID: " .. nextConoID, p, 0, 255, 0)
            nextConoID = nextConoID + 1
        end
    end
end)

addCommandHandler("eliminarcono", function(p, cmd, id)
    if not notIsGuest(p) then
        if getPlayerFaction(p, "Policia") or getPlayerFaction(p, "S.W.A.T.") or getPlayerFaction(p, "DIC") then
            if id then
                -- Buscar y eliminar cono por ID
                id = tonumber(id)
                local cono = conos[id]
                if cono and isElement(cono) then
                    destroyElement(cono)
                    conos[id] = nil
                    outputChatBox("Cono con ID " .. id .. " eliminado.", p, 0, 255, 0)
                else
                    outputChatBox("No se encontró un cono con el ID especificado.", p, 255, 0, 0)
                end
            else
                -- Eliminar el cono más cercano
                local pos = Vector3(p:getPosition())
                local closestCono, closestDistance = nil, 1 -- Rango de 1 unidad
                for _, cono in pairs(conos) do
                    if isElement(cono) then
                        local dist = (Vector3(cono:getPosition()) - pos).length
                        if dist < closestDistance then
                            closestCono = cono
                            closestDistance = dist
                        end
                    end
                end

                if closestCono then
                    local id = closestCono:getData("Cono:ID")
                    destroyElement(closestCono)
                    conos[id] = nil
                    outputChatBox("Se eliminó el cono más cercano con ID: " .. id, p, 0, 255, 0)
                else
                    outputChatBox("No se encontró ningún cono cercano.", p, 255, 0, 0)
                end
            end
        end
    end
end)

addCommandHandler("conos", function(p, cmd)
    if not notIsGuest(p) then
        if getPlayerFaction(p, "Policia") or getPlayerFaction(p, "S.W.A.T.") or getPlayerFaction(p, "DIC") then
            local count = 0
            outputChatBox("=== Conos Activos ===", p, 0, 255, 255)
            for id, cono in pairs(conos) do
                if isElement(cono) then
                    local pos = Vector3(cono:getPosition())
                    outputChatBox("ID: " .. id .. " | Posición: " .. string.format("%.2f, %.2f, %.2f", pos.x, pos.y, pos.z), p, 0, 255, 0)
                    count = count + 1
                end
            end
            if count == 0 then
                outputChatBox("No hay conos activos.", p, 255, 0, 0)
            end
        end
    end
end)
