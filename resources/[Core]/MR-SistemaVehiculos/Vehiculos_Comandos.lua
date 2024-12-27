loadstring(exports.MySQL:getMyCode())()
mysql = exports.MySQL

import('*'):init('MySQL')

import('*'):init('Tiendas')


permisos = {

["Administrador"]=true,
["Admin"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Moderador A Pruebas"]=true,


}


loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')


local blips = {
{2132.9758300781, -1140.1700439453, 38.934371948242}, --Conce Jefferson
{2479.2683105469, -1747.7116699219, 35.134429931641}, --Conce Moto
{547.654296875, -1285.9326171875, 17.248237609863}, --Conce Cara
{1097.763671875, -1370.8673095703, 13.5}, --Conce Camioentas
{1897.4875488281, -2345.3630371094, 13}, --Conce Aviones
{1399.150390625, 456.26892089844, 20.172252655029}, --Conce Raro Montgomery
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(blips) do
		Blip( v[1], v[2], v[3], 55, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
	end
end)

local Blips2 = {
{723.11, -1494.55, 1.5}, --Conce Barcos
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(blips) do
		Blip( v[1], v[2], v[3], 55, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
	end
end)

addCommandHandler("misvehiculos", function(player, _)

	if not notIsGuest(player) then

		if isElement(player) then

			local cuenta = AccountName(player)

			local s = databaseQuery("SELECT * FROM Info_Vehicles where Cuenta = ?", cuenta)

			if not ( type( s ) == "table" and #s == 0 ) or not s then

				player:outputChat("Tus #FFFF00vehículos #FFFFFFson los siguientes:", 255, 255, 255, true)

				for i, v in ipairs(s) do

					player:outputChat("#FFFFFFVehiculo: #FFFF00"..getVehicleNameFromModel(v.Modelo).." #FFFFFFSLOT: #FFFF00"..v.ID.." #FFFFFFPlaca: #FFFF00"..v.Placa, 255, 255, 255, true)

				end
			end
		end
	end
end)

function onCarJacked ( player, seat, jacked )
    if jacked and seat == 0 then
        outputChatBox("#FFFFFFTu vehículo ha sido robado por: #F06C6C"..getPlayerName(jacked), player, 0,0,0, true)
        setElementData(player, "vehicles:CarJacked", getPlayerName(jacked))
    end
end
addEventHandler ( "onVehicleExit", getRootElement(), onCarJacked )

function showCJ(player, cmd, other)
	if other then
		local other, name = exports["Gamemode"]:getFromName(player, other)
		if other then
			if getElementData(other, "vehicles:CarJacked") then
				outputChatBox("#fFFF00El vehículo de "..name.." fue robado por: #9CFF97"..getElementData(other, "vehicles:CarJacked"), player, 0,0,0, true)
			else
				outputChatBox("#fFFF00El vehículo de "..name.." no ha sido robado.", player, 0,0,0, true)
			end
		end
	else
		outputChatBox("#44A5CASyntax: #FFFFFF/cj [ID]", player, 0,0,0, true)
	end
end
addCommandHandler("cj", showCJ)


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

addCommandHandler("limpiarblips",function(player)
	if isElement( miblip[player] ) then
		miblip[player]:destroy()
		miblip[player] = nil
		player:outputChat("#ee0000Blip Eliminado",255,255,255,true)
	end
end)


addCommandHandler('traerveh', function(player, _, ID, vehID)
    if isElement(player) then
        if permisos[getACLFromPlayer(player)] then
            local who = type(tonumber(ID)) == 'number' and getPlayerFromPartialNameID(ID) or getPlayerFromName(ID)
            if who then
                local veh = getVehicleFromID(who, vehID)
                if veh and isVehicleEmpty(veh) then
                    local position = player.matrix.position + player.matrix.right * 3
                    setElementPosition(veh, position.x, position.y, position.z)
                    setElementRotation(veh, getElementRotation(player))
                else
                    player:outputChat("Syntax: /traerveh [ID] [IDveh]", 255, 50, 50, true)
                end
            else
                player:outputChat("Syntax: /traerveh [ID] [IDveh]", 255, 50, 50, true)
            end
        end
    end
end)

addCommandHandler( "desvolcar",
	function( p, _, ID, vehID )
		if permisos[getACLFromPlayer(p)] == true then
			local veh = getPedOccupiedVehicle( p )
			if veh then
				local rx, ry, rz = getElementRotation( veh )
				setElementRotation( veh, rx, ry-180, rz )
			else
				local who = exports["Gamemode"]:getFromName( p, ID )
				if who then
					local veh = getVehicleFromID(who, vehID)
					if veh then
						local rx, ry, rz = getElementRotation( veh )
						setElementRotation( veh, rx, ry-180, rz )	
						outputChatBox( "#FF0000[SISTEMA] #FFFFFFHas volteado el vehículo SLOT: "..vehID..".", p, 0, 255, 150,true)
					else
						outputChatBox( "#FF0000[SISTEMA] #FFFFFF¡No existe el vehículo!", p, 255, 0, 0,true)
					end
				else
					p:outputChat("Syntax: /desvolcar [ID] [IDveh]",255,50,50,true)
				end
			end
		end
	end
)

local comandoActivo = false

addCommandHandler('cfasdfsa',
    function(player)
        if isElement(player) and player:isInVehicle() then -- Verificar si el jugador está en un vehículo
            if not comandoActivo then
                comandoActivo = true
                setTimer(function()
                    comandoActivo = false
                    MensajeRol(player, "se cambia de asiento rápidamente.")
                end, 2000, 1)
                
                local cuenta = player.account.name
                local veh = player:getOccupiedVehicle()
                if veh then
                    local copiloto = getVehicleOccupant(veh, 1)
                    local conductor = getVehicleOccupant(veh)
                    if copiloto and conductor then
                        removePedFromVehicle(conductor)
                        removePedFromVehicle(copiloto)
                        warpPedIntoVehicle(conductor, veh, 1)
                        warpPedIntoVehicle(copiloto, veh, 0)
                    else
                        removePedFromVehicle(player)
                        if copiloto then
                            warpPedIntoVehicle(player, veh)
                        elseif conductor then
                            warpPedIntoVehicle(player, veh, 1)
                        end
                    end    
                end
            else
                player:outputChat("Debes esperar 5 segundos antes de ejecutar el comando nuevamente.", 150, 0, 0)
            end
        else
            player:outputChat("Debes estar dentro de un vehículo para usar este comando.", 150, 0, 0)
        end
    end
)

addCommandHandler( "vehreparar",
	function( p, _, ID, vehID )
		if permisos[getACLFromPlayer(p)] == true then
			local veh = getPedOccupiedVehicle( p )
			if veh then
				local rx, ry, rz = getElementRotation( veh )
				setElementRotation( veh, rx, ry-180, rz )
			else
				local who = exports["Gamemode"]:getFromName( p, ID )
				if who then
					local veh = getVehicleFromID(who, vehID)
					if veh then
						local rx, ry, rz = getElementRotation( veh )
						fixVehicle ( veh ) 
						outputChatBox( "#FF0000[SISTEMA] #FFFFFF¡Reparaste con exito el vehículo de slot "..vehID.."!", p, 0, 255, 150,true)
					else
						outputChatBox( "#FF0000[SISTEMA] #FFFFFF¡No existe el vehiculo!", p, 255, 0, 0,true)
					end
				else
					p:outputChat("Syntax: /vehreparar [ID] [IDveh]",255,50,50,true)
				end
			end
		end
	end
)

-- candado

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

addCommandHandler('estadoveh',

	function(player)

		if isElement(player) then

			local cuenta = player.account.name

			local veh = player:getOccupiedVehicle()

			if veh and player:isInVehicle() then

				exports['[LS]Notificaciones']:setTextNoti(player, "#FFFFFFEstado del vehículo: #ee0000"..math.ceil(veh:getHealth()/10)..'% #FFFFFFde Vida', 255, 255, 1)
			else
				player:outputChat("Debes de estar adentro un vehículo para verificar su estado.",255,50,50,true)
			end

		end

	end

)

permisos = {

["Administrador"]=true,
["Admin"]=true,
["SuperModerador"]=true,
["Moderador"]=true,
["Moderador A Pruebas"]=true,


}

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

function ejectPl(pl)
    local veh = getPedOccupiedVehicle(pl)
    if veh then
        local driver = getVehicleOccupant(veh,0)
        if driver and driver == pl then
            for i=1,4 do
                local pass = getVehicleOccupant(veh,i)
                if pass then
                    removePedFromVehicle(pass)
                    outputChatBox("#FF0000[SISTEMA] #FFFFFFEl Jugador: #FF0000"..getPlayerName(pl).." #FFFFFFte expulsó de su vehículo.", pass, 245, 0, 0, true)
                end
            end
        end
    end
end
addCommandHandler("expulsar", ejectPl)

addCommandHandler('capo',function(player)
	if isElement(player) then
		local cuenta = player.account.name
		local veh = getPlayerNearbyVehicle(player)
		if veh then
			if veh:getData('Owner') == cuenta or veh:getData('VehiculoPublico') == player:getData("Roleplay:faccion") or permisos[getACLFromPlayer(player)] == true then
				player:setAnimation('BD_FIRE', 'wash_up', -1, false, false, false)
				Timer(function(player)
    				if getVehicleDoorOpenRatio(veh, 0 ) == 0 then
        				setVehicleDoorOpenRatio(veh, 0, 1)
						player:setAnimation()
						for i,v in ipairs(getPlayersOverArea(player,13)) do
						v:triggerEvent('CapoCerrar',v,'auto')
						end
					else
						for i,v in ipairs(getPlayersOverArea(player,13)) do
						v:triggerEvent('CapoAbrir',v,'auto')
						end
						setVehicleDoorOpenRatio(veh, 0, 0)
						player:setAnimation()
					end
				end,0,1,player)
			end
		else
			player:outputChat ("#FF0000[MALETERO] #FFFFFFNo estas cerca de ningun maletero o no estas conduciendo ningun vehiculo.",255, 120, 0,true)
		end
	end
end)

addCommandHandler( "ventanilla",
	function( p )
		local veh = getPedOccupiedVehicle(p)
		if veh then
			triggerClientEvent( root, "abrirVentanilla", root, veh, p )
		end
	end
)


addCommandHandler('venderveh',

	function(vendedor, _, vehID, comprador, precio)

		if isElement(vendedor) then

			if tonumber(vehID) then

				local veh = getVehicleFromID(vendedor, tonumber(vehID))

				local comprador = type(tonumber(comprador)) == 'number' and exports["Login"]:getFromName( vendedor, comprador ) or getPlayerFromName( comprador )

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

									if (not getPlayerVIP(comprador) and idd-1 < 2) or (getPlayerVIP(comprador) == "VIP" and idd-1 < 4) or (getPlayerVIP(comprador) == "VIP+" and idd-1 < 6 )then

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

									exports['Notificaciones']:setTextNoti(vendedor, 'Esta persona no tiene dinero suficiente', 255, 0, 1)

								end

							else

								exports['Notificaciones']:setTextNoti(vendedor, 'El comprador debe estar a tu lado.', 255, 0, 1)

							end

						else

							exports['Notificaciones']:setTextNoti(vendedor, 'Ya has solitado una venta, espera un momento.', 255, 0, 1)

						end

					end

				end
				else

				outputChatBox("#44A5CASyntax: #FFFFFF/venderveh [SlotVehiculo] [Nombre_Comprador] [PrecioVehiculo]", vendedor, 0,0,0, true)

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

addCommandHandler( "ventanilla",
	function( p )
		local veh = getPedOccupiedVehicle(p)
		if veh then
			triggerClientEvent( root, "abrirVentanilla", root, veh, p )
		end
	end
)



local spamTimers = {} -- Tabla para almacenar los tiempos de spam por jugador

addCommandHandler('maletero', function(player)
    if isElement(player) then
        local cuenta = player.account.name
        local veh = getPlayerNearbyVehicle(player)
        if veh then
            if veh:getData('Owner') == cuenta or veh:getData('VehiculoPublico') == player:getData("Roleplay:faccion") or permisos[getACLFromPlayer(player)] == true then
                local currentTime = getTickCount() -- Obtener el tiempo actual en milisegundos

                if spamTimers[player] and currentTime - spamTimers[player] < 1000 then
                    player:outputChat("Debes esperar 5 segundos antes de usar el comando de nuevo", 255, 0, 0)
                    return
                end
  local cx,cy,cz = getElementPosition(veh)
              
                    if veh:getDoorOpenRatio(1) == 0 then
                        veh:setDoorOpenRatio(1, 1)
                        MensajeRol(player, "> Abres el maletero del vehiculo.")
                        for i, v in ipairs(getPlayersOverArea(player, 5)) do
                            v:triggerEvent('MaleteroAbrir', v, cx, cy, cz)
                            player:setAnimation()
                        end
                    else
                        veh:setDoorOpenRatio(1, 0)
                        MensajeRol(player, "> Cierras el maletero del vehículo.")
                        for i, v in ipairs(getPlayersOverArea(player, 5)) do
                            v:triggerEvent('MaleteroCerrar', v,cx,cy,cz)
                            player:setAnimation()
                        end
                    end

                    -- Registrar el tiempo de uso del comando para el jugador
                    spamTimers[player] = currentTime
                
            end
        else
            player:outputChat("Debes estar cerca de tu vehículo para abrir el maletero", 255, 0, 0)
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
[35]=true,
[38]=true,
[16]=true,
[17]=true,
[18]=true,
[39]=true,
[41]=true,
}

local maxDistance = 10 -- Cambia esto al valor de distancia máximo que deseas

addCommandHandler('vermaletero', function(player)
    local veh = getPlayerNearbyVehicle(player)

    if veh and getDistanceBetweenElements3D(player, veh) <= maxDistance then
        -- Ejecutar el código correspondiente al comando aquí
    else
        player:outputChat('Debes estar cerca del vehículo para ejecutar este comando.', 255, 0, 0)
    end
end)

addCommandHandler('vermaletero',
    function(player)
        if isElement(player) then
            local cuenta = player.account.name
            local veh = getPlayerNearbyVehicle(player)

            if veh then
                if veh:getData('VehiculoPublico') == player:getData("Roleplay:faccion") then
                    player:outputChat("* No puedes usar el maletero de vehículos faccionarios.", 255, 0, 0)
                    return
                end

                if getElementData(veh, 'Owner') == cuenta then
                    if veh:getDoorOpenRatio(1) == 1 then
                        local mensaje = ''
                        local male = veh:getData('Maletero')
                        player:outputChat('#FFFFFF', 255, 120, 0, true)

                        player:outputChat('#FFFFFF===== #FFFFFFMALETERO de #FFFFFF'..getVehiclePlateText(veh)..' =====', 255, 120, 0, true)
                        player:outputChat('#FFFFFF', 255, 120, 0, true)

                        for i = 1, male.Slots do
                            local array = male.Items[tostring(i)]

                            if array[1] == 'Vacio' then
                                item2 = "#fc7300Slot: #ffffff"..i..' #e16904| #fc7300Objeto: #ffffffVacio'
                            else
                                item2 = "#fc7300Slot: #ffffff"..i.." #e16904| #fc7300Objeto: #ffffff"..array[1].." con "..array[2].." balas"
                            end

                            player:outputChat(item2, 255, 255, 255, true)

                        end
                        player:outputChat('#FFFFFF', 255, 120, 0, true)

                    else
                        player:outputChat("#FF1414[MALETERO] #FFFFFFEl maletero está cerrado. Usa #42FF00/maletero #FFFFFFpara abrirlo.", 255, 120, 0, true)
                    end
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



local spamTimers = {}

addCommandHandler('metermaletero',
    function(player, _, item, cantidad)
        if not isElement(player) then return end

        local cuenta = player.account.name
        local veh = getPlayerNearbyVehicle(player)

        if not veh then
            player:outputChat('#FF1414[MALETERO] #FFFFFFNo estás cerca de ningún vehículo.', 255, 0, 0, true)
            return
        end

        if veh:getDoorOpenRatio(1) ~= 1 then
            player:outputChat('#FF1414[MALETERO] #FFFFFFEl maletero está cerrado, usa #42FF00/maletero #FFFFFFpara abrirlo.', 255, 120, 0, true)
            return
        end

        local male = veh:getData('Maletero')

        if not male or table.sizeM(male.Items) >= male.Slots then
            player:outputChat('#FF1414[MALETERO] #FFFFFFEl maletero está lleno.', 255, 120, 0, true)
            return
        end

        item = item and item:lower()

        if item == 'arma' then
            if weaponsP[getPedWeapon(player)] then
                if not tonumber(cantidad) then
                    player:outputChat('#FF1414[MALETERO] #FFFFFFDebes especificar una cantidad válida de munición.', 255, 0, 0, true)
                    return
                end

                cantidad = math.floor(math.abs(tonumber(cantidad)))
                if getPedTotalAmmo(player) >= cantidad then
                    local slot = getEmptySpace(veh)
                    male.Items[slot] = {getNameWeapon(player), cantidad}

                    takeWeapon(player, getPedWeapon(player), cantidad)
                    guardarma(player)
                    update(player)
                    takeAllWeapons(player)
                    backup(player)

                    veh:setData('Maletero', male)

                    MensajeRol(player, 'mete algo en el maletero')

                    if armaslot(getPedWeapon(player)) then
                        triggerClientEvent(player, 'destruirarma', player, player, armaslot(getPedWeapon(player)))
                    end

                    player:outputChat('#FF1414[MALETERO] #FFFFFFHas metido un arma en el maletero.', 255, 120, 0, true)
                else
                    player:outputChat('#FF1414[MALETERO] #FFFFFFNo tienes suficiente munición.', 255, 120, 0, true)
                end
            else
                player:outputChat('#FF1414[MALETERO] #FFFFFFNo tienes un arma equipada.', 255, 0, 0, true)
            end

        elseif item == 'chaleco' then
            local armor = player:getArmor() or 0
            if armor > 0 then
                local slot = getEmptySpace(veh)
                male.Items[slot] = {'Chaleco', armor}

                player:setArmor(0)
                veh:setData('Maletero', male)

                MensajeRol(player, 'mete algo en el maletero')

                player:outputChat('#FF1414[MALETERO] #FFFFFFHas guardado tu chaleco en el maletero.', 255, 255, 0, true)
            else
                player:outputChat('#FF1414[MALETERO] #FFFFFFNo tienes chaleco para guardar.', 255, 120, 0, true)
            end

        else
            player:outputChat('#ff3d3d* Uso de comando Incorrecto (#ffFFff/metermaletero <tipo> <cantidad>#ff3d3d).', 255, 0, 0, true)
        end
    end
)




addCommandHandler('sacarmaletero', function(player, _, slot, muni)
    if not isElement(player) then return end

    local cuenta = player.account.name
    local veh = getPlayerNearbyVehicle(player)

    if not veh then
        player:outputChat('#ff3d3d* No estas cerca de ningun vehiculo', 255, 0, 0, true)
        return
    end

    if getElementData(veh, 'Owner') ~= cuenta 
        and veh:getData('VehiculoPublico') ~= player:getData("Roleplay:faccion") 
        and not permisos[getACLFromPlayer(player)] then
        player:outputChat('#ff3d3d No tienes permiso para acceder al maletero.', 255, 0, 0, true)
        return
    end

    if veh:getDoorOpenRatio(1) ~= 1 then
        player:outputChat('#FF1414[MALETERO] #FFFFFFEl maletero está cerrado, usa #42FF00/maletero #FFFFFFpara abrirlo.', 255, 120, 0, true)
        return
    end

    local male = veh:getData('Maletero')
    if not male or table.sizeM(male.Items) == 0 then
        player:outputChat('#FF1414[MALETERO] #FFFFFFEl maletero del vehículo está vacío.', 255, 0, 0, true)
        return
    end

    slot = tostring(slot)
    if not tonumber(slot) or tonumber(slot) > male.Slots or male.Items[slot][1] == 'Vacio' then
        player:outputChat('#ff3d3d* Debes introducir el slot que deseas sacar (#ffFFff/sacarmaletero <slot>#ff3d3d).', 255, 0, 0, true)
        return
    end

    local itemName, quantity = unpack(male.Items[slot])

    if table.findWeapon(itemName) then
        if not muni then
			player:outputChat('#ff3d3d* Debes introducir el slot que deseas sacar (#ffFFff/sacarmaletero <slot> <municion>#ff3d3d).', 255, 0, 0, true)
            return
        end

        muni = math.floor(math.abs(muni))
        if muni > quantity then
            player:outputChat('#ff3d3d* No tienes esa cantidad de munición en el maletero.', 255, 0, 0, true)
            return
        end

        local resto = quantity - muni
        giveWeapon(player, getIDWeapon(itemName), muni, true)
        male.Items[slot] = resto == 0 and {'Vacio'} or {itemName, resto}
        veh:setData('Maletero', male)
		player:outputChat('#FF1414[MALETERO] #FFFFFFHas sacado un(a) #ffff00' .. getWeaponNameFromID(getIDWeapon(itemName)) .. '#ffFFFf con #00ff00' .. tostring(muni) .. ' #ffFFffbalas de el maletero.', 255, 255, 255, true)

    elseif itemName:lower() == 'chaleco' then
        player:setArmor(quantity)
        male.Items[slot] = {'Vacio'}
        veh:setData('Maletero', male)
        player:outputChat('#FF1414[MALETERO] #FFFFFFHas sacado un #ffFF00 chaleco#ffFFff Con #00ff00'..tostring(quantity)..'% #ffFFff del maletero.', 255, 0, 0, true)

    else
        setPlayerItem(player, itemName, quantity)
        male.Items[slot] = {'Vacio'}
        veh:setData('Maletero', male)
        player:outputChat('#FF1414[MALETERO] #FFFFFFSacaste un ' .. itemName:lower() .. ' del maletero.', 255, 0, 0, true)
    end
end)





local nameWeapon = {

[22]="Pistola 9mm",

[24]="Desert Eagle .44",

[25]="Escopeta Remington",

[26]="Sawed-off",

[27]="Combat Shotgun",

[33]="Rifle de Caza",

[34]="Sniper",

[28]="Uzi",

[32]="TEC-9",

[29]="Subfusil MP5",

[31]="Fusil M4A1",

[30]="AK-47",

[35]="Rocket-Launcher",

[17]="Teargas",

[18]="Molotov",

[41]="Spraycan",

}


local nameFromIDWeapon = {
	
["Pistola 9mm"]=22,

["Desert Eagle .44"]=24,

["Escopeta Remington"]=25,

["Sawed off"]=26,

["Combat Shotgun"]=27,

["Rifle de Caza"]=33,

["Sniper"]=34,

["Uzi"]=28,

["TEC-9"]=32,

["Subfusil MP5"]=29,

["Fusil M4A1"]=31,

["AK-47"]=30,

["Rocket Launcher"]=35,

["Teargas"]=17,

["Molotov"]=18,

["Spraycan"]=41,

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

-- RASTREAR


local blip = {}
local timer = {}

addCommandHandler( "rastrear",
	function(p, _, ID, vehID)
			if getElementData(p,"Roleplay:faccion") == "Aseguradora" then 
				local who = exports["Gamemode"]:getFromName( p, ID )
				if who then
					local veh = getVehicleFromID(who, vehID)
					if veh then
						if getElementDimension(veh) == 0 then
							local x, y, z = getElementPosition(veh)
							outputChatBox( "[PDA] Vehículo encontrado. Punto marcado en el mapa. Se eliminará en 2 minutos.", p, 0, 255, 0 )
							blip[p] = createBlip( x, y, z, 0, 2, 0, 255, 0 )
							setElementVisibleTo( blip[p], root, false )
							setElementVisibleTo( blip[p], p, true )
							timer[p] = setTimer( function( player )
								if player then
									if isElement( blip[player] ) then destroyElement( blip[player] ) blip[player] = nil end
									timer[player] = nil
								end	
							end, 2*60000, 1, p )
						else
							local intname = exports.interiors:getInteriorName( getElementDimension(veh) )
							if intname then
								outputChatBox( "[PDA] El vehiculo esta en "..intname, p, 0, 255, 0 )
							else
								outputChatBox( "[PDA] El vehiculo esta en una propiedad.", p, 0, 255, 0 )
							end
						end
					else
						outputChatBox( "[PDA] No se encuentra el vehículo.", p, 255, 0, 0 )
					end
				else
					outputChatBox( "Syntax: /rastrear [id del user] + [slot del auto]", p, 255, 255, 255 )
				end
			end
		end
)

addCommandHandler( "papeles", 
function (player, commandName, otherPlayer)
	local otherPlayer = otherPlayer
	local vehicle = getPedOccupiedVehicle( player )
	local otro, nombre = exports["Gamemode"]:getFromName ( player, otherPlayer )
	local x, y, z = getElementPosition( player )
	local owner = vehicle:getData('Owner')
	local modelo = getVehicleName (vehicle)
	local matricula = getVehiclePlateText( vehicle )
    if getDistanceBetweenPoints3D( x, y, z, getElementPosition( otro ) ) < 5 then
		if vehicle then
			MensajeRol( player, "le muestra los papeles del coche a " .. nombre .. "." )
			outputChatBox ( "#ffffffPapeles del vehiculo #FF8700"..modelo..".", otro, 0, 255, 0 ,true)
				local name = getPlayerName( player )
				outputChatBox ( "#ffffffDueño: #FF8700".. owner .. "", otro, 255, 255, 255 ,true)
				outputChatBox ( "#ffffffModelo: #FF8700" .. modelo .. " ", otro, 255, 255, 255 ,true)
				outputChatBox ( "#ffffffMatricula: #FF8700" .. matricula, otro, 255, 255, 255 ,true)
				outputChatBox( "#ffffffAsegurado hasta: #FF8700"..os.date('%d-%m-%Y', tonumber(getElementData( vehicle, "seguro" )) ), otro, 255, 255, 255 ,true)
				outputChatBox( "#ffffffTipo del seguro: #FF8700"..getElementData(vehicle,"tiposeguro"), otro, 255, 255, 255 ,true)
		end
	end
end
)

addCommandHandler( "luces",
	function( player, commandName )
			local vehicle = getPedOccupiedVehicle( player )
			if vehicle and getVehicleOccupant( vehicle ) == player then
						setVehicleOverrideLights( vehicle, getVehicleOverrideLights( vehicle ) == 2 and 1 or 2 )
			end

			for key, value in ipairs(getElementsByType("vehicle")) do
				if isElement(value) and getElementData(value, "Vehiculos:Alquilado") then
					if getElementData(value, "Vehiculos:JugadorA") == player then
						local vehicle = getPedOccupiedVehicle( player )
						if vehicle and getPedOccupiedVehicleSeat( player ) == 0 then
							--exports.chat:ame( player, ( getVehicleOverrideLights( vehicle ) == 2 and "apaga" or "enciende" ).." las luces del vehiculo." )
							setVehicleOverrideLights( vehicle, getVehicleOverrideLights( vehicle ) == 2 and 1 or 2 )
					
					end
				end
			end
		end
	end
)

function unhookTrailer(playerSource, commandName) 
   if (playerSource and isPedInVehicle(playerSource)) then 
      local theVehicle = getPedOccupiedVehicle(playerSource) 
      local vehiculos = { [515] = true} 
    if (getVehicleTowedByVehicle(theVehicle) and getElementModel(getVehicleTowedByVehicle(theVehicle)) == 435) then 
      local Remol = getVehicleTowedByVehicle(theVehicle) 
      local success = detachTrailerFromVehicle(theVehicle) 
     	end 
   	end 
end 
addCommandHandler("soltartrailer", unhookTrailer) 





local bicicletas = {
[510]=true,
[481]=true,
[509]=true,
}

addEventHandler("onVehicleEnter", getRootElement(), function( player, seat, jacked, door )
	if source:getHealth() <= 280 then
		source:setEngineState (false)
		source:setFrozen(false)
		source:setLightState(0, 1)
		source:setLightState(1, 1)
		source:setData('Motor', 'apagado')
	end
	if seat == 0 then
		if not bicicletas[source:getModel()] then

			if source:getHealth() >= 281 then
				if source:getData('Motor') == 'apagado' then
					local gas = getElementData(source, "Fuel") or 0
					if gas >= 1 then 
						source:setEngineState (false)
						source:setLightState(0, 1)
						source:setLightState(1, 1)
						exports['MR-Notificaciones']:outputDXMessage("Usa el comando /motor para encender/apagar el vehículo.", player, 0, 255, 0)
					else 
						source:setEngineState (false)

						source:outputChat("#ff3d3d* Este vehiculo se quedo sin gasolina.", 255, 0, 0,true)
					
					end
					source:setFrozen(false)
				end	
			else
				source:setEngineState (false)
				source:setFrozen(false)
				source:setLightState(0, 1)
				source:setLightState(1, 1)
				source:setData('Motor', 'apagado')
				player:outputChat("¡El motor esta malogrado, necesita reparación el vehículo!", 150, 50, 50, true)
			end
		end
	end
end)




addCommandHandler("motor", function(player)
    if not isGuestAccount(getPlayerAccount(player)) then
        if player:isInVehicle() then
            local veh = player:getOccupiedVehicle()
            local seat = player:getOccupiedVehicleSeat()
            
            if veh and seat == 0 and not bicicletas[veh:getModel()] then
                local currentTime = getTickCount()
                
                if spamTimers[player] and currentTime - spamTimers[player] < 3000 then
                    player:outputChat("#ff3d3d* Debes esperar 5 segundos antes de usar el comando.", 255, 0, 0,true)
                    return
                end
                
                local gas = getElementData(veh, "Fuel") or 0
                
                if gas >= 1 and not player:getData("EnGasolinera") and veh:getHealth() >= 281 then
                    if veh:getData('Motor') == 'apagado' then
                        MensajeRol(player, " está encendiendo el motor del vehículo", 1)
                         spamTimers[player] = currentTime
                        setTimer(function(player, veh)
                            MensajeRol(player, "El motor del vehículo de "..getPlayerName(player).." fue encendido ("..getPlayerName(player)..")", 0)
                            veh:setEngineState(true)
                            veh:setData('Motor', 'encendido', false)
                            veh:setFrozen(false)
                            spamTimers[player] = currentTime
                        end, 1500, 1, player, veh)
                        
    player:triggerEvent('Vehiculos:EncederVeh')
                    else
                        MensajeRol(player, " apagó el motor del vehículo", 1)
                        spamTimers[player] = currentTime
                        setTimer(function(player, veh)
                            MensajeRol(player, "El motor del vehículo de "..getPlayerName(player).." fue apagado ("..getPlayerName(player)..")", 0)
                            veh:setEngineState(false)
                            veh:setData('Motor', 'apagado')
                            spamTimers[player] = currentTime
                        end, 500, 1, player, veh)
                    end
				else
                    player:outputChat("#ff3d3d* Este vehiculo se quedo sin gasolina.", 255, 0, 0,true)
					

                end
            end
        end
    end
end)


function checkgas(player)
    local vehicle = getPedOccupiedVehicle(player)
	if vehicle then
        local fuel = getElementData(vehicle, "Fuel")
        if fuel then
            outputChatBox("La gasolina actual del vehículo es: " .. fuel .. "%", player, 255, 255, 0)
        else
            outputChatBox("El vehículo no tiene datos de gasolina.", player, 255, 0, 0)
        end
    else
        outputChatBox("No estás dentro de un vehículo.", player, 255, 0, 0)
    end
end
addCommandHandler("gasolina",checkgas)


function getPlayersOverArea(player,range)
	local new = {}
	local x, y, z = getElementPosition( player )
	local chatCol = ColShape.Sphere(x, y, z, range)
	new = chatCol:getElementsWithin("player") or {}
	chatCol:destroy()
	return new
end

local veh_sirens = {}
local sirensOffs = {
	[596] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},
	[597] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},
	[598] = {{0.5, -0.5, 1},{-0.5, -0.5, 1},{0, -0.5, 1},{255,0,0},{0,0,255}},
	[599] = {{0.5, 0.5, 1.2},{-0.5, 0.5, 1.2},{0, 0.5, 1.2},{255,0,0},{0,0,255}},
	[490] = {{0.5, 0.5, 1.2},{-0.5, 0.5, 1.2},{0, 0.5, 1.2},{255,0,0},{0,0,255}},
	[528] = {{0.5, 0.5, 1.1},{-0.5, 0.5, 1.1},{0, 0.5, 1.1},{255,0,0},{0,0,255}},
	[427] = {{0.3, 0.8, 1.2},{-0.3, 0.8, 1.2},{0, 0.8, 1.2},{255,0,0},{0,0,255}},
	[523] = {{0.3, -1, 0.5},{-0.3, -1, 0.5},{0, -1, 0.5},{255,0,0},{0,0,255}},
	[416] = {{0.3, 1.2, 1.2},{-0.3, 1.2, 1.2},{0, 1.2, 1.2},{255,0,0},{0,0,255}},
	[407] = {{0.7, 3.2, 1.3},{-0.7, 3.2, 1.3},{0, 3.2, 1.3},{255,255,0},{255,255,0}},
	[544] = {{0.6, 3.2, 1.3},{-0.6, 3.2, 1.3},{0, 3.2, 1.3},{255,255,0},{255,255,0}},
	[433] = {{0.4, 1, 1.8},{-0.4, 1, 1.8},{0, 1, 1.8},{73,41,3},{73,41,3}},

}
addCommandHandler("sirenas", 
function(player)
		local veh = player.vehicle;
		local seat = player:getOccupiedVehicleSeat()
		if veh and seat == 0 or seat == 1 then
			local id = veh.model;
			if id == 596 or id == 597 or id == 598 or id == 599 or id == 490 or id == 528 or id == 427 or id == 523 or id == 416 or id == 407 or id == 544 or id == 433 then
			triggerClientEvent('SirenaConfig',root, 'encender', veh)
			if not veh_sirens[veh] then
				veh_sirens[veh] = true
				addVehicleSirens(veh,3,2,false,false,true)
				setVehicleSirensOn( veh, true )
				local fr,fg,fb = unpack(sirensOffs[id][1]) 
				local r,g,b = unpack(sirensOffs[id][4])
				setVehicleSirens(veh, 1, fr,fg,fb, (r or 255), (g or 0), (b or 0), 255, 255 )
				local fr,fg,fb = unpack(sirensOffs[id][2])
				local r,g,b = unpack(sirensOffs[id][5])
				setVehicleSirens(veh, 2, fr,fg,fb, (r or 0), (g or 0), (b or 255), 255, 255 )
				local fr,fg,fb = unpack(sirensOffs[id][3])
				setVehicleSirens(veh, 3, fr,fg,fb, 255, 255, 255, 255, 255 )
			else
				removeVehicleSirens(veh)
				veh_sirens[veh] = nil
				setVehicleSirensOn( veh, false)
			end
		end
	end
end
)

addCommandHandler("luces", function(player)
	if not notIsGuest(player) then
		local veh = player:getOccupiedVehicle()
		local seat = player:getOccupiedVehicleSeat()
		if player:isInVehicle() and veh and seat == 0 then
			if not bicicletas[veh:getModel()] then
				if veh:getLightState(0) == 1 and veh:getLightState(1) == 1 then
					player:outputChat("Luces encendidas", 0, 255, 0, true)
					veh:setLightState(0, 0)
					veh:setLightState(1, 0)
					player:setData("TextInfo", {"> encendio las luces de su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
					setTimer(function(p)
						if isElement(p) then
						p:setData("TextInfo", {"", 255, 0, 216})
					end
					end, 2000, 1, player)
				else
					player:outputChat("Luces apagadas", 150, 50, 50, true)
					veh:setLightState(0, 1)
					veh:setLightState(1, 1)
					player:setData("TextInfo", {"> apago las luces de su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
					setTimer(function(p)
						if isElement(p) then
						p:setData("TextInfo", {"", 255, 0, 216})
					end
					end, 2000, 1, player)
				end
			end
		end
	end
end)



setTimer(
	function()
		for i,v in ipairs(Element.getAllByType('vehicle')) do
			if v and isElement(v) then
				if v:getData('Motor') ~= 'apagado' and v:getData('Motor') ~= 'encendido' then
					v:setData('Motor','apagado')
					v:setFrozen(true)
				end
			end
		end
	end
,100,0)

addEventHandler("onVehicleEnter", getRootElement(), function( thePlayer, seat, jacked )
	if thePlayer:getType() == "player" then
		if seat == 0 then
			if thePlayer:getData('Roleplay:faccion') == source:getData("VehiculoPublico") or thePlayer:getData("Roleplay:trabajo") == source:getData("VehiculoPublico") or thePlayer:getData("Roleplay:Mision") == source:getData("VehiculoPublico") then
			else
				thePlayer:removeFromVehicle(thePlayer:getOccupiedVehicle())
				source:setEngineState (false)
				source:setLightState(0, 1)
				source:setLightState(1, 1)
				source:setFrozen(true)
				thePlayer:outputChat("Este vehículo le pertenece a "..source:getData("VehiculoPublico").."", 150, 50, 50, true)
				--
			end
		end
	end
end)