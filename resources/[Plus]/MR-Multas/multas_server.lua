loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

if getResourceFromName( '[LS]NewData' ):getState() ~= 'running' then 
	return outputDebugString( 'Activa el recurso [LS]NewData', 3, 255, 255, 255 )
end

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

local MarcadoresMulta = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getMarkersMultas()) do 
		Pickup = Pickup(v[1], v[2], v[3], 3, 1274, 0)
		Pickup:setInterior(v.int)
		Pickup:setDimension(v.dim)
		MarcadoresMulta[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.3, 100, 50, 50, 0)
		MarcadoresMulta[i]:setInterior(v.int)
		MarcadoresMulta[i]:setDimension(v.dim)
	end
end)
--
addCommandHandler("pagarmulta", function(player, cmd, id)
    if isElement(player) then
        if not notIsGuest(player) then
            for i, marker in ipairs(MarcadoresMulta) do
                if player:isWithinMarker(marker) then
                    if not player:isInVehicle() then
					   if not id then
					      exports["[LS]Notificaciones"]:setTextNoti(player, "/pagarmulta [Numero de expediente].", 150, 50, 50, true)
					   return
					   
					   end
                        if tonumber(id) then
                            local result = query("SELECT * FROM Multas WHERE ID = ? AND Cuenta = ?", id, AccountName(player))
                            if result and type(result) == "table" and #result > 0 then
                                local cantidad = tonumber(result[1]["Cantidad"])
                                if player:getMoney() >= cantidad then
                                    player:outputChat("Acabas de pagar tu multa de: #004500$" .. convertNumber(cantidad) .. " dólares. #FFFFFFNúmero expediente: #A44B00" .. result[1]["ID"], 255, 255, 255, true)
                                    delete("DELETE FROM Multas WHERE ID = ? AND Cuenta = ?", id, AccountName(player))
                                    player:takeMoney(cantidad)
                                else
                                    exports["[LS]Notificaciones"]:setTextNoti(player, "No tienes suficiente dinero.", 150, 50, 50, true)
                                end
                            else
                                exports["[LS]Notificaciones"]:setTextNoti(player, "Número de multa inválido.", 150, 50, 50, true)
                            end
                        end
                    end
                end
            end
        end
    end
end)


addCommandHandler("multas", function(player, cmd)
	if isElement(player) then
		if not notIsGuest(player) then
			local s = query("SELECT * From Multas where Cuenta=?", AccountName(player))
			if not ( type( s ) == "table" and #s == 0 ) or not s then
				player:outputChat("=== #A44B00Multas #FFFFFF===", 255, 255, 255, true)
				for i, v in ipairs(s) do
					player:outputChat("Número expediente: #A44B00"..v.ID.." #FFFFFFMulta de: #004500$"..convertNumber(v.Cantidad).." dólares.", 255, 255, 255, true)
				end
			end
		end
	end
end)
addCommandHandler("multar", function(player, cmd, who, money, razon)
    if isElement(player) then
        if not notIsGuest(player) then
            if getPlayerFaction(player, "Policia") then
                if not who or not money or not razon or who == "" or money == "" or razon == "" then
                    player:outputChat("Sintaxis: /multar [jugador] [cantidad] [razon]", 255, 200, 0, true)
                    return
                end

                if tonumber(money) then
                    local thePlayer = getPlayerFromPartialName(who)
                    if thePlayer then
                        local posicion = Vector3(player:getPosition()) -- jugador
                        local posicion2 = Vector3(thePlayer:getPosition()) -- jugador multado
                        local x, y, z = posicion.x, posicion.y, posicion.z
                        local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z
                        local distancia = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)

                        if distancia > 2 then
                            player:outputChat("* Tienes que estar más cerca del jugador para multarlo", 255, 200, 0, true)
                            return
                        end

                        if distancia < 2 then
                            local id = math.random(100000, 999999)
                            insert("INSERT INTO Multas VALUES(?,?,?)", id, tonumber(money), AccountName(thePlayer))
                            thePlayer:outputChat("Acabas de ser multado por: #FFFFFF" .. player:getName(), 150, 50, 50, true)
                            thePlayer:outputChat("Número expediente: #004500" .. convertNumber(id), 50, 150, 50, true)
                            thePlayer:outputChat("Multa de: #004500$" .. convertNumber(money) .. " dólares.", 50, 150, 50, true)
                            thePlayer:outputChat("Razon: " .. razon, 50, 150, 50, true)
                            player:outputChat("Acabas de multar a " .. thePlayer:getName(), 50, 150, 50, true)
                        end
                    else
                        player:outputChat("No se encontró al jugador con el ID proporcionado.", 255, 200, 0, true)
                    end
                else
                    player:outputChat("* La cantidad de la multa debe ser un número válido", 255, 200, 0, true)
                end
            else
                player:outputChat("Debes ser miembro de la facción de la Policía para utilizar este comando.", 255, 200, 0, true)
            end
        end
    end
end)


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