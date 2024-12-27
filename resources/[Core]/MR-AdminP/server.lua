function openAdminPanel(source)
	if hasObjectPermissionTo( source, 'general.adminpanel', true ) then
		triggerClientEvent(source, "PoPLife:openAdmin", source)
	end
end
addCommandHandler("adminpanel", openAdminPanel)

addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource() ),
	function ()
		for k, v in ipairs ( getElementsByType ( "player" ) ) do
			bindKey ( v, "O", "down", openAdminPanel )
		end
	end
	)

addEventHandler ( "onPlayerLogin", getRootElement(),
	function ()
		bindKey ( source, "O", "down", openAdminPanel )
	end
	)

addEventHandler ( "onResourceStop", getResourceRootElement ( getThisResource() ),
	function ()
		for k, v in ipairs ( getElementsByType ( "player" ) ) do
			unbindKey ( v, "O", "down", openAdminPanel )
		end
	end
	)

function warpToPlayer(player)
	local cx, cy, cz = getElementPosition(player)
	if (isPedInVehicle(player)) then
		local maxSeats = getVehicleMaxPassengers(getPedOccupiedVehicle(player))
		warpPedIntoVehicle(client, getPedOccupiedVehicle(player), maxSeats)
	end
	local interior, dimension = getElementInterior(player), getElementDimension(player)
	setElementInterior(client, interior)
	setElementDimension(client, dimension)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Te estas warpeando hacia "..getPlayerName(player), client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." se estando dando warp hacia ti", player, 0, 255, 0, true)
	setElementPosition(client, cx+1, cy+1, cz+1)
end
addEvent("PoPLife:warpToPlayer", true)
addEventHandler("PoPLife:warpToPlayer", root, warpToPlayer)

function warpPlayerToMe(player)
	local cx, cy, cz = getElementPosition(client)
	if (isPedInVehicle(client)) then
		local maxSeats = getVehicleMaxPassengers(getPedOccupiedVehicle(player))
		warpPedIntoVehicle(player, getPedOccupiedVehicle(client), maxSeats)
	end
	local interior, dimension = getElementInterior(client), getElementDimension(client)
	setElementInterior(client, interior)
	setElementDimension(client, dimension)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." te esta warpeando hacia el", player, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Trajiste a "..getPlayerName(player).." hacia tu posicion", client, 0, 255, 0, true) 
	setElementPosition(player, cx+1, cy+1, cz+1)
end
addEvent("PoPLife:warpPlayerToMe", true)
addEventHandler("PoPLife:warpPlayerToMe", root, warpPlayerToMe)

function jailPlayer(player, reason, time)
	if isPedInVehicle(player) then
		removePedFromVehicle(player)
	end
	exports["[PoPLife]Prision"]:sendPlayerToPrison(player, time)
	outputChatBox(getPlayerName(client).. " encarcelo a "..getPlayerName(player).. " por ("..reason..") "..time.." minuto(s)", root, 255, 0, 0)
end
addEvent("PoPLife:jailPlayer", true)
addEventHandler("PoPLife:jailPlayer", root, jailPlayer)

function freezePlayer(player)
	if isElementFrozen(player) == false then
		setElementFrozen(player, true)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." te acaba de congelar", player, 255, 0, 0, true)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Congelaste al jugador "..getPlayerName(player).."", client, 255, 255, 0, true)
	elseif isElementFrozen(player) == true then
		setElementFrozen(player, false)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." te acaba de descongelar", player, 0, 255, 0, true)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Descongelaste al jugador "..getPlayerName(player).."", client, 255, 255, 0, true)
	end
end
addEvent("PoPLife:freezePlayer", true)
addEventHandler("PoPLife:freezePlayer", root, freezePlayer)

function slapHealth(player, amount)
	local x, y, z = getElementPosition(player)
	setElementPosition(player, x, y, z+2)
	setElementHealth(player, getElementHealth(player) - amount)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Le quitaste "..amount.."% de vida al jugador "..getPlayerName(player).."", client, 255, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." te quito "..amount.."% de vida", player, 255, 0, 0, true)
end
addEvent("PoPLife:slapPlayer", true)
addEventHandler("PoPLife:slapPlayer", root, slapHealth)

function viewWeapons(player)
	local ps = client
	local p = player
	if isElement(p) then
		t = {}
		local weaponSlots = {0,1,2,3,4,5,6,7,8,9,10,11,12}
		for i, slot in ipairs(weaponSlots) do
			local ammo = getPedTotalAmmo ( p, slot ) 
			if ( getPedWeapon ( p, slot ) ~= 0 ) then
				local weapon = getPedWeapon ( p, slot )
				local ammo = getPedTotalAmmo ( p, slot )
				table.insert(t, {weapon, ammo})     
			end
		end 
		outputChatBox("--------"..getPlayerName(p).." Armas Actuales--------",ps, 0, 255, 0)
		for k, v in pairs(t) do
			if v[1] > 0 then
				outputChatBox(""..getWeaponNameFromID(v[1]).." "..v[2].." Bala(s)", ps, 255, 255, 255)
			end
		end
	end
end
addEvent("PoPLife:viewWeapons", true)
addEventHandler("PoPLife:viewWeapons", root, viewWeapons)

function setSkin(player, model)
	setElementModel(player, model)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Cambiaste el modelo del jugador "..getPlayerName(player).." a la id: "..model.."", client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Tu modelo fue cambiado por "..getPlayerName(client).." a la id: "..model.."", player, 0, 255, 0, true)
end
addEvent("PoPLife:setSkin", true)
addEventHandler("PoPLife:setSkin", root, setSkin)

function giveVehicle(player, model)
	local x, y, z = getElementPosition(player)
	local carName = getVehicleModelFromName(model)
	if not carName then
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] El vehiculo con ese nombre no existe", client, 0, 255, 0, true)
		return
	end
	local vehicle = createVehicle(carName, x, y, z)
	warpPedIntoVehicle(player, vehicle, 0)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Creaste el vehiculo "..getVehicleNameFromModel(carName).." para "..getPlayerName(player).."", client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te dio el vehiculo "..getVehicleNameFromModel(carName).."", player, 0, 255, 0, true)
end
addEvent("PoPLife:giveVehicle", true)
addEventHandler("PoPLife:giveVehicle", root, giveVehicle)

function giveMoney(player, model)
	local weaponName = getWeaponIDFromName(model)
	if not weaponName then
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] La arma con ese nombre no existe", client, 0, 255, 0, true)
		return
	end
	giveWeapon(player, weaponName, 1000, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Le diste el arma "..getWeaponNameFromID(weaponName).." al jugador "..getPlayerName(player).." con 1000 balas", client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." te dio el arma "..getWeaponNameFromID(weaponName).." con 1000 balas", player, 0, 255, 0, true)
end
addEvent("PoPLife:giveMoney", true)
addEventHandler("PoPLife:giveMoney", root, giveMoney)

function fixAllVehicles()
	for k, v in ipairs (getElementsByType("vehicle")) do
		local rx, ry, rz = getElementRotation(v)
		fixVehicle(v)
		--local gas = (v:getData("Fuel") or 0)
		setElementData ( v, "Fuel", 100 )

		setElementRotation(v, 0, ry, rz)
	end
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Fixeo todos los vehiculos del server", root, 0, 255, 0, true)
end
addEvent("PoPLife:repararTodosLosVehiculos", true)
addEventHandler("PoPLife:repararTodosLosVehiculos", root, fixAllVehicles)

function destroyAllVehicles()
	for k, v in ipairs (getElementsByType("vehicle")) do
		destroyElement(v)
	end
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Elimino todos los vehiculos del server", root, 0, 255, 0, true)
end
addEvent("PoPLife:destruirTodosLosVehiculos", true)
addEventHandler("PoPLife:destruirTodosLosVehiculos", root, destroyAllVehicles)

function matarJugador(player)
	killPed(player)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Mataste al jugador "..getPlayerName(player).."", client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te acaba de matar", player, 0, 255, 0, true) 
end
addEvent("PoPLife:killPlayer", true)
addEventHandler("PoPLife:killPlayer", root, matarJugador)

function darVida(player)
	setElementHealth(player, 200)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Llenaste la vida al maximo al jugador "..getPlayerName(player).."", client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te lleno la vida al maximo", player, 0, 255, 0, true)
end
addEvent("PoPLife:darVida", true)
addEventHandler("PoPLife:darVida", root, darVida)

function darChaleco(player)
	setPedArmor(player, 100)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Llenaste el chaleco al maximo al jugador "..getPlayerName(player).."", client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te lleno el chaleco al maximo", player, 0, 255, 0, true)
end
addEvent("PoPLife:darChaleco", true)
addEventHandler("PoPLife:darChaleco", root, darChaleco)

function prenderFuego(player)
	if isPedOnFire(player) == true then
		setPedOnFire(player, false)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Apagaste el fuego del jugador "..getPlayerName(player).."", client, 0, 255, 0, true)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te apago el fuego", player, 0, 255, 0, true)
	else
		setPedOnFire(player, true)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Pusiste fuego en el jugador "..getPlayerName(player).."", client, 0, 255, 0, true)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te acaba de prender fuego", player, 0, 255, 0, true)
	end
end
addEvent("PoPLife:prenderFuego", true)
addEventHandler("PoPLife:prenderFuego", root, prenderFuego)

function repararVehiculo(player)
	if not isPedInVehicle(player) then
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(player).." No esta dentro de un vehiculo", client, 0, 255, 0, true)
		return
	end
	fixVehicle(getPedOccupiedVehicle(player))
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Fixeaste el vehiculo de "..getPlayerName(player).."", client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te fixeo tu vehiculo", player, 0, 255, 0, true)
end
addEvent("PoPLife:repararVehiculo", true)
addEventHandler("PoPLife:repararVehiculo", root, repararVehiculo)

function destruirVehiculo(player)
	if not isPedInVehicle(player) then
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(player).." No esta dentro de un vehiculo", client, 0, 255, 0, true)
		return
	end
	destroyElement(getPedOccupiedVehicle(player))
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Destruiste el vehiculo del jugador "..getPlayerName(player).."", client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te destruyo tu vehiculo actual", player, 0, 255, 0, true)
end
addEvent("PoPLife:destruirVehiculo", true)
addEventHandler("PoPLife:destruirVehiculo", root, destruirVehiculo)

function explotarVehiculo(player)
	if not isPedInVehicle(player) then
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(player).." No esta dentro de un vehiculo", client, 0, 255, 0, true)
		return
	end
	blowVehicle(getPedOccupiedVehicle(player))
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Explotaste el vehiculo de "..getPlayerName(player).."", client, 0, 255, 0, true)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te exploto tu vehiculo actual", player, 0, 255, 0, true)
end
addEvent("PoPLife:explotarVehiculo", true)
addEventHandler("PoPLife:explotarVehiculo", root, explotarVehiculo)

function congelarVehiculo(player)
	if not isPedInVehicle(player) then
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(player).." No esta dentro de un vehiculo", client, 0, 255, 0, true)
		return
	end
	if isElementFrozen(getPedOccupiedVehicle(player)) == true then
		setElementFrozen(getPedOccupiedVehicle(player), false)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Descongelaste el vehiculo de "..getPlayerName(player).."", client, 0, 255, 0, true)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te descongelo tu vehiculo actual", player, 0, 255, 0, true)
	else
		setElementFrozen(getPedOccupiedVehicle(player), true)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] Congelaste el vehiculo de "..getPlayerName(player).."", client, 0, 255, 0, true)
		outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Te congelo tu vehiculo actual", player, 0, 255, 0, true)
	end
end
addEvent("PoPLife:congelarVehiculo", true)
addEventHandler("PoPLife:congelarVehiculo", root, congelarVehiculo)

function kickearJugador(player, razon)
	kickPlayer(player, client, razon)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(player).." Fue kickeado del servidor por "..getPlayerName(client).."", root, 0, 255, 0, true)
end
addEvent("PoPLife:kickearJugador", true)
addEventHandler("PoPLife:kickearJugador", root, kickearJugador)

function banearJugador(player, razon, tiempo)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(player).." Fue baneado del servidor por "..getPlayerName(client).."", root, 0, 255, 0, true)
	banPlayer(player, true, true, true, client, razon, tiempo*60)
end
addEvent("PoPLife:banearJugador", true)
addEventHandler("PoPLife:banearJugador", root, banearJugador)

function reconectarJugador(player, razon)
	outputChatBox("#FEFEFE[#FF0000Staff#FEFEFE] "..getPlayerName(client).." Forzo el reconnect del jugador "..getPlayerName(player).."", root, 0, 255, 0, true)
	redirectPlayer(player, "144.217.19.110", "22013")
end
addEvent("PoPLife:reconectarJugador", true)
addEventHandler("PoPLife:reconectarJugador", root, reconectarJugador)

function jailearJugador(player, razon, tiempo)
	if isPedInVehicle(player) then
		removePedFromVehicle(player)
	end
	exports["[POPLife]Prision"]:sendPlayerToPrison(player, tiempo)
	outputChatBox(getPlayerName(client).. " encarcelo: "..getPlayerName(player).. " ("..razon..") "..tiempo.." mins", root, 255, 0, 0)
end
addEvent("PoPLife:jailearJugador", true)
addEventHandler("PoPLife:jailearJugador", root, jailearJugador)

addCommandHandler ("pos", 
function (source) 

x,y,z = getElementPosition (source) 
xr,yr,zr = getElementRotation (source) 
Dimension = getElementDimension (source) 
Interior = getElementInterior (source) 

outputChatBox ( "Tu Posicion es: "..x..", " ..y.. ", "..z, source, 0,255,0,true ) 
outputChatBox ( "Tu Rotacion es: "..xr..", " ..yr.. ", "..zr, source, 0,255,0,true ) 
outputChatBox ( "Tu Dimension es: "..Dimension, source, 0,255,0,true ) 
outputChatBox ( "Tu Interior es: "..Interior, source, 0,255,0,true ) 
end
)