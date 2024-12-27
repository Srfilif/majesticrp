loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

loadstring(exports["[LS]NewData"]:getMyCode())()
import('*'):init('[LS]NewData')

permisos = {
	["Administrador"]=true,
	["SuperModerador"]=true,
	["Moderador"]=true,
}

addEventHandler("onPlayerLogin", getRootElement(), function()
	if permisos[getACLFromPlayer(source)] == true then
		source:setData("Admin:Disponible", true)
	end
end)

--- STAFFS
function anuncio_staff( source, cmd, ... )
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			local msg = table.concat({...}, " ")
			if msg ~="" and msg ~=" " then
				local s = trunklateText( source, msg )
				for i, v in ipairs(Element.getAllByType("player")) do
					v:outputChat(_getPlayerNameR(source)..": #FFFFFF"..s, 20, 150, 20, true)
				end
			else
				source:outputChat("Syntax: /an [Mensaje]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("an", anuncio_staff)

function cuentas_player(source, cmd, who)
	if not notIsGuest( source ) then
		if permisos[getACLFromPlayer(source)] == true then
			if tonumber(who) then
				local player = getPlayerFromPartialNameID(who)
				if (player) then
					if player ~= source then
						local serial = player:getSerial()
						local accs = query("SELECT * FROM `Registros` where Serial=?", tostring(serial))
						if not ( type( accs ) == "table" and #accs == 0 ) or not accs then
							source:outputChat("¡ Todas las cuentas registradas de: "..player:getName().." !", 150, 50, 50, true)
							for _, v in ipairs(accs) do
								source:outputChat("Nombre de cuenta: #00FF00"..v.Cuenta, 80, 150, 80, true)
								source:outputChat("Fecha de la creación: #00FF00"..v.Fecha, 80, 150, 80, true)
								source:outputChat("---------------------", 80, 150, 80, true)
							end
						end
					end
				else
					source:outputChat("Syntax: /cuentas [ID]", 255, 255, 255, true)
				end
			else
				local player = getPlayerFromPartialName(who)
				if (player) then
					if player ~= source then
						local serial = player:getSerial()
						local accs = query("SELECT * FROM `Registros` where Serial=?", tostring(serial))
						if not ( type( accs ) == "table" and #accs == 0 ) or not accs then
							source:outputChat("¡ Todas las cuentas registradas de: "..player:getName().." !", 150, 50, 50, true)
							for _, v in ipairs(accs) do
								source:outputChat("Nombre de cuenta: #00FF00"..v.Cuenta, 80, 150, 80, true)
								source:outputChat("Fecha de la creación: #00FF00"..v.Fecha, 80, 150, 80, true)
								source:outputChat("---------------------", 80, 150, 80, true)
							end
						end
					end
				else
					source:outputChat("Syntax: /cuentas [Nombre]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("cuentas", cuentas_player)

function QuitarArmasP(player, cmd, who)
	if not notIsGuest(player) then
		if getACLFromPlayer(player) == "Administrador" or getACLFromPlayer(player) == "SuperModerador" then
			if tonumber(who) then
				local thePlayer = getPlayerFromPartialNameID(who)
				if (thePlayer) then
					outputDebugString(player:getName().. " le quito sus armas al jugador "..thePlayer:getName(), 0, 0, 150, 0)
					player:outputChat("Le acabas de quitar las armas al jugador: #00FF00"..thePlayer:getName(), 255, 255, 255, true)
					thePlayer:outputChat("El administrador "..player:getName().." te ha quitado todas tus armas", 150, 50, 50, true)
					takeAllWeapons(thePlayer)
				else
					player:outputChat("Syntax: /quitararmas [ID]", 255, 255, 255, true)
				end
			else
				local thePlayer = getPlayerFromPartialName(who)
				if (thePlayer) then
					outputDebugString(player:getName().. " le quito sus armas al jugador "..thePlayer:getName(), 0, 0, 150, 0)
					player:outputChat("Le acabas de quitar las armas al jugador: #00FF00 ", 255, 255, 255, true)
					thePlayer:outputChat("El administrador "..player:getName().." te ha quitado todas tus armas", 150, 50, 50, true)
					takeAllWeapons(thePlayer)
				else
					player:outputChat("Syntax: /quitararmas [ID]", 255, 255, 255, true)
				end
			end
		end
	end
end
addCommandHandler("quitararmas", QuitarArmasP)

function warpearse_jugador( source, cmd, jugador )
	if permisos[getACLFromPlayer(source)] == true then
		if tonumber( jugador ) then
			local player = getPlayerFromPartialNameID(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(player:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = player:getDimension()
					local int = player:getInterior()
					outputDebugString("* "..source:getName().." se dio warp al jugador: "..player:getName().."", 0, 0, 150, 0)
					fadeCamera(source, false)
					if source:isInVehicle() then
						source:removeFromVehicle(source:getOccupiedVehicle())
					end
					setTimer(fadeCamera, 1000, 1, source, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Te acabas de dar warp al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("* "..source:getName().." se dio warp a ti", 0, 150, 0)
						source:setInterior(int)
						source:setPosition(x, y, z)
						source:setDimension(dim)
					end
					end, 1000, 1, source, x, y, z+2, int, dim, player)
				end
			else
				source:outputChat("Syntax: /ir [ID]", 255, 255, 255, true)
			end
		else
			local player = getPlayerFromPartialName(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(player:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = player:getDimension()
					local int = player:getInterior()
					outputDebugString("* "..source:getName().." se dio warp al jugador: "..player:getName().."", 0, 0, 150, 0)
					fadeCamera(source, false)
					if source:isInVehicle() then
						source:removeFromVehicle(source:getOccupiedVehicle())
					end
					setTimer(fadeCamera, 1000, 1, source, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Te acabas de dar warp al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("* "..source:getName().." se dio warp a ti", 0, 150, 0)
						source:setInterior(int)
						source:setPosition(x, y, z)
						source:setDimension(dim)
					end
					end, 1000, 1, source, x, y, z+2, int, dim, player)
				end
			else
				source:outputChat("Syntax: /ir [Nombre]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("ir", warpearse_jugador)

function warp_jugador( source, cmd, jugador )
	if permisos[getACLFromPlayer(source)] == true then
		if tonumber( jugador ) then
			local player = getPlayerFromPartialNameID(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(source:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = source:getDimension()
					local int = source:getInterior()
					outputDebugString("* "..source:getName().." le dio warp al jugador: #00FF00"..player:getName().."", 0, 0, 150, 0)
					fadeCamera(player, false)
					if player:isInVehicle() then
						player:removeFromVehicle(player:getOccupiedVehicle())
					end
					setTimer(fadeCamera, 1000, 1, player, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Le acabas de dar warp al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("* "..source:getName().." te dio warp hacia el", 0, 150, 0)
						player:setInterior(int)
						player:setPosition(x, y, z+2)
						player:setDimension(dim)
					end
					end, 1000, 1, source, x, y, z, int, dim, player)
				end
			else
				source:outputChat("Syntax: /traer [ID]", 255, 255, 255, true)
			end
		else
			local player = getPlayerFromPartialName(jugador)
			if ( player ) then
				if player ~= source then
					local posicion = Vector3(source:getPosition())
					local x, y, z = posicion.x, posicion.y, posicion.z
					local dim = source:getDimension()
					local int = source:getInterior()
					if player:isInVehicle() then
						player:removeFromVehicle(player:getOccupiedVehicle())
					end
					outputDebugString("* "..source:getName().." le dio warp al jugador: "..player:getName().."", 0, 0, 150, 0)
					fadeCamera(player, false)
					setTimer(fadeCamera, 1000, 1, player, true)
					setTimer(function(source, x, y, z, int, dim, player)
						if isElement(source) or isElement(player) then
						source:outputChat("* Le acabas de dar warp al jugador: #00FF00"..player:getName().."", 255, 255, 255, true)
						player:outputChat("* "..source:getName().." te dio warp hacia el", 0, 150, 0)
						player:setInterior(int)
						player:setPosition(x, y, z+2)
						player:setDimension(dim)
					end
					end, 1000, 1, source, x, y, z, int, dim, player)
				end
			else
				source:outputChat("Syntax: /traer [Nombre]", 255, 255, 255, true)
			end
		end
	end
end
addCommandHandler("traer", warp_jugador)

function trunklateText(thePlayer, text, factor)
    local msg = (tostring(text):gsub("%u", string.lower))
	return (tostring(msg):gsub("^%l", string.upper))
end