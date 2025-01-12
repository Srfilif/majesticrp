addCommandHandler("liderpolicia", function(player, cmd, who)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			local thePlayer = getPlayerFromPartialName(who)
			if (thePlayer) then
				if thePlayer:getData("Roleplay:faccion") ~="" then
					player:outputChat(thePlayer:getName().." se encuentra en una facción debe dejar su facción para que le puedas dar el lider de policia.", 150, 50, 50, true)
				else
					local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", 'Policia', 'Si')
					if ( type( s ) == "table" and #s == 0 ) or not s then
						player:outputChat("* Le acabas de entregar el lider a #FFFFFF"..thePlayer:getName().."", 50, 100, 50, true)
						--
						thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de Policia", 50, 150, 50, true)
						--
						insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", 'Policia', AccountName(thePlayer), 'Comandante', '0', 'Si', '', 'No')
						--
						thePlayer:setData("Roleplay:faccion", "Policia")
					    setElementData(thePlayer, "Roleplay:faccion", "Policia") 
						outputChatBox(""..getElementData(thePlayer,"Roleplay:faccion").."",thePlayer)
						thePlayer:setData("Roleplay:faccion_lider", "Si")
						thePlayer:setData("Roleplay:faccion_rango", "Comandante")
						thePlayer:setData("Roleplay:faccion_sueldo", 0)
						thePlayer:setData("Roleplay:faccion_division", "")
						thePlayer:setData("Roleplay:faccion_division_lider", "No")
					else
						player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)
					end
				end
			else
				player:outputChat("Syntax: /liderpolicia [Nombre]", 255, 255, 255, true)
			end
		end
	end
end)

local antiSpamRadio = {}

function radio_police(p, cmd, ...)
	if not notIsGuest( p ) then
		if p:getData("Roleplay:faccion") ~="" then
			local tick = getTickCount()
			if (antiSpamRadio[p] and antiSpamRadio[p][1] and tick - antiSpamRadio[p][1] < 2000) then
				return
			end
			--
			local nick = _getPlayerNameR(p)
			--
			if p:getData("Roleplay:faccion_division") ~="" then
				div = "| "..p:getData("Roleplay:faccion_division").." "
			else
				div = ""
			end
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				local faccion = p:getData("Roleplay:faccion")
				local division = p:getData("Roleplay:faccion_division")
				outputDebugString("[RADIO] "..(p:getData("Roleplay:faccion_rango") or "").." "..div..""..nick..": "..msg.."", 0, 118, 98, 134)
				--
				for i, v in ipairs(Element.getAllByType("player")) do
					if v:getData("Roleplay:faccion") == faccion then
						--
						playSoundFrontEnd (v, 49)
						--
						setTimer(function(v, rank)
							if isElement(v) then
							v:outputChat("#FFFFFF[RADIO] #5C78BA"..(p:getData("Roleplay:faccion_rango") or "").." "..div..""..nick..":#FFFFFF "..msg.."", 118, 98, 134, true)
						end
						end, 100, 1, v, rank)
						-- antispam
						if (not antiSpamRadio[v]) then
							antiSpamRadio[v] = {}
						end
						antiSpamRadio[v][1] = getTickCount()
					end
				end
				--
				p:setData("TextInfo", {"> habla por la radio", 255, 0, 216})
				setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"", 255, 0, 216})
				end
				end, 2000, 1, p)
			end
		end
	end
end
addCommandHandler({"rf", "fr"}, radio_police)
 -- [Departamental | ..faccion | ..name]: [Texto]
local antiSpamOOCRadio = {}

function ooc_radio_polices(p, cmd, ...)
	if not notIsGuest( p ) then
		if p:getData("Roleplay:faccion") ~="" then
			local tick = getTickCount()
			if (antiSpamOOCRadio[p] and antiSpamOOCRadio[p][1] and tick - antiSpamOOCRadio[p][1] < 800) then
				return
			end
			local nick = _getPlayerNameR( p )
			--
			if p:getData("Roleplay:faccion_division") ~="" then
				div = "| "..p:getData("Roleplay:faccion_division").." "
			else
				div = ""
			end
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				outputDebugString("[OOC] "..(p:getData("Roleplay:faccion_rango") or "").." "..div..""..nick..": "..msg.."", 0, 255, 255, 255)
				for i, v in ipairs(Element.getAllByType("player")) do
					if v:getData("Roleplay:faccion") == p:getData("Roleplay:faccion") and v:getData("Roleplay:faccion_division") == p:getData("Roleplay:faccion_division") then
						-- [OOC | ..name | ..division(SOLO SI TIENE)]: [Texto]
						v:outputChat("#FFFFFF[OOC] #243A6E"..(p:getData("Roleplay:faccion_rango") or "").." "..div..""..nick..":#FFFFFF "..msg.."", 255, 255, 255, true)
						-- antispam
					end
				end
			end
			if (not antiSpamOOCRadio[p]) then
				antiSpamOOCRadio[p] = {}
			end
			antiSpamOOCRadio[p][1] = getTickCount()
		end
	end
end
addCommandHandler({"f"}, ooc_radio_polices)

local antiSpamDepartament = {}

function radio_derpatament(p, cmd, ...)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) or getPlayerFaction(p, "Medico") or getPlayerDivision( p, "S.W.A.T." ) or getPlayerDivision( p, "DIC" ) or getPlayerFaction( p, "Medico" ) or getPlayerFaction( p, "Bombero" ) or getPlayerFaction( p, "Mecanico" ) or getPlayerFaction( p, "Gobierno" )  then
			local tick = getTickCount()
			if (antiSpamDepartament[p] and antiSpamDepartament[p][1] and tick - antiSpamDepartament[p][1] < 800) then
				return
			end
			local nick = _getPlayerNameR( p )
			--
			if getPlayerFaction(p, "Policia") then
				rank = "LSPD"
			elseif getPlayerFaction(p, "Medico") then
				rank = "LSRD"
			elseif getPlayerFaction(p, "Bombero") then
				rank = "LSFD"
			elseif getPlayerFaction(p, "Gobierno") then
				rank = "LSJD"
			elseif getPlayerFaction(p, "Mecanico") then
				rank = "Mecanico"
			end
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				for i, v in ipairs(Element.getAllByType("player")) do
					if getPlayerFaction(v, "Policia") or getPlayerFaction(v, "Medico") or getPlayerDivision( v, "S.W.A.T." ) or getPlayerDivision( v, "DIC" ) or getPlayerFaction( v, "Medico" ) or getPlayerFaction( v, "Bombero" ) or getPlayerFaction( v, "Mecanico" )  or getPlayerFaction( v, "Gobierno" ) then
						-- [Departamental | ..faccion | ..name]: [Texto]
						setTimer(function(v)
							if isElement(v) then
							v:outputChat("[Departamental "..rank.."] "..nick.." dice: #FFFFFF"..msg.."", 0, 98, 134, true)
						end
						end, 800, 1, v)
						-- antispam
						if (not antiSpamRadio[v]) then
							antiSpamRadio[v] = {}
						end
					end
				end
			end
		end
	end
end
addCommandHandler({"d"}, radio_derpatament)

--
local antiSpam  = {} 

function megafono_policia ( source, cmd, ... )
	if not notIsGuest( source ) then
		local tick = getTickCount()
		if (antiSpam[source] and antiSpam[source][1] and tick - antiSpam[source][1] < 500) then
			return
		end
		if getPlayerFaction( source, "Policia" ) or getPlayerDivision( source, "S.W.A.T." ) or getPlayerDivision( source, "DIC" ) or getPlayerFaction( source, "Medico" ) then
			if inPlayerVehiclePolice(source) then
				local msg = table.concat({...}, " ")
				if msg ~="" and msg ~=" " then
					local vehicle = source:getOccupiedVehicle()
					local seat = source:getOccupiedVehicleSeat()
					if seat == 0 or seat == 1 then
						local pos = Vector3(vehicle:getPosition())
						local nick = _getPlayerNameR( source )
						local x, y, z = pos.x, pos.y, pos.z
						chatCol = ColShape.Sphere(x, y, z, 90)
						nearPlayers = chatCol:getElementsWithin("player") 
						outputDebugString("[MEGÁFONO] "..nick..": "..msg.."", 0, 215, 255, 0)
						for _,v in ipairs(nearPlayers) do
							v:outputChat("[MEGÁFONO] "..nick..": #FFFFFF"..msg.."", 255, 255, 0, true)
						end
						if isElement( chatCol ) then
							destroyElement( chatCol )
						end
					end
				end
			end
		end
		if (not antiSpam[source]) then
			antiSpam[source] = {}
		end
		antiSpam[source][1] = getTickCount()
	end
end
addCommandHandler("meg", megafono_policia)

local valoresRefuerzos = {}
local antiSpamRef = {}
function notIsGuest(player)
    local account = player:getAccount()
    return not account or isGuestAccount(account)
end

addCommandHandler("ref", function(p)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) then
			if inPlayerVehiclePolice(p) then
				local tick = getTickCount()
				if (antiSpamRef[p] and antiSpamRef[p][1] and tick - antiSpamRef[p][1] < 2000) then
					return
				end
					local nick = _getPlayerNameR( p )
					if valoresRefuerzos[p] == true then
						valoresRefuerzos[p] = nil
						for i, v in ipairs(Element.getAllByType("player")) do
							if getPlayerFaction(v, "Policia") then
								v:triggerEvent("Police:destroy_blip", v, (p:getOccupiedVehicle() or nil))
								v:outputChat("#FF6C6C* ".. nick.." ya no pide refuerzos.", 255, 255, 255, true)
							end
						end
					else
						--
						valoresRefuerzos[p] = true
						--
						for i, v in ipairs(Element.getAllByType("player")) do
							if getPlayerFaction(v, "Policia") then
								--
								v:triggerEvent("Police:create_blip", v, (p:getOccupiedVehicle() or nil))
								--
								v:outputChat("#FF6C6C* ".. nick.." pide refuerzos utilizando su radio.", 255, 255, 255, true)
								v:outputChat("#A50101El "..(p:getData("Roleplay:faccion_rango") or "Cadete").." ".. nick.." necesita refuerzos, se le ha indicado su posición.", 255, 255, 255, true)
							end
						end
					end
				if (not antiSpamRef[p]) then
					antiSpamRef[p] = {}
				end
				antiSpamRef[p][1] = getTickCount()
			else
				p:outputChat("#ff3d3d* Debes estar en un vehiculo para poder utilizar la referencia.", 255, 255, 255, true)
				
			end
		else
			
		end
	end
end)

addCommandHandler("limpref", function(p)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) then
			p:outputChat("#ff3d3d* Has eliminado todo las referencias del mapa.", 50, 150, 50, true)
			for _, vehs in ipairs(Element.getAllByType("vehicle")) do
				p:triggerEvent("Police:destroy_blip", p, (vehs or nil))
				if valoresRefuerzos[p] == true then
					valoresRefuerzos[p] = nil
				end
			end
		end
	end
end)

----
local _Rangos = {
	["Policia"]={
		'Cadete'
		,'Oficial I'
		,'Oficial II'
		,'Oficial III'
		,'Sargento I'
		,'Sargento II'
		,'General'
		,'Teniente'
	},
	["Medico"]={
		'Aspirante'
		,'Paramedico'
		,'Medico'
		,'Sub Director'
	},
	["Mecanico"]={
		'Aprendiz'
		,'Mecanico'
		,'Junior'
	},
	["Gobierno"]={
		'Guarura'
		,'Guardia'
		,'Encargado de Seguridad'
		,'Asistente'
		,'Abogado Privado'
		,'Abogado Estatal'
		,'Maestro de Derecho'
		,'Fiscal'
	},
}

function _Cmd_Rangos(jug, cmd, name)
	if not notIsGuest( jug ) then
		if jug:getData("Roleplay:faccion") ~= "" then
			if jug:getData("Roleplay:faccion_lider") == "Si" then
				local who = getPlayerFromPartialName( name )
				if who then
					local old_rank = who:getData("Roleplay:faccion_rango")
					if old_rank then
						local ID = table.find(_Rangos[jug:getData("Roleplay:faccion")], old_rank)
						if ID then
							if cmd == 'subirrango' then
								ID = ID + 1
							elseif cmd == 'bajarrango' then
								ID = ID - 1
							end
							if _Rangos[jug:getData("Roleplay:faccion")][ID] then
								if who then
									update("UPDATE Facciones SET Rango = ?  WHERE Nombre = ?", _Rangos[jug:getData("Roleplay:faccion")][ID], AccountName(who))
									who:setData("Roleplay:faccion_rango", _Rangos[jug:getData("Roleplay:faccion")][ID])

									who_sms = (cmd == 'subirrango' and jug.name..' te ascendió a '.._Rangos[jug:getData("Roleplay:faccion")][ID]) or (cmd == 'bajarrango' and jug.name..' te a bajado de puesto a '.._Rangos[jug:getData("Roleplay:faccion")][ID])
									who:outputChat(who_sms,(cmd == 'subirrango' and 0 or 255),(cmd == 'subirrango' and 255 or 0),0)

									jug_sms = (cmd == 'subirrango' and "Ascendiste a "..name) or (cmd == 'bajarrango' and "Bajaste de puesto a "..name)
									jug:outputChat(jug_sms,(cmd == 'subirrango' and 0 or 255),(cmd == 'subirrango' and 255 or 0),0)
								end
							end
						end
					else
						jug:outputChat("Syntax: /subirrango [ID]", 255, 255, 255)
						jug:outputChat("Syntax: /bajarrango [ID]", 255, 255, 255)
					end
				end
			end
		end
	end
end
addCommandHandler('subirrango',_Cmd_Rangos)
addCommandHandler('bajarrango',_Cmd_Rangos)

function table.find(t, value)
    for k,v in pairs(t) do
        if v == value then
            return k,v
        end
    end
    return false
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
----------------------------------------- despedir 
addCommandHandler("despedir", function(source, cmd, who)
	if not notIsGuest( source ) then
		if source:getData( "Roleplay:faccion" ) ~="" then
			if source:getData("Roleplay:faccion_lider") == "Si" then
				local player = getPlayerFromPartialName(who)
				if (player) then
					if not getPlayerLeader(player) then
						local s = query("SELECT * From `Facciones` where Nombre = ?", tostring(AccountName(player)))
						if ( type( s ) == "table" and #s == 0 ) or not s then
							source:outputChat("* El jugador: "..player:getName().." no se encuentra en la facción", 150, 50, 50, true)
						else
							source:outputChat("* El jugador: "..player:getName().." ha sido despedido", 50, 150, 50, true)
							delete("DELETE FROM Facciones WHERE Nombre=?", AccountName(player))
							player:setData("Roleplay:faccion", "")
							player:setData("Roleplay:faccion_lider", "No")
							player:setData("Roleplay:faccion_rango", "")
							player:setData("Roleplay:faccion_sueldo", 0)
							for i ,v in ipairs(Element.getAllByType("player")) do
								if v:getData("Roleplay:faccion") == source:getData("Roleplay:faccion") then
									v:outputChat("* El jugador: "..player:getName().." ha sido despedido por "..source:getName(), 50, 150, 50, true)
								end
							end
						end
					end
				else
					source:outputChat("Syntax: /despedir [Nombre]", 255, 255, 255, true)
				end
			end
		end
	end
end)
--- Renunciar
addCommandHandler("renunciar", function(source, cmd)
    -- Verifica que el jugador no sea invitado
    if not notIsGuest(source) then
        -- Verifica que el jugador pertenezca a una facción
        if source:getData("Roleplay:faccion") ~= "" then
            local faccionNombre = source:getData("Roleplay:faccion")
            local esLider = source:getData("Roleplay:faccion_lider") == "Si"

            -- Si el jugador es líder de la facción y la facción es "Policia"
            if esLider and faccionNombre == "Policia" then
                -- Actualiza la base de datos para dejar sin líder a la facción
                update("UPDATE `Facciones` SET Lider = NULL WHERE Nombre = ?", "Policia")

                -- Notifica a los jugadores de la facción que ahora está sin líder
                for _, v in ipairs(Element.getAllByType("player")) do
                    if v:getData("Roleplay:faccion") == "Policia" then
                        v:outputChat("* La facción 'Policia' ahora está sin líder porque " .. source:getName() .. " ha renunciado", 255, 100, 100, true)
                    end
                end
            end

            -- Limpia los datos del jugador relacionados con la facción
            source:setData("Roleplay:faccion", "")
            source:setData("Roleplay:faccion_lider", "No")
            source:setData("Roleplay:faccion_rango", "")
            source:setData("Roleplay:faccion_sueldo", 0)
            source:setData("Roleplay:faccion_division", "")
            source:setData("Roleplay:faccion_division_lider", "No")

            -- Mensaje al jugador que usó el comando
            source:outputChat("* Has abandonado la facción '" .. faccionNombre .. "'", 150, 50, 50, true)

            -- Notifica al resto de los miembros de la facción
            for _, v in ipairs(Element.getAllByType("player")) do
                if v:getData("Roleplay:faccion") == faccionNombre then
                    v:outputChat("* El jugador " .. source:getName() .. " ha renunciado a la facción", 150, 50, 50, true)
                end
            end
        else
            source:outputChat("* No perteneces a ninguna facción", 150, 50, 50, true)
        end
    else
        source:outputChat("* No puedes usar este comando como invitado", 150, 50, 50, true)
    end
end)


----------------------------------------- Arrestar jugadores

siguimientos = {}

function esposarJugador(source, cmd, jugador)
	local jugador = getPlayerFromPartialName(jugador)
	if not jugador then
		source:outputChat("* Tienes que colocar el jugador que deseas esposar", 255, 200, 0)
		return
	end
	if source:getData("Roleplay:faccion") ~= "Policia" then
		source:outputChat("* Tienes que ser policia para usar esto", 255, 200, 0)
		return
	end
    if source == jugador then
    	source:outputChat("* No te puedes esposar a ti mismo", 255, 200, 0)
    	return
    end
    local posicion1 = Vector3(source:getPosition())
    local posicion2 = Vector3(jugador:getPosition())
    local x1, y1, z1 = posicion1.x, posicion1.y, posicion1.z
    local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z
    local distancia = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
    if tonumber(distancia) > 2 then
    	source:outputChat("* Tienes que estar mas cerca del jugador que deseas esposar", 255, 200, 0)
    	return
    end
    siguimientos[jugador] = source
    dogFollow(jugador)
	toggleControl(jugador, "aim_weapon", false)
	toggleControl(jugador, "next_weapon", false)
	toggleControl(jugador, "previous_weapon", false)
	toggleControl(jugador, "jump", false)
	toggleControl(jugador, "fire", false)
	toggleControl(jugador, "walk", false)
	jugador:setWeaponSlot(0)
	source:outputChat("* Esposaste correctamente a: #FFFFFF"..jugador:getName().."", 255, 200, 0, true)
	jugador:outputChat("* Fuiste esposado por: #FFFFFF"..source:getName().."", 255, 200, 0, true)
end
addCommandHandler("esposar", esposarJugador)

function liberarJugador(source, cmd, jugador)
	local jugador = getPlayerFromPartialName(jugador)
	if not jugador then
		source:outputChat("* Tienes que colocar el jugador que deseas liberar", 255, 200, 0)
		return
	end
	if source:getData("Roleplay:faccion") ~= "Policia" then
		source:outputChat("* Tienes que ser policia para usar esto", 255, 200, 0)
		return
	end
    if source == jugador then
    	source:outputChat("* No te puedes liberar a ti mismo", 255, 200, 0)
    	return
    end
    local posicion1 = Vector3(source:getPosition())
    local posicion2 = Vector3(jugador:getPosition())
    local x1, y1, z1 = posicion1.x, posicion1.y, posicion1.z
    local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z
    local distancia = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
    if tonumber(distancia) > 2 then
    	source:outputChat("* Tienes que estar mas cerca del jugador que deseas liberar", 255, 200, 0)
    	return
    end
    siguimientos[jugador] = nil
	toggleControl(jugador, "aim_weapon", true)
	toggleControl(jugador, "next_weapon", true)
	toggleControl(jugador, "previous_weapon", true)
	toggleControl(jugador, "jump", true)
	toggleControl(jugador, "fire", true)
	toggleControl(jugador, "walk", true)
	jugador:setWeaponSlot(0)
	source:outputChat("* Liberaste correctamente a: #FFFFFF"..jugador:getName().."", 255, 200, 0, true)
	jugador:outputChat("* Fuiste liberado por: #FFFFFF"..source:getName().."", 255, 200, 0, true)
end
addCommandHandler("liberar", liberarJugador)

function dogFollow( theprisoner )
	if siguimientos[theprisoner] == nil then
	else
		if not theprisoner then return end
		policia = siguimientos[theprisoner]
		local copx, copy, copz = getElementPosition ( siguimientos[theprisoner] )
		local prisonerx, prisonery, prisonerz = getElementPosition ( theprisoner )
		copangle = ( 360 - math.deg ( math.atan2 ( ( copx - prisonerx ), ( copy - prisonery ) ) ) ) % 360
		setPedRotation ( theprisoner, copangle )
		local dist = getDistanceBetweenPoints2D ( copx, copy, prisonerx, prisonery )	
		if getElementInterior(siguimientos[theprisoner]) ~= getElementInterior(theprisoner) then setElementInterior(theprisoner, getElementInterior(siguimientos[theprisoner])) end
		if getElementDimension(siguimientos[theprisoner]) ~= getElementDimension(theprisoner) then setElementDimension(theprisoner, getElementDimension(siguimientos[theprisoner])) end
		if dist >= 9 then
			local x,y,z = getElementPosition(siguimientos[theprisoner])
			setElementPosition(theprisoner, x, y, z)
		elseif dist >= 8 then
			setPedAnimation(theprisoner, "ped", "sprint_civi")
		elseif dist >= 5 then
			setPedAnimation(theprisoner, "ped", "run_player")
		elseif dist >= 2 then
			setPedAnimation(theprisoner, "ped", "WALK_player")
		else
			setPedAnimation(theprisoner, false)
		end
		if isPedInVehicle ( policia ) then
			car = getPedOccupiedVehicle ( policia )
			for i = 0, getVehicleMaxPassengers( car ) do
			local p = getVehicleOccupant( car, i )
				if not p and not isVehicleLocked(car) then
					warpPedIntoVehicle ( theprisoner, car, i )
				end
			end
		else
			if isPedInVehicle ( theprisoner ) then
				removePedFromVehicle ( theprisoner )
			end
		end

		local zombify = setTimer ( dogFollow, 750, 1, theprisoner )
	end
end

--Taser

addCommandHandler("taser", function(p)
	if not notIsGuest( p ) then
		if getPlayerFaction( p, "Policia" ) then
			local weaponType = getPedWeapon (p)
			local a = getPlayerName(p)
			if weaponType == 24 then
			p:outputChat("* Has cambiado tu Desert Eagle Por un Taser", 50, 150, 50, true)
			p:setData("TextInfo", {"> "..a.."Cambia su Desert Eagle por un Taser",255, 0, 216})
			setPedWeaponSlot ( p,2 )
			giveWeapon ( p, 23, 5 )
			setTimer(function(p)
				if isElement(p) then
				p:setData("TextInfo", {"",255, 0, 216})
				end
				end, 4000, 1, p)
		else
			if weaponType == 23 then
				p:outputChat("* Has cambiado tu Taser Por una Desert Eagle", 50, 150, 50, true)
				p:setData("TextInfo", {"> "..a.."Cambia su Taser por una Desert Eagle",255, 0, 216})
				setPedWeaponSlot ( p,2 )
				giveWeapon ( p, 24, 35 ) 
				setTimer(function(p)
					if isElement(p) then
					p:setData("TextInfo", {"",255, 0, 216})
					end
					end, 4000, 1, p)
			else
	        	p:outputChat("#ff3d3d* No tienes ni una Desert Eagle ni un Taser para poder Cambiar", 50, 150, 50, true)
			end
		end
		end
	end
end)

local cFunc = {}
local cSetting = {}


-- FUNCTIONS --
setWeaponProperty("silenced", "pro", "weapon_range", 45.0)
setWeaponProperty("silenced", "pro", "maximum_clip_ammo", 1)
setWeaponProperty("silenced", "pro", "damage", 50)

setWeaponProperty("silenced", "std", "weapon_range", 45.0)
setWeaponProperty("silenced", "std", "maximum_clip_ammo", 1)
setWeaponProperty("silenced", "std", "damage", 50)

setWeaponProperty("silenced", "poor", "weapon_range", 45.0)
setWeaponProperty("silenced", "poor", "maximum_clip_ammo", 1)
setWeaponProperty("silenced", "poor", "damage", 50)
