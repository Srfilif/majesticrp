_AutosCreados = {}
local Concesionario = {}
Concesionario.__index = Concesionario
Concesionario['vDatos'] = {}

local bikes = {
[581]=true,
[462]=true,
[521]=true,
[463]=true,
[522]=true,
[461]=true,
[448]=true,
[468]=true,
[586]=true,
[523]=true,
[471]=true,
}

bicicletas = {
[510]=true,
[481]=true,
[509]=true,
}
--abrirp



local conces = {
	["Conse Barata"] = {
		{2132.001953125, -1151.32421875, 24.062154769897,ID={401,602,565,566,547,410,585,426,558,445,567,562,507,542},Pos=2119.5977},
	},
	["Motos"] = {
		{1990.693359375, -1991.49609375, 13.546875,ID={509,510,481,462,463,586,521,461,468,581,522},Pos=1987.0840}
	},
	["Conce Cara"] = {
		{552.75878, -1291.79003, 17.24823,ID={579,402,603,429,415,480,411,451,555,560,477},Pos=543.08984}
	},
}


addEventHandler("onResourceStart", resourceRoot, function()
	for index, vae in pairs(conces) do
		for i, v in pairs(vae) do
			p = Pickup(v[1], v[2], v[3], 3, 1239, 0 )
			p:setData("pickup.conceinfo", v.ID)
			p:setData("pickup.concematrix", v.Pos)
			addEventHandler("onPickupHit", p, function(hitElement)
				if hitElement:getType() == "player" then
					if not hitElement:isInVehicle() then
						bindKey ( hitElement, "F", "down", OpenConce )
						hitElement:setData("PickupConce", source)
					end
				end
			end)
			addEventHandler("onPickupLeave", p, function(hitElement)
				if hitElement:getType() == "player" then
					if not hitElement:isInVehicle() then
						unbindKey ( hitElement, "F", "down", OpenConce )
						hitElement:setData("PickupConce", nil)
					end
				end
			end)
		end
	end
end)	

function OpenConce(source)
	if not source:isInVehicle() then
		local coldat = source:getData("PickupConce")
		if isElement( coldat ) then
			local infos = coldat:getData("pickup.conceinfo")
			local infos2 = coldat:getData("pickup.concematrix")
			source:triggerEvent("Conce:setWindow", source, infos)
			source:triggerEvent("Conce:Car", source, infos2)
		end
		unbindKey(source, "F", "down", OpenConce)
	end
end

local r, g, b, r2, g2, b2

addEvent("BuyCars",true)
addEventHandler("BuyCars",root,function(r, g, b, r2, g2, b2,modelo,precio,male,pos)
	if source:getMoney() >= precio then
		local id = getLastID(source) 
		if (not getPlayerVIP(source) and id-1 < 2) or (getPlayerVIP(source) == "VIPNormal" and id-1 < 3) or (getPlayerVIP(source) == "VIPPro" and id-1 < 4 ) then
			local X,Y,Z,rX,rY,rZ = getFreePosition(pos)
			local maletero = {Slots=male,Items={}}
			local account = AccountName(source)
			for pi = 1,male do
				maletero.Items[tostring(pi)] = {'Vacio'}
			end
			_AutosCreados[account] = _AutosCreados[account] or {}
			_AutosCreados[account][id] = createVehicle(modelo, X,Y,Z,rX,rY,rZ)
			_AutosCreados[account][id]:setColor(r, g, b, r2, g2, b2)
			_AutosCreados[account][id]:setLocked(true)
			_AutosCreados[account][id]:setEngineState(false)

			_AutosCreados[account][id]:setData('Owner', account)
			_AutosCreados[account][id]:setData('Maletero', maletero)
			_AutosCreados[account][id]:setData('ID', id) -- opcional
			_AutosCreados[account][id]:setData('Locked', 'Cerrado')
			_AutosCreados[account][id]:setData("Fuel", 100)
			local placa = _AutosCreados[account][id]:getPlateText()

			source:takeMoney(tonumber(precio))
			exports["Notificaciones"]:setTextNoti(source, "Tu vehículo se encuentra afuera estacionado", 50, 150, 50, true)
			exports['Notificaciones']:setTextNoti(source, "Compraste el vehiculo "..(getVehicleNameFromModel(modelo))..' por un costo de $'..(precio), 255, 0, 210)	
			insertDat(source, id, modelo, precio, X,Y,Z, rZ, r, g, b, r2, g2, b2, placa, toJSON(maletero), 100)
	
		else
			exports["Notificaciones"]:setTextNoti(source, "No puedes comprar mas autos compra Vip para mas", 50, 150, 50, true)
		end
	else
		exports["Notificaciones"]:setTextNoti(source, "No tienes dinero suficiente", 50, 150, 50, true)
	end
end)


local posiciones_c = {
	pos_A = {
		{2136.4814453125, -1130.5205078125, 25.678302764893, 0, 0, 175.91302490234},
		{2136.4814453125-4, -1130.5205078125, 25.678302764893, 0, 0, 175.91302490234},
		{2136.4814453125-8, -1130.5205078125, 25.678302764893, 0, 0, 175.91302490234},
		{2136.4814453125-12, -1130.5205078125, 25.678302764893, 0, 0, 175.91302490234},
	},

	pos_B = {
		{1987.3359375, -1996.408203125, 13.546875,0, 0, 1.6067810058594},
		{1987.3359375-3, -1996.408203125, 13.546875,0, 0, 1.6067810058594},
		{1987.3359375-6, -1996.408203125, 13.546875,0, 0, 1.6067810058594},
		{1987.3359375-9, -1996.408203125, 13.546875,0, 0, 1.6067810058594},		
	},
	pos_C = {
		{564.466796875, -1281.4638671875, 17.248237609863,0, 0, 101.85852050781},
		{564.466796875, -1281.4638671875+3, 17.248237609863,0, 0, 101.85852050781},
		{564.466796875, -1281.4638671875+6, 17.248237609863,0, 0, 101.85852050781},
		{564.466796875, -1281.4638671875+9, 17.248237609863,0, 0, 101.85852050781},

	},

}
function getFreePosition(key)
	local x,y,z,rx,ry,rz = 0,0,0,0,0,0
	for i,v in ipairs(posiciones_c[key]) do
		local col = createColSphere( v[1],v[2],v[3], 2 )
		local _counts = col:getElementsWithin('vehicle')
		if #_counts == 0 then
			x,y,z,rx,ry,rz = v[1],v[2],v[3],v[4],v[5],v[6]
			if isElement(col) then
				col:destroy()
			end
			return x,y,z,rx,ry,rz
		else
			if isElement(col) then
				col:destroy()
			end
		end
	end
	x,y,z,rx,ry,rz = unpack(posiciones_c[key][math.random(1,#posiciones_c[key])])
	return x,y,z,rx,ry,rz
end


addEventHandler( "onResourceStart", resourceRoot, 
	function()
	for i,player in ipairs(Element.getAllByType('player')) do
		crearVehiculosJugador(player)
	end
end)

addEventHandler( "onResourceStop", getResourceRootElement(  ), 
	function()
		for i,player in ipairs(Element.getAllByType('player')) do
			guardarVehiculosJugador(player)
		end
	end
)
addEventHandler( "onPlayerLogin", getRootElement(),
	function()
		crearVehiculosJugador(source)
	end
)

addEventHandler( "onPlayerQuit", getRootElement(),
	function()
		guardarVehiculosJugador(source)
	end
)
local antiSpamCommnd = {}

function abrirMyVehicle(p,cmd)
	local veh = getPlayerNearbyVehicle(p)
	if veh then
		local ID = veh:getData('ID') or false
		if ID then
			local tick = getTickCount()
			if (antiSpamCommnd[p] and antiSpamCommnd[p][1] and tick - antiSpamCommnd[p][1] < 1000) then
				return
			end
			local owner = getElementData(veh,'Owner')
			if owner and owner == p.account.name then
				local state = getElementData(veh, 'Locked')
				if state == 'Abierto' then

					veh:setLocked(true)
					veh:setData('Locked', 'Cerrado')
					exports['Notificaciones']:setTextNoti(p, "> cerro su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 210)
					p:setData("TextInfo", {"> cerro su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
					setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
					end, 2000, 1, p)
					
				else
					
					veh:setLocked(false)
					veh:setData('Locked', 'Abierto')
					exports['Notificaciones']:setTextNoti(p, "> abrio su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 210)
					p:setData("TextInfo", {"> abrio su ".. getVehicleNameFromModel(veh:getModel()), 255, 0, 216})
					setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
					end, 2000, 1, p)
				
				end
			end
			if (not antiSpamCommnd[p]) then
				antiSpamCommnd[p] = {}
			end
			antiSpamCommnd[p][1] = getTickCount()
		end
	end
end
addCommandHandler("abrir",abrirMyVehicle)
addCommandHandler("cerrar",abrirMyVehicle)
addCommandHandler("bloqueo",abrirMyVehicle)



function crearVehiculosJugador(player)
	local account = AccountName(player)
	local datos = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."'") or 0
	if #datos > 0 then
		for k,v in pairs(datos) do

			local color = split( v.Color, ',' )
			local account = AccountName(player)
			local id = tonumber(v.ID)
			_AutosCreados[account] = _AutosCreados[account] or {}
			_AutosCreados[account][id] = createVehicle(tonumber(v.Modelo), v.X,v.Y,v.Z,0,0,v.rotZ)
			_AutosCreados[account][id]:setColor(color[1],color[2],color[3],color[4],color[5],color[6])
			_AutosCreados[account][id]:setLocked(true)
			_AutosCreados[account][id]:setEngineState(false)
			_AutosCreados[account][id]:setPlateText(tostring(v.Placa))
			_AutosCreados[account][id]:setHealth(tonumber(v.Vida))

			_AutosCreados[account][id]:setData('Owner', v.Cuenta)
			_AutosCreados[account][id]:setData('rent1', v.Rent1)
			_AutosCreados[account][id]:setData('rent2', v.Rent2)
			_AutosCreados[account][id]:setData('Maletero', fromJSON(v.Maletero))
			_AutosCreados[account][id]:setData('ID', tonumber(v.ID)) -- opcional
			_AutosCreados[account][id]:setData('Locked', 'Cerrado')
			_AutosCreados[account][id]:setData("Fuel", tonumber(v.Gasolina))
			_AutosCreados[account][id]:setData('Kilometraje', tonumber(v.Kilometraje))

			for i, upgrade in ipairs(split(v.Upgrades, ',')) do
				addVehicleUpgrade(_AutosCreados[account][id], upgrade)
			end
			setVehiclePaintjob(_AutosCreados[account][id], (tonumber(v.Paint) or 3))
		end
	end
end

function guardarVehiculosJugador(player)
	local account = AccountName(player)
	local datos = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."'")
	if #datos > 0 then
		local autos = _AutosCreados[account]
		if autos then
			for i = 1, #autos do
				local id = getElementData(autos[i],'ID')
				local vida = autos[i]:getHealth()
				local fuel = getElementData(autos[i],"Fuel") or 0
				local x,y,z = getElementPosition(autos[i])
				local _,_,rz = getElementRotation( autos[i] )
				local rent1 = getElementData(autos[i],'rent1')
				local rent2 = getElementData(autos[i],'rent2')
				local maletero = toJSON(getElementData(autos[i],'Maletero'))
				local paintjob = autos[i]:getPaintjob()
				local r, g, b, r2, g2, b2 = autos[i]:getColor(true)
				local upgrade = ""
				for _, upgradee in ipairs(autos[i]:getUpgrades()) do
					if upgrade == "" then
						upgrade = upgradee
					else
						upgrade = upgrade..","..upgradee
					end
				end
				local account = AccountName(player)
				local s = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."' AND ID ='"..id.."'")
				if #s > 0 then
					local color = r..","..g..","..b..","..r2..","..g2..","..b2
					databaseUpdate("UPDATE Info_Vehicles SET X=?,Y=?,Z=?,rotZ=?,Vida=?,Color=?,Maletero=?,Gasolina=?,Upgrades=?,Paint=?,Rent1=?,Rent2=? WHERE Cuenta='"..account.."' AND ID ='"..id.."'", x, y, z, rz,vida,color,maletero,fuel,upgrade,paintjob,rent1,rent2)
				end
			end
			for i = 1, #autos do
				if isElement(autos[i]) then
					autos[i]:destroy()
				end
			end
			_AutosCreados[account] = nil
		end
	end
end
function getPlayerNearbyVehicle(player)
	if isElement(player) then
		for i,veh in ipairs(Element.getAllByType('vehicle')) do
			local vx,vy,vz = getElementPosition( veh )
			local px,py,pz = getElementPosition( player )
			if getDistanceBetweenPoints3D(vx,vy,vz, px,py,pz) < 3.5 then
				return veh
			end
		end
	end
	return false
end

function insertDat(player, id, modelo, cost, x, y, z, rz, r, g, b, r2, g2, b2, placa, maletero, gasolina, upgrades, paintjob,vida,rent1,rent2)
	if isElement(player) then
		local account = AccountName(player)
		local s = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."' AND ID ='"..id.."'")
		if #s == 0 or not s then
			local color = r..","..g..","..b..","..r2..","..g2..","..b2
			databaseInsert("INSERT INTO Info_Vehicles VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", id, account, modelo, gasolina, x, y, z, rz, 1000, '', '', color, placa, maletero, cost,"","")
		end
	end
end

function getLastID(player)
    if isElement( player ) then
        local result = databaseQuery("SELECT * FROM Info_Vehicles WHERE Cuenta=?",getAccountName(getPlayerAccount(player)))
        return (#result or 0) + 1
    end
end

function getPlayerVIP(player)
	if isElement(player) then
		local accName = getAccountName ( getPlayerAccount ( player ) )
		if isObjectInACLGroup ("user."..accName, aclGetGroup ( "VIPPro" ) ) then
			return "VIPPro"
		elseif isObjectInACLGroup ("user."..accName, aclGetGroup ( "VIPNormal" ) ) then
			return "VIPNormal"
		else
			return false
		end
	end
	return false
end

function isPedWithinRange(x,y,z,range,ped)
	for _, type in ipairs({'player','ped'}) do
		for k,v in pairs(getElementsWithinRange(x,y,z,range, type)) do
			if v == ped then
				return true
			end
		end
	end
	return false;
end

local Markersvender = {}
local venderveh = {}

local marcadores = {
{2557.3525390625, -1126.8623046875, 64.06379699707},
{2160.46484375, -1976.94140625, 13.552664756775},
{1013.5712890625, -1006.98046875, 32.1015625},
}

addEventHandler("onResourceStart", resourceRoot, function()
	for i,v in ipairs(marcadores) do
		Markersvender[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 4, 27, 100, 0, 100)
		addEventHandler("onMarkerLeave", Markersvender[i], function(player)
			if player and player:getType() =="player" then
				if player:isInVehicle() then
					local veh = player:getOccupiedVehicle()
					local seat = player:getOccupiedVehicleSeat()
					if veh and seat == 0 then
						exports["Notificaciones"]:setTextNoti(player, "¡Acabas de cancelar la venta de tu auto!", 150, 50, 50)
						venderveh[player] = nil
					end
				end
			end
		end)
	end
end)

addCommandHandler("vendervehestado",function(source)
	for i, marker in ipairs(Markersvender) do
		if isElementWithinMarker(source,marker) then
			source:outputChat("Seguro que quieres vender el vehiculo",255,255,255,true)
			source:outputChat("Te recordamos que solo se te otorgara",255,255,255,true)
			source:outputChat("El #FF8300%40 #FFFFFFdel valor del vehiculo ",255,255,255,true)
			source:outputChat("si ya estas seguro pon#FF8300 /sivenderveh",255,255,255,true)
			venderveh[source] = true
		end
	end
end)


addCommandHandler("sivenderveh",function(source)
	for i, marker in ipairs(Markersvender) do
		if isElementWithinMarker(source,marker) then
			if isElement(source) then
				local account = AccountName(source)	
				local s = databaseQuery("SELECT * FROM Info_Vehicles where Cuenta = ?", account)
				if not ( type( s ) == "table" and #s == 0 ) or not s then
					for i, v in ipairs(s) do
						if isPedInVehicle (source) then
							if venderveh[source] == true then
								vehicles = getPedOccupiedVehicle ( source,account )
								local data = databaseQuery("SELECT * From Info_Vehicles WHERE Cuenta='"..account.."' AND Placa='"..v.Placa.."' AND ID='"..v.ID.."' AND Modelo='"..v.Modelo.."'AND Costo='"..v.Costo.."'")
								if type(data) == "table" and #data ~= 0 then	
									if isElement(vehicles) then
										vehicles:destroy()
										source:setMoney(getPlayerMoney(source)+tonumber(v.Costo)*40/100)
			 							databaseDelete("DELETE FROM Info_Vehicles WHERE Cuenta='"..account.."' AND Placa='"..v.Placa.."'AND ID='"..v.ID.."'AND Modelo='"..v.Modelo.."' AND Costo='"..v.Costo.."'")
										source:outputChat("Usted vendio su vehiculo por #FF8300$"..v.Costo*40/100, 255, 255, 255, true)
										venderveh[source] = nil
									end
								end
							end	
						end	
					end
				end
			end
		end
	end
end)
