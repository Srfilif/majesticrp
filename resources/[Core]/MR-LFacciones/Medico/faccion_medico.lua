hospitals = {
    { 1244.0673828125, 331.4033203125, 19.5546875, 335.01943969727, "Market"}, --Montgomery
    { 2034.498046875, -1405.9306640625, 17.221422195435, 260, "Jefferson"}, -- Blue Berry
}

function findNearestHostpital(thePlayer)
	local nearest = nil
	local min = 999999
	for key,val in pairs(hospitals) do
		if (getElementInterior(thePlayer) ~= 0) then
			local x,y,z = exports.GTIinteriors:getPlayerLastPosition(thePlayer)
			if (x) then
				xx,yy,zz = x,y,z
			else
				xx,yy,zz=getElementPosition(thePlayer)
			end
		else
			xx,yy,zz=getElementPosition(thePlayer)
		end

		local x1=val[1]
		local y1=val[2]
		local z1=val[3]
		local pR=val[4]
		local hN=val[5]
		local dist = getDistanceBetweenPoints2D(xx,yy,x1,y1)
		if dist<min then
			nearest = val
			min = dist
		end
	end
	return nearest[1],nearest[2],nearest[3],nearest[4],nearest[5],nearest[6],nearest[7],nearest[8]
end

addCommandHandler("lidermedico", function(player, cmd, who)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			local thePlayer = getPlayerFromPartialName(who)
			if (thePlayer) then
				if thePlayer:getData("Roleplay:faccion") ~="" then
					player:outputChat(_getPlayerNameR(thePlayer).." se encuentra en una facción debe dejar su facción para que le puedas dar el lider de medico.", 150, 50, 50, true)
				else
					local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", 'Medico', 'Si')
					if ( type( s ) == "table" and #s == 0 ) or not s then
						player:outputChat("* Le acabas de entregar el lider a #FFFFFF".._getPlayerNameR(thePlayer).."", 50, 100, 50, true)
						--
						thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de Medico", 50, 150, 50, true)
						--
						insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", 'Medico', AccountName(thePlayer), 'Director', '0', 'Si', '', 'No')
						--
						thePlayer:setData("Roleplay:faccion", "Medico")
						thePlayer:setData("Roleplay:faccion_lider", "Si")
						thePlayer:setData("Roleplay:faccion_rango", "Director")
						thePlayer:setData("Roleplay:faccion_sueldo", 0)
						thePlayer:setData("Roleplay:faccion_division", "")
						thePlayer:setData("Roleplay:faccion_division_lider", "No")
					else
						player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)
					end
				end
			else
				player:outputChat("Syntax: /lidermedico [ID]", 255, 255, 255, true)
			end
		end
	end
end)

--- Spawn
local JugadorMuerto = {}
local ValoresTablaAsesinato = {}
local antiSpamMensajes = {}

cuerpos = {
	[3]="Torso", 
	[4]="Culo", 
	[5]="Brazo izquierdo", 
	[6]="Brazo derecho", 
	[7]="Pierna izquierda", 
	[8]="Pierna derecha", 
	[9]="Cabeza", 
}

function PlayerDamageText( attacker, weapon, bodypart, loss )
	if ( attacker and attacker:getType() == "player" and bodypart ) then
		if ( source and source:getType() == "player" ) then
			if not source:isDead() then
				local tick = getTickCount()
				if (antiSpamMensajes[source] and antiSpamMensajes[source][1] and tick - antiSpamMensajes[source][1] < 1000) then
					return
				end
				source:outputChat(_getPlayerNameR(attacker).." te acaba de atacar.", 150, 50, 50, true)
				if (not antiSpamMensajes[source]) then
					antiSpamMensajes[source] = {}
				end
				antiSpamMensajes[source][1] = getTickCount()
			end
		end
	end
end
addEventHandler("onPlayerDamage", getRootElement(), PlayerDamageText)



function PlayerKilled(ammo, attacker, weapon, bodypart)
    cancelEvent()
    if not isElement(source) then return end

    -- Verificar si el jugador ya estaba inconsciente
    if JugadorMuerto[source] and JugadorMuerto[source] == true then
        -- El jugador ya estaba inconsciente, ahora muere definitivamente
		source:setData("Muerto", 0)

		source:setData("CanRespawn", 1)
        source:outputChat("#FF0000[☠] #FFFFFFHas muerto, los medicos te han transladado al hospital mas cercano.", 255, 255, 255, true)
		aceptarMuerte(source)
		if attacker then
        source:outputChat("#FF0000[☠] #FFFFFFEl jugador #ff3d3d"..getPlayerName(attacker).." #ffFFffTe ha rematado.", 255, 255, 255, true)
		end
		local pos = Vector3(source:getPosition())
        local x, y, z = pos.x, pos.y, pos.z
        local pos2 = Vector3(source:getRotation())
        local rx, ry, rz = pos2.x, pos2.y, pos2.z
        local int = source:getInterior()
        local dim = source:getDimension()
        source:spawn(x, y, z, rz, source:getModel(), int, dim)
        source:setData("NoDamageKill", true)
		setPedAnimation(source, "crack", "crckidle2", -1, true, false, false)
        source:setHealth(100) -- Configurar salud en 0
        JugadorMuerto[source] = false -- Resetear estado
        source:setData("yo", {"Muerto | No hay regreso", 150, 0, 0})
        return
    end

    -- Si no estaba inconsciente, continuar con el manejo normal
    if (attacker and attacker:getType() == "player" and bodypart) then
        if (source and source:getType() == "player") then
            if bodypart == 9 then -- Verificar si el disparo fue a la cabeza
				cancelEvent()
				source:setData("Muerto", 1)

                source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
                source:outputChat("#FF0000[☠] #FFFFFFEl jugador #ffff3d".._getPlayerNameR(attacker).." #ffFFffte ha matado con un disparo a la cabeza.", 255, 255, 255, true)
                JugadorMuerto[source] = false
                local pos = Vector3(source:getPosition())
                local x, y, z = pos.x, pos.y, pos.z
                local pos2 = Vector3(source:getRotation())
                local rx, ry, rz = pos2.x, pos2.y, pos2.z
                local int = source:getInterior()
                local dim = source:getDimension()
				source:setData("NoDamageKill", true)
                source:spawn(x, y, z, rz, source:getModel(), int, dim)
				setPedAnimation(source, "crack", "crckidle2", -1, true, false, false)
				JugadorMuerto[source] = true

                source:setData("yo", {"Muerto | Asesinado por "..getWeaponNameFromID(weapon).." con un disparo a la cabeza", 150, 0, 0})
                ValoresTablaAsesinato[source] = attacker
				source:outputChat("#000000[☠]#ff3d3d Estás Muerto y no hay #ffffffparamédicos #ff3d3ddisponibles para vos.", 255, 255, 255, true)
				source:outputChat("#000000[☠]#ff3d3d Luego de pasados #ffffff90 segundos #ff3d3dpodrás elegir reaparecer.", 255, 255, 255, true)
				source:outputChat("#000000[☠]#ffffff Podes avisar de tu muerte a las autoridades con el comando #00ff00/avisarmuerte", 255, 255, 255, true)
				setTimer(function() 
					if source:getData("CanRespawn") then 
                    source:outputChat("#000000[☠]#ffffff Usa el comando #ff3d3d/aceptarmuerte #ffffffpara respawnear.", 255, 255, 255, true)
                    source:setData("CanRespawn", 1)
					end
                end, 5000, 1)
            else
				source:setData("Muerto", 1)

                source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
                source:outputChat("#FFFFFF".._getPlayerNameR(attacker).." #963200te acaba de dejar inconsciente.", 255, 255, 255, true)
                JugadorMuerto[source] = true
				source:setData("Muerto", 1)

                setTimer(function(source, weapon, bodypart, attacker)
                    if isElement(source) then
                        local pos = Vector3(source:getPosition())
                        local x, y, z = pos.x, pos.y, pos.z
                        local pos2 = Vector3(source:getRotation())
                        local rx, ry, rz = pos2.x, pos2.y, pos2.z
                        local int = source:getInterior()
                        local dim = source:getDimension()
                        source:spawn(x, y, z, rz, source:getModel(), int, dim)
                      --  source:setData("NoDamageKill", true)
                        setPedAnimation(source, "crack", "crckidle2", -1, true, false, false)
                        JugadorMuerto[source] = true
                        source:outputChat("#000000[☠]#ff3d3d Estás inconsciente y no hay #ffffffparamédicos #ff3d3ddisponibles para vos.", 255, 255, 255, true)
                        source:outputChat("#000000[☠]#ff3d3d Luego de pasados #ffffff90 segundos #ff3d3dpodrás elegir morir.", 255, 255, 255, true)
                        source:outputChat("#000000[☠]#ffffff Podes avisar de tu muerte a las autoridades con el comando #00ff00/avisarmuerte", 255, 255, 255, true)
                        source:setData("yo", {"Inconsciente | Herido por "..getWeaponNameFromID(weapon).." en "..cuerpos[bodypart].."", 150, 50, 0})
                        ValoresTablaAsesinato[source] = attacker
						setTimer(function() 
							if source:getData("CanRespawn") then 
							source:outputChat("#000000[☠]#ffffff Usa el comando #ff3d3d/aceptarmuerte #ffffffpara respawnear.", 255, 255, 255, true)
							source:setData("CanRespawn", 1)
							end
						end, 5000, 1)
                    end
                end, 3000, 1, source, weapon, bodypart, attacker)
            end
        end
    else
		source:setData("Muerto", 1)

        source:outputChat("#FF0033[ADVERTENCIA] #FFFF00Si reconnectas en pleno asesinato de tu personaje, serás sancionado.", 150, 50, 50, true)
        JugadorMuerto[source] = false
        setTimer(function(source, weapon, bodypart)
            if isElement(source) then
                local pos = Vector3(source:getPosition())
                local x, y, z = pos.x, pos.y, pos.z
                local pos2 = Vector3(source:getRotation())
                local rx, ry, rz = pos2.x, pos2.y, pos2.z
                local int = source:getInterior()
                local dim = source:getDimension()
                source:spawn(x, y, z, rz, source:getModel(), int, dim)
                setPedAnimation(source, "crack", "crckidle2", -1, true, false, false)
                source:setHealth(100)
                source:setData("CanRespawn", 0)
              --  source:setData("NoDamageKill", true)
                JugadorMuerto[source] = true
                source:outputChat("#000000[☠]#ff3d3d Estás inconsciente y no hay #ffffffparamédicos #ff3d3ddisponibles para vos.", 255, 255, 255, true)
                source:outputChat("#000000[☠]#ff3d3d Luego de pasados #ffffff90 segundos #ff3d3dpodrás elegir morir.", 255, 255, 255, true)
                source:outputChat("#000000[☠]#ffffff Podes avisar de tu muerte a las autoridades con el comando #00ff00/avisarmuerte", 255, 255, 255, true)
                source:setData("yo", {"Inconsciente | Herido por caída", 150, 50, 0})
                ValoresTablaAsesinato[source] = source
                setTimer(function() 
					if source:getData("CanRespawn") then 
                    source:outputChat("#000000[☠]#ffffff Usa el comando #ff3d3d/aceptarmuerte #ffffffpara respawnear.", 255, 255, 255, true)
                    source:setData("CanRespawn", 1)
					end
                end, 5000, 1)
            end
        end, 3000, 1, source, weapon, bodypart)
    end
end
addEventHandler("onPlayerWasted", getRootElement(), PlayerKilled)



function aceptarMuerte(player)
	local x, y, z, rot = findNearestHostpital(player)
    local weaponType = getPedWeapon ( player )
	if not notIsGuest(player) then
		if JugadorMuerto[player] == true then
			local cresspawn = getElementData ( player, "CanRespawn" )
		    if cresspawn == 1 then
			  if weaponType == 0 then
			
			player:outputChat("#ffbcb8[HOSPITAL]#ffffff Se te descontaron #00ff00$750 dolares #ffffffPor los tratos realizados en el hospital", 150, 50, 50, true)
		   --	player:outputChat("#ffbcb8[HOSPITAL]#ff3d3d ", 150, 50, 50, true)  
			JugadorMuerto[player] = nil
			source:setData("Muerto", 0)

			setTimer(function(source)
			     if isElement(source) then
				--setControlState( source, "fire", true )
				source:spawn(x, y, z, rot, source:getModel(), 0, 0, nil)
				source:setData("CanRespawn", 0)
				source:setData("yo", {"", 150, 0, 0})
				source:setHealth(100)
				source:setFrozen(false)
				source:setData("NoDamageKill", nil)
			--	source:setData("CanRespawn", 0)
				setPedAnimation(source)
				takeAllWeapons(source)
			end
			end, 120, 1, player)
			
		else
				takeAllWeapons(source)
				player:outputChat("#ffbcb8[HOSPITAL]#ff3d3dAdemas se te confiscaron todos los objetos peligrosos", 150, 50, 50, true)
		end
			else
			 
			local remaining, executesRemaining, timeInterval = getTimerDetails(timer)
			local segundos = math.floor(remaining / 1000)
             player:outputChat("#000000[☠]#ffffff Debes esperar #ff3d3d"..segundos.." segundo(s)#ffffff antes de poder respawnear", 150, 50, 50, true)
			
			
			end
			
			
			
			
			
		end
	end
end

addCommandHandler("aceptarmuerte", aceptarMuerte)
-- curar jugadores
function curar_medico( source, cmd, jugador )
	if not notIsGuest( source ) then
		if getPlayerFaction( source, "Medico" ) or permisosTotal[getACLFromPlayer(source)] == true then
			local player = getPlayerFromPartialName(jugador)
			if ( player ) then
				if ( not JugadorMuerto[player] == true) then
					setPedAnimation(source)
					player:setHealth(player:getHealth()+20)
					player:setFrozen(false)
					MensajeRoleplay(source, "le ah dado una inyección a ".._getPlayerNameR(player))
				else
					source:outputChat("* El jugador: ".._getPlayerNameR(player).." esta muerto, usa el comando /reanimar [Nombre_Apellido o ID].", 150, 0, 0)
				end
			else
				source:outputChat("Syntax: /curar [Nombre]", 255, 255, 255, true)
			end
		end
	else
		source:outputChat("* No puedes usar este comando", 150, 50, 50)
	end
end
addCommandHandler("curar", curar_medico)



function revivirJugador(player, cmd, who)
    if not notIsGuest(player) then
        -- Verificar si el jugador tiene permisos para usar el comando
        if permisosTotal[getACLFromPlayer(player)] == true then
            local targetPlayer = nil
            local input = tostring(who)

            -- Verificar si la entrada es un ID o un nombre completo
            if tonumber(input) then
                targetPlayer = getPlayerNameFromID(tonumber(input), player) -- Buscar por ID
            else
                targetPlayer = getPlayerFromPartialName(who) -- Buscar por nombre parcial
            end


            -- Validar si se encontró al jugador
            if targetPlayer and isElement(targetPlayer) then
                if JugadorMuerto[targetPlayer] == true then
                    -- Obtener la posición y otros datos del jugador
                    local pos = Vector3(targetPlayer:getPosition())
                    local rot = Vector3(targetPlayer:getRotation())
                    local int = targetPlayer:getInterior()
                    local dim = targetPlayer:getDimension()

                    -- Revivir al jugador
                    JugadorMuerto[targetPlayer] = nil
                    targetPlayer:spawn(pos.x, pos.y, pos.z, rot.z, targetPlayer:getModel(), int, dim, nil)
                    targetPlayer:setFrozen(false)
                    targetPlayer:setData("NoDamageKill", nil)
                    setPedAnimation(targetPlayer)
                    targetPlayer:setHealth(100)
                    targetPlayer:setData("Muerto", 0)
                    targetPlayer:setData("CanRespawn", nil)

                    -- Sacar al jugador de cualquier vehículo si está en uno
                    if targetPlayer:getOccupiedVehicle() then
                        targetPlayer:removeFromVehicle()
                    end

                    -- Notificaciones y registros
                    targetPlayer:setData("yo", {"", 150, 0, 0})
                    outputDebugString("* " .. _getPlayerNameR(player) .. " revivió al jugador: " .. _getPlayerNameR(targetPlayer), 0, 0, 150, 0)
                    player:outputChat("* Acabas de revivir al jugador: " .. _getPlayerNameR(targetPlayer), 50, 150, 0)
                    targetPlayer:outputChat("* " .. _getPlayerNameR(player) .. " te acaba de revivir.", 50, 150, 0)
                else
                    -- Si el jugador no está muerto
                    player:outputChat("#ff3d3d* El jugador: " .. _getPlayerNameR(targetPlayer) .. " no está muerto.", 150, 0, 0,true)
                end
            else
                -- Si no se encuentra al jugador
                player:outputChat("#ff3d3d* No se pudo encontrar al jugador", 150, 0, 0,true)
            end
        else
            -- Si el jugador no tiene permisos
            player:outputChat("#ff3d3d* No tienes permisos para usar este comando.", 150, 0, 0,true)
        end
    end
end
addCommandHandler("revivir", revivirJugador)

-- Tabla para almacenar las emergencias activas
local emergencias = {}
local emergenciaID = 0 -- ID único para cada emergencia

-- Comando /avisarmuerte para registrar una emergencia
function avisarMuerteCommand(player)
    -- Obtener la posición del jugador
	if player:getData("Muerto") == 0 then
		outputChatBox("#ff3d3d* No puedes avisar una emergencia si no estás muerto.", player, 255, 0, 0, true)
		return
	end
    local x, y, z = getElementPosition(player)
    local zoneName = getZoneName(x, y, z)

    -- Generar un nuevo ID único para la emergencia
    emergenciaID = emergenciaID + 1

    -- Registrar la emergencia en la tabla
    emergencias[emergenciaID] = {
        id = emergenciaID,
        x = x,
        y = y,
        z = z,
        zone = zoneName,
        player = getPlayerName(player)
    }

    -- Notificar al jugador que la emergencia fue registrada
    outputChatBox("#ff1919[EMERGENCIAS]#ffFFff ¡Has aviso al equipo de emergencias, pronto llegaran!.", player, 255, 255, 0,true)

    -- Notificar a los médicos conectados
	local foundMedics = false

    local message = string.format("#ff1919[EMERGENCIAS]#ffFFffNueva emergencia en %s (ID: %d, Solicitante: %s)", zoneName, emergenciaID, getPlayerName(player))
    for _, medic in ipairs(getElementsByType("player")) do
        if getPlayerFaction(medic, "Medico") then
            outputChatBox(message, medic, 255, 0, 0,true)
			foundMedics = true

        end
    end
	if not foundMedics then
        outputChatBox("#ff3d3d* No hay médicos conectados para atender la solicitud.", player, 255, 255, 0,true)
    end
end
addCommandHandler("avisarmuerte", avisarMuerteCommand)

-- Comando /emergencias para listar todas las emergencias activas
function listarEmergenciasCommand(player)
    if next(emergencias) == nil then
        outputChatBox("#ff3d3d* No hay emergencias activas en este momento.", player, 255, 255, 0,true)
        return
    end

    outputChatBox("Lista de emergencias activas:", player, 0, 255, 255)
    for id, emergencia in pairs(emergencias) do
        outputChatBox(string.format("ID: %d | Zona: %s | Solicitante: %s", id, emergencia.zone, emergencia.player), player, 255, 255, 255)
    end
end
addCommandHandler("veremergencias", listarEmergenciasCommand)

-- Comando /iremergencia [ID] para ir a una emergencia
function irEmergenciaCommand(player, _, id)
    id = tonumber(id)
    if not id or not emergencias[id] then
        outputChatBox("ID de emergencia inválido. Usa /emergencias para ver la lista.", player, 255, 0, 0)
        return
    end

    -- Crear un blip en la ubicación de la emergencia
    local emergencia = emergencias[id]
    local blip = createBlip(emergencia.x, emergencia.y, emergencia.z, 41, 2, 255, 0, 0, 255, 0, 5000, player)

    -- Notificar al jugador
    outputChatBox(string.format("Blip creado para la emergencia en %s (ID: %d).", emergencia.zone, id), player, 0, 255, 0)

    -- Eliminar el blip automáticamente después de 60 segundos
    setTimer(function()
        if isElement(blip) then
            destroyElement(blip)
        end
    end, 60000, 1)
end
addCommandHandler("iremergencia", irEmergenciaCommand)



function reanimar_medico ( source, cmd, jugador )
	if not notIsGuest( source ) then
		if getPlayerFaction( source, "Medico" )  then
			local player = getPlayerFromPartialName(jugador)
			if ( player ) then
				-- source
				local posicion = Vector3(source:getPosition()) -- source
				local x2, y2, z2 = posicion.x, posicion.y, posicion.z -- jugador
				-- jugador
				local pos = Vector3(player:getPosition())
				local x, y, z = pos.x, pos.y, pos.z
				local pos2 = Vector3(player:getRotation())
				local rx, ry, rz = pos2.x, pos2.y, pos2.z
				local int = player:getInterior()
				local dim = player:getDimension()
				if getDistanceBetweenPoints3D(x2, y2, z2, x, y, z) < 1.5 then -- 5
					if ( JugadorMuerto[player] == true ) then
						setPedAnimation(source, "MEDIC", "CPR", -1,true, false, false)
						outputDebugString("* ".._getPlayerNameR(source).." revivio al jugador: ".._getPlayerNameR(player).."", 0, 0, 150, 0)
						source:outputChat("* En 5 segundos será revivido el jugador: ".._getPlayerNameR(player).."", 50, 150, 50)
						JugadorMuerto[player] = nil
						setTimer(function(player, source, x, y, z, rz, int, dim) 
							if isElement(player) then
								player:spawn(x, y, z, rz, player:getModel(), int, dim, nil)
								setPedAnimation(source)
								--setControlState( source, "fire", true )
								player:setHealth(10)
								player:setData("yo", {"", 150, 0, 0})
								player:outputChat("* ".._getPlayerNameR(source).." te acaba de revivir.", 50, 150, 50)
								source:outputChat("* Acabas de revivir al jugador: ".._getPlayerNameR(player)..".", 50, 150, 50)
							end
						end, 5000, 1, player, source, x, y, z, rz, int, dim)
						player:setData("NoDamageKill", false)
					else
						source:outputChat("* El jugador: ".._getPlayerNameR(player).." no esta muerto.", 150, 0, 0)
					end
				else
					source:outputChat("* Tienes que estar cerca al jugador.", 150, 0, 0)
				end
			else
				source:outputChat("Syntax: /reanimar [ID]", 255, 255, 255, true)
			end
		end
	else
		source:outputChat("* No puedes usar este comando", 150, 50, 50)
	end
end
addCommandHandler("reanimar", reanimar_medico)

function playerKill()
	if source:getHealth() < 2 then
		killPed(source)
	end
end
addEventHandler("onPlayerLogin", root, playerKill)



-- Define los colshapes, markers y funciones
local OutArea = createColCuboid(2031.72265625, -1442.625, 16.184511184692, 10, 10, 5)
local InMarket = createMarker(1402.0556640625, 1.1484375, 1000.9146118164 -1, "cylinder", 2.5, 255, 255, 0, 0)
setElementInterior(InMarket,1)
local InArea = createColCuboid(1396.94921875, -3.2890625, 1000.9166259766 -1, 10, 10, 5)
local OutMarket = createMarker(2034.009765625, -1438.974609375, 17.412296295166, "cylinder", 2.5, 255, 255, 0, 0)

-- Función para comprobar si el jugador está dentro del OutArea
function estaEnOutArea(player)
    local x, y, z = getElementPosition(player)
    return isElementWithinColShape(player, OutArea)
end

-- Función para comprobar si el jugador está dentro del InArea
function estaEnInArea(player)
    local x, y, z = getElementPosition(player)
    return isElementWithinColShape(player, InArea)
end

-- Comando /garaje para teletransportar al jugador
addCommandHandler("garaje", function(player)
local theVehicle = getPedOccupiedVehicle ( player )
    if estaEnOutArea(player) then
        if estaEnInArea(player) then
            outputChatBox("¡Ya estás en el otro garaje!", player, 255, 0, 0)
        else
            setElementPosition(theVehicle, 1402.572265625, 1.037109375, 1001.0577392578 + 1)
		setElementInterior ( theVehicle, 1 )
				setElementInterior ( player, 1 )
				setElementRotation(theVehicle,0,0,180)

            outputChatBox("Te has teletransportado al garaje interior.", player, 0, 255, 0)
        end
    elseif estaEnInArea(player) then
        setElementPosition(theVehicle, 2034.009765625, -1438.974609375, 17.412296295166 + 1)
		setElementInterior ( theVehicle, 0 )
					setElementInterior ( player, 0)
					setElementRotation(theVehicle,0,0,90)
        outputChatBox("Te has teletransportado al garaje exterior.", player, 0, 255, 0)
    else
        outputChatBox("No estás en ninguno de los garajes.", player, 255, 0, 0)
    end
end)

local Barrier1 = createObject(3578, 1997.3 , -1445.4 +1.5, 11.8 +1 )
local Barrier2 = createObject(3578, 2003.2 +1, -1450.7, 11.78 +1)
setElementRotation(Barrier1,0,0,90)




local marker = createMarker( 1996.908203125, -1451.330078125, 13.5546875, "cylinder", 16, 0, 0, 0, 0) 
  
function moveGate(thePlayer) 
   if getPlayerFaction( thePlayer, "Medico" ) or permisosTotal[getACLFromPlayer(thePlayer)] == true then
          moveObject(Barrier2, 1000, 2003.2 , -1450.7, 11.78) 
		  moveObject(Barrier1, 1000, 1997.3 , -1445.4, 11.8) 
		  
     end 
end 
addEventHandler("onMarkerHit", marker, moveGate) 
  
function move_back_gate() 
     moveObject(Barrier2, 1000,  2003.2 +1, -1450.7, 11.78 +1) 
	 moveObject(Barrier1, 1000, 1997.3 , -1445.4 +1.5, 11.8 +1) 
end 
addEventHandler("onMarkerLeave", marker, move_back_gate) 

----
---

local Barrier3 = createObject(3578, 2101.2744140625, -1447.890625 +2.1, 23.5 )
setElementRotation(Barrier3,0,0,90)


local marker2 = createMarker(  2102.669921875, -1447.890625, 24, "cylinder", 8, 0, 0, 0, 0) 
  
function moveGate2(thePlayer) 
   if getPlayerFaction( thePlayer, "Medico" ) or permisosTotal[getACLFromPlayer(thePlayer)] == true then
          moveObject(Barrier3, 1000, 2101.2744140625, -1447.890625 +2.1, 23.5 -1.4) 
		  
		  
     end 
end 
addEventHandler("onMarkerHit", marker2, moveGate2) 
  
function move_back_gate2() 
     moveObject(Barrier3, 1000,  2101.2744140625, -1447.890625 +2.1, 23.5) 
	 
end 
addEventHandler("onMarkerLeave", marker2, move_back_gate2) 


function getPlayerNameFromID(theID, theElement)
    if isElement(theElement) and getElementType(theElement) == "player" and tonumber(theID) then
        for _, v in ipairs(getElementsByType("player")) do
            if getElementData(v, "ID") == getElementData(theElement, "ID") then
                return v -- Devuelve el elemento del jugador
            end
        end
        iprint("Player not found")
    end
    return nil
end