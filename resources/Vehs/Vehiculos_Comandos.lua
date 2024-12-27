loadstring(exports.MySQL:getMyCode())()
mysql = exports.MySQL

import('*'):init('MySQL')

import('*'):init('Tiendas')


permisos = {
["Administrador"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Sup.Staff"]=true,
["Sup.Asesor"]=true,
["Sup.Facciones"]=true,
["Sup.Grupos"]=true,
}


loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')


local blips = {
{1987.083984375, -1988.08203125, 13.546875},
{2128.29296875, -1150.1767578125, 24.161502838135},
{547.654296875, -1285.9326171875, 17.248237609863},
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(blips) do
		Blip( v[1], v[2], v[3], 55, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
	end
end)

addCommandHandler("vehiculos", function(player, _)

	if not notIsGuest(player) then

		if isElement(player) then

			local cuenta = AccountName(player)

			local s = databaseQuery("SELECT * FROM Info_Vehicles where Cuenta = ?", cuenta)

			if not ( type( s ) == "table" and #s == 0 ) or not s then

				for i, v in ipairs(s) do

					player:outputChat("#A44B00Vehiculo: #FFFFFF"..getVehicleNameFromModel(v.Modelo).." #A44B00ID: #FFFFFF"..v.ID.." #A44B00Placa: #FFFFFF"..v.Placa, 255, 255, 255, true)

				end
			end
		end
	end
end)


local miblip = {}

addCommandHandler('localizarveh',function(player,cmd,id)
	if isElement(player) then
		if tonumber(id) then
			local v = getVehicleFromID(player, tonumber(id))
			local x,y,z = getElementPosition( v )
			local zona,ciudad = getZoneName( x,y,z),getZoneName( x,y,z, true)
			local vName = getVehicleName( v )
			player:outputChat("Su #FF9908"..vName..' #FFFFFFse encuentra en #FF9908'..ciudad..' #FFFFFF|| #FF9908'..zona, 255, 255, 255,true)
	 		player:outputChat("utiliza #ee0000/nblip #FFFFFFpara desmarcarlo",255,255,255,true)
	 			if isElement( miblip[player] ) then
					miblip[player]:destroy()
					miblip[player] = nil
				end
 				miblip[player] = Blip(x,y,z,0,2, 255,255,0,255,0,65535,player)
		else
			player:outputChat("Syntax: /localizarveh [ID]",255,50,50,true)
		end
	end
end)

addCommandHandler("nblip",function(player)
	if isElement( miblip[player] ) then
		miblip[player]:destroy()
		miblip[player] = nil
		player:outputChat("#ee0000Blip Eliminado",255,255,255,true)
	end
end)


addCommandHandler('traerveh',

	function(player, _, ID, vehID)

		if isElement(player) then

			if permisos[getACLFromPlayer(player)] == true then

				local who = exports["Gamemode"]:getFromName( player, ID )

				if who then

					local veh = getVehicleFromID(who, vehID)

					if veh then

						local position = player.matrix.position + player.matrix.right * 3

						setElementPosition(veh,position.x,position.y,position.z)

						setElementRotation(veh, getElementRotation(player))
					else
						player:outputChat("Syntax: /traerveh [ID] [IDveh]",255,50,50,true)
					end
				else
					player:outputChat("Syntax: /traerveh [ID] [IDveh]",255,50,50,true)
				end
			end
		end
	end
)

-- candado

addCommandHandler("candado",

	function(player)

		if isElement(player) then

			if motor == true then

				local cuenta = player.account.name

				local veh = getPlayerNearbyVehicle(player)

				if veh then

					if bicicletas[veh:getModel()] then

						if veh:getData("Owner") == cuenta then

							if veh:getData("CandadoBicicleta") == false then

								veh:setData("CandadoBicicleta", true)

								veh:setFrozen(false)

								player:outputChat("Desbloqueaste la bicicleta con la llave del candado.", 255, 255, 255, true)

								MensajeRol(player, "le saca el candado a su bicicleta.")

							else

								player:outputChat("Bloqueaste la bicicleta con el candado.", 255, 255, 255, true)

								veh:setData("CandadoBicicleta", false)

								veh:setFrozen(true)

								MensajeRol(player, "le coloca el candado a su bicicleta.")

							end

						end

					end

				end

			else

				player:outputChat("Debes estar adentro de un vehiculo y ser el conductor.", 150, 50, 50, true)

			end

		end

	end

)

addCommandHandler('estadoveh',

	function(player)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = player:getOccupiedVehicle()

			if veh and player:isInVehicle() then

				exports['Notificaciones']:setTextNoti(player, "Estado del Vehiculo: #ee0000"..math.ceil(veh:getHealth()/10)..'% #FFFF00de Vida', 255, 255, 1)
			else
				player:outputChat("[ERROR] Deves estar en un vehiculo",255,50,50,true)
			end

		end

	end

)

bicicletas = {
[510]=true,
[481]=true,
[509]=true,
}

addCommandHandler("candado",
	function(player)
		if isElement(player) then
			if player:isInVehicle() then
				local cuenta = player.account.name
				local veh = getPlayerNearbyVehicle(player)
				if veh then
					if bicicletas[veh:getModel()] then
						if veh:getData("Owner") == cuenta then
							if veh:getData("CandadoBicicleta") == false then
								veh:setData("CandadoBicicleta", true)
								veh:setFrozen(false)
								player:outputChat("Desbloqueaste la bicicleta con la llave del candado.", 255, 255, 255, true)
								MensajeRol(player, "le saca el candado a su bicicleta.")
							else
								player:outputChat("Bloqueaste la bicicleta con el candado.", 255, 255, 255, true)
								veh:setData("CandadoBicicleta", false)
								veh:setFrozen(true)
								MensajeRol(player, "le coloca el candado a su bicicleta.")
							end
						end
					end
				end
			else
				player:outputChat("Debes estar adentro de un vehiculo y ser el conductor.", 150, 50, 50, true)
			end
		end
	end
)



addCommandHandler('venderveh',

	function(vendedor, _, vehID, comprador, precio)

		if isElement(vendedor) then

			if tonumber(vehID) then

				local veh = getVehicleFromID(vendedor, tonumber(vehID))

				local comprador = type(tonumber(comprador)) == 'number' and exports["[LS]Login"]:getFromName( vendedor, comprador ) or getPlayerFromName( comprador )

				if comprador and tonumber(precio) then


					if comprador ~= vendedor then

						if not getDato(vendedor, 'Solicitador de Compra Veh') then

							local posicion = Vector3(vendedor:getPosition()) -- player

							local posicion2 = Vector3(comprador:getPosition()) -- jugador

							local x, y, z = posicion.x, posicion.y, posicion.z -- jugador

							local x2, y2, z2 = posicion2.x, posicion2.y, posicion2.z -- player

							if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then -- 5

								if tonumber(precio) >= 1 and comprador:getMoney() >= tonumber(precio) then

									local idd = getLastID(comprador)

									if (not getPlayerVIP(comprador) and idd-1 < 2) or (getPlayerVIP(comprador) == "VIPNormal" and idd-1 < 3) or (getPlayerVIP(comprador) == "VIPPro" and idd-1 < 4 )then

										setDato(comprador, 'Solicitado de Compra Veh', vendedor, true)

										setDato(vendedor, 'Solicitador de Compra Veh', {veh=getVehicleFromID(vendedor, tonumber(vehID)),id=tonumber(vehID),precio=tonumber(precio)})

										comprador:outputChat('A recibido una solitud de venta',255,255,0)

										comprador:outputChat('Vehiculo: '..veh.name..' Precio: '..precio,255,255,0)

										comprador:outputChat('/comprarveh',255,255,0)

										outputDebugString( vendedor.name..' le esta vendiendo un vehiculo a '..comprador.name, 3, 255, 255, 0)

										Timer(

											function(v,c)

												setDato(c, 'Solicitado de Compra Veh', nil)

												setDato(v, 'Solicitador de Compra Veh', nil)

											end

										,5000,1, vendedor, comprador)

									end

								else

									exports['[LS]Notificaciones']:setTextNoti(vendedor, 'Esta persona no tiene dinero suficiente', 255, 0, 1)

								end

							else

								exports['[LS]Notificaciones']:setTextNoti(vendedor, 'El comprador debe estar a tu lado.', 255, 0, 1)

							end

						else

							exports['[LS]Notificaciones']:setTextNoti(vendedor, 'Ya has solitado una venta, espera un momento.', 255, 0, 1)

						end

					end

				end

			end

		end

	end

)





addCommandHandler('comprarveh',
	function(comprador)
		if isElement(comprador) then
			local vendedor = getDato(comprador, 'Solicitado de Compra Veh')
			if isElement(vendedor) then
				local dato = getDato(vendedor, 'Solicitador de Compra Veh')
				if dato and table.getn(dato) == 3 then
					if comprador:getMoney() >= tonumber(dato.precio) then
						local cuentaV = vendedor.account.name
						local cuentaC = comprador.account.name
						local id = getLastID(comprador)
						local Plate = comprador.name:sub(1, comprador.name:find('_')-1)
						dato.veh:destroy()
						if table.getn(_AutosCreados[cuentaV]) > 0 then
							table.remove(_AutosCreados[cuentaV], dato.id)
						end
						comprador:takeMoney(dato.precio)
						vendedor:giveMoney(dato.precio)					
						databaseUpdate("UPDATE Info_Vehicles SET Cuenta='"..cuentaC.."', ID='"..id.."', Placa='"..Plate..' '..id.."' WHERE Cuenta='"..cuentaV.."' AND ID ='"..dato.id.."'")
						refreshIDVehicleDBFromPlayer(vendedor)
						exports['Notificaciones']:setTextNoti(getPlayersOverArea(comprador, 8), comprador.name..' le compro un vehiculo a '..vendedor.name, 50, 255, 50)
						comprador:outputChat('Le compraste un vehiculo a '..vendedor.name..' por '..dato.precio..'$')
						outputDebugString( comprador.name..' El compro el vehiculo a '..vendedor.name..' por '..dato.precio..'$', 3, 255, 255, 0)
						guardarVehiculosJugador(comprador)
						crearVehiculosJugador(comprador)
						setDato(comprador, 'Solicitado de Compra Veh', nil)
						setDato(vendedor, 'Solicitador de Compra Veh', nil)
					else
						exports['Notificaciones']:setTextNoti(vendedor, 'Esta persona no tiene dinero suficiente', 255, 0, 1)
					end
				end
			end
		end
	end
)


addCommandHandler('maletero',function(player)
	if isElement(player) then
		local cuenta = player.account.name
		local veh = getPlayerNearbyVehicle(player)
		if veh then
			if veh:getData('Owner') == cuenta or veh:getData('VehiculoPublico') == player:getData("Roleplay:faccion") then
				player:setAnimation('BD_FIRE', 'wash_up', -1, false, false, false)
				Timer(function(player)
					if veh:getDoorOpenRatio(1) == 0 then
						veh:setDoorOpenRatio(1,1)
						MensajeRol(player, "Abre el maletero")
						player:setAnimation()
					else
						veh:setDoorOpenRatio(1,0)
						MensajeRol(player, "Cierra el maletero")
						player:setAnimation()
					end
				end,3000,1,player)
			end
		else
			exports['Notificaciones']:setTextNoti(player, "Debes estar cerca de tu vehiculo para abrir el maletero", 227, 114, 1)
		end
	end
end)


local weaponsP = {
[22]=true,
[23]=true,
[24]=true,
[25]=true,
[26]=true,
[27]=true,
[28]=true,
[29]=true,
[32]=true,
[30]=true,
[31]=true,
[33]=true,
[34]=true,
[38]=true,
[16]=true,
[17]=true,
[18]=true,
[39]=true,
}

addCommandHandler('vermaletero',

	function(player)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = getPlayerNearbyVehicle(player)

			if veh then
					if veh:getDoorOpenRatio(1) == 1 then

						local mensaje = ''

						local male = veh:getData('Maletero')

						for i = 1, male.Slots do

							local array = male.Items[tostring(i)]

							if array[1] == 'Vacio' then

								item2 = "#FF4800Slot "..i..': '..array[1]
								
							else

								item2 = "#FF4800Slot "..i..": "..array[1].." | "..array[2]..""

							end

							player:outputChat(item2, 50, 150, 50, true)

						end

						MensajeRol(player, "Revisa el maletero")

						exports['Notificaciones']:setTextNoti(player, 'Espacio: #FF4800'..table.sizeM(male.Items)..'/'..male.Slots, 255, 255, 0)
					else
					exports['Notificaciones']:setTextNoti(player, "El maletero debe de estar abierto", 227, 114, 1)
				end
			end

		end

	end
)

function armaslot(id)
	if id == 30 or id == 31 then
		return 5
	elseif id == 25 then
		return 3
	end
	return false
end

addCommandHandler('metermaletero',

	function(player, _, ...)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = getPlayerNearbyVehicle(player)

			if veh then

				if veh:getDoorOpenRatio(1) == 1 then

					local male = veh:getData('Maletero')

					if weaponsP[getPedWeapon(player)] then

						if table.sizeM(male.Items) < male.Slots then

							local muni = ...

							if tonumber(muni) then

								muni = math.floor(math.abs(muni))

								if getPedTotalAmmo( player ) >= tonumber(muni) then

									local slot = getEmptySpace(veh)

									male.Items[slot] = {getNameWeapon(player),tonumber(muni)}

									takeWeapon(player, getPedWeapon(player), muni)
									guardarma(player)
									update(player)
									takeAllWeapons(player)
									backup(player)

									veh:setData('Maletero', male)
									
									MensajeRol(player, "Metio un arma en el maletero")
									if armaslot(getPedWeapon(player)) then
									triggerClientEvent(player,"destruirarma",player,player,armaslot(getPedWeapon(player)))
									end

									player:outputChat('Haz metido un arma en el maletero', 255, 255, 0)

								else 
									exports['Notificaciones']:setTextNoti(player,"No tienes esa cantidad de munición..", 100, 100, 10)
								end

							else
								exports['Notificaciones']:setTextNoti(player,"Debes poner la cantidad de munición que deseas guardar.", 150, 50, 50)
							end
						else
							exports['Notificaciones']:setTextNoti(player, 'El maletero esta lleno', 255, 255, 0)
						end
					elseif (...) == 'chaleco' then
						if table.sizeM(male.Items) < male.Slots then
							local armor = player:getArmor() or 0
							if armor > 0 then

								local slot = getEmptySpace(veh)

								male.Items[slot] = {'Chaleco',armor}

								veh:setData('Maletero', male)
																
								player:setArmor(0)

								MensajeRol(player, "Metio un chaleco en el maletero")

								player:outputChat('Haz guardado tu chaleco en el maletero', 255, 255, 0)
							end
						else
							exports['Notificaciones']:setTextNoti(player, 'El maletero esta lleno', 255, 255, 0)
						end
					end
				else
					exports['Notificaciones']:setTextNoti(player, "El maletero debe de estar abierto", 227, 114, 1)
				end
			end
		end
	end
)

addCommandHandler('sacarmaletero',

	function(player, _, item, muni)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = getPlayerNearbyVehicle(player)

			if veh then

					if veh:getDoorOpenRatio(1) == 1 then

						local male = veh:getData('Maletero')

						item = tostring(item)

						if table.sizeM(male.Items) > 0 then

							if tonumber(item) and tonumber(item) <= male.Slots and male.Items[item][1] ~= 'Vacio' then

								if table.findWeapon(male.Items[item][1]) then

									if muni then

										muni = math.floor(math.abs(muni))

										local reid, remuni = unpack(male.Items[item])

										if muni <= tonumber(remuni) then

											local resto = tonumber(remuni) - tonumber(muni)

											local id = getIDWeapon(reid)

											giveWeapon( player, id, tonumber(muni))

											male.Items[item] = resto == 0 and {'Vacio'} or {reid,resto}

											veh:setData('Maletero', male)
											MensajeRol(player, "Saca un arma del maletero.")
											player:outputChat('Haz sacado un arma del maletero', 255, 255, 0)

										else 
											
											exports['Notificaciones']:setTextNoti(player, 'No tienes esa cantidad de munición en el maletero', 150, 50, 50)

										end

									end

								elseif male.Items[item][1] == 'Chaleco' then

									local itemName, quantity = unpack(male.Items[item])									

									male.Items[item] = {'Vacio'}
									player:setArmor(quantity)
									veh:setData('Maletero', male)

									MensajeRol(player, "Saca un chaleco del maletero.")

									player:outputChat('Haz sacado el chaleco del maletero', 255, 255, 0)

								else

									local itemName, quantity = unpack(male.Items[item])									

									setPlayerItem(player, itemName, quantity)

									male.Items[item] = {'Vacio'}

									veh:setData('Maletero', male)

									exports['Notificaciones']:setTextNoti(player, 'A sacado '..itemName:lower()..' de su maletero', 255, 255, 0)
										
								end

							end

						else

							exports['Notificaciones']:setTextNoti(player, 'El maletero esta vacio', 255, 255, 0)
						end
					else
						exports['Notificaciones']:setTextNoti(player, "El maletero debe de estar abierto", 227, 114, 1)
					end
			end
		end
	end
)



local nameWeapon = {

[22]="Pistola 9mm",

[24]="Desert Eagle .44",

[25]="Escopeta Remington",

[33]="Rifle de Caza",

[29]="Subfusil MP5",

[31]="Fusil M4A1",

[30]="AK-47",

}


local nameFromIDWeapon = {

["Pistola 9mm"]=22,

["Desert Eagle .44"]=24,

["Escopeta Remington"]=25,

["Rifle de Caza"]=33,

["Subfusil MP5"]=29,

["Fusil M4A1"]=31,

["AK-47"]=30,

}

function guardarma(ped)
	for i=0, 12 do 
		local v = getPedWeapon( ped, i )
		local muni = getPedTotalAmmo(ped,i)
		if v and v ~= 0 then
			if muni and muni ~= 0 then
				if getPedWeapon( ped, i ) then
					takeWeapon( ped, v )
					giveWeapon( ped, v , muni )
				end	
			end
		end
	end
end

function update(source)
	guardarma(source)
	local weapons = ""
	for index=0,12 do
		local weapon = source:getWeapon(index)
		local ammo = source:getTotalAmmo(index)
		weapons = weapons..tostring(index).."="..tostring(weapon)..","..tostring(ammo)..";"
	end
		mysql:update("UPDATE save_system SET Weapons = ?  WHERE Cuenta = ?", weapons, AccountName(source))
end


function backup(source)
	if not(mysql:notIsGuest(source)) then 
		local cuenta = mysql:AccountName(source)
		local save = mysql:query("SELECT * From save_system WHERE Cuenta = '"..mysql:AccountName(source).."'")
		if not ( type ( save ) == "table" and #save == 0 ) or not save then
			local weapons = save[1]["Weapons"]
			if weapons and type(weapons) == "string" and string.len(weapons) > 0 then
				for index=0,12 do
					local coded_string = string.match(weapons, tostring(index).."=%d+,%d+")
					if coded_string then
						local weapon_start , weapon_end = string.find(coded_string, tostring(index).."=")
						local ammo_start, ammo_end = string.find(coded_string, tostring(index).."=%d+,")
						local decoded_weapon = string.match(coded_string, "%d+", weapon_end)
						local decoded_ammo = string.match(coded_string, "%d+", ammo_end)
						local wep = tonumber(decoded_weapon)
						local ammu = tonumber(decoded_ammo)
						if wep ~= 0 then
							if ammu > 1 then
								giveWeapon(source, wep, ammu)

							end
						end
					else
						print("ERROR: Imposible recobrar arma en Slot: ".. tostring(index).."")
					end
				end
			end
		end
	end
end

function refreshIDVehicleDBFromPlayer( player )

	if isElement(player) then

		local account = player.account.name

		local datos = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."'")

		if #datos > 0 then

			for k,v in pairs(datos) do

				local id = tonumber(v.ID)

				local id = id > 1 and tostring(id-1) or tostring(1)

				databaseUpdate("UPDATE Info_Vehicles SET ID='"..id.."', Placa='"..player.name:sub(1, player.name:find('_')-1)..' '..id.."' WHERE Cuenta='"..account.."'")

			end

			guardarVehiculosJugador(player)

			crearVehiculosJugador(player)

		end

	end

end



function getVehicleFromID(player, id)

	if isElement(player) then

		local cuenta = player.account.name

		if _AutosCreados[cuenta] then

			if _AutosCreados[cuenta][tonumber(id)] then

				return _AutosCreados[cuenta][tonumber(id)]

			end

		end

	end

	return false;

end


function table.getn(t)

	local size = 0

	for _ in pairs(t) do

		size = size + 1

	end

	return size

end



function table.sizeM(t)

	local size = 0

	for k,v in pairs(t) do

		if v[1] ~= 'Vacio' then

			size = size + 1

		end

	end

	return size

end



function table.find(t, value)

	for i,v in pairs(t) do

		if v == value then

			return i,v

		end

	end

	return false

end





function getPlayersOverArea(player,range)

	local new = {}

	local x, y, z = getElementPosition( player )

	local chatCol = ColShape.Sphere(x, y, z, range)

	new = chatCol:getElementsWithin("player") or {}

	chatCol:destroy()

	return new

end









function getEmptySpace(veh)

	local male = veh:getData('Maletero')

	if male then

		for i=1,male.Slots do

			if male.Items[tostring(i)][1] == 'Vacio' then

				return tostring(i)

			end

		end

	end

	return false

end







function getNameWeapon(player)

	return nameWeapon[tonumber(getPedWeapon(player))]

end



function getIDWeapon(name)

	return nameFromIDWeapon[tostring(name)]

end



function isItemWeaponMaletero(veh, id)

	local male = veh:getData('Maletero')

	for item,quantity in pairs(male.Items) do

		if tonumber(item) then

			if item == tostring(id) then

				return true

			else

				return false

			end

		end

	end

end



function setItemUpdate(veh, i, val)

	local male = veh:getData('Maletero')

	for item,quantity in pairs(male.Items) do

		if tonumber(item) then

			if item == tostring(i) then

				quantity = quantity + val

			end

		end

	end

	return false

end



function table.findWeapon(value)

	for _,v in pairs(nameWeapon) do

		if v == value then

			return true

		end

	end

	return false

end
