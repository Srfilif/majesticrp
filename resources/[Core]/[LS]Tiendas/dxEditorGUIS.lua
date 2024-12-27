loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

addEventHandler( "onResourceStart", resourceRoot, 
	function()
		for i,v in ipairs(getElementsByType('player', root)) do
			bindKey(v,"i","down", function(player)
				triggerClientEvent(player, 'Open:Inventory', player, getPlayerItems(player)) 
			end)
		end
		query('CREATE TABLE IF NOT EXISTS Inventario (Jugador TEXT, Item TEXT, Value INTEGER)')
	end
	)

addEventHandler("onPlayerLogin", getRootElement(), function()
	bindKey(source,"i","down", function(player)
		triggerClientEvent(player, 'Open:Inventory', player, getPlayerItems(player)) 
	end)
end)


function setPlayerItem(player, name, valor)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
	if #qh <= 0 then
		insert("INSERT INTO Inventario VALUES (?,?,?)", AccountName( player ), name, valor)
	else
		if tonumber(valor) == 0 or tonumber(valor) < 0 then
			delete("DELETE FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
		else
			update("UPDATE Inventario SET Value='"..valor.."' WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
		end
	end
end

function getPlayerItem(player, name)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
	if #qh ~= 0 then
		return tonumber(qh[1]["Value"])
	end
	return 0
end

function getReNameItem(player, name, newname)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."' AND Item='"..name.."'")
	if #qh ~= 0 then
		databaseUpdate("UPDATE Inventario SET Item=? WHERE Jugador='"..AccountName( player ).."'", newname)
	end
end

function getPlayerItems(player)
	local qh = query("SELECT * FROM Inventario WHERE Jugador='"..AccountName( player ).."'")
	if #qh ~= 0 then
		return qh
	end
	return {}
end

addEvent( 'Refresh:Inventory', true)
addEventHandler( 'Refresh:Inventory', root,
	function(name, valor)
		local pAccount = source:getAccount()
		if tonumber(valor) <= getPlayerItem(source, name) then

			local tipo, valor = table.find(Objetos, name)
			if tipo == "bebida" then
				if pAccount:getData("Estomago") == "No" then
					source:outputChat("* No puedes beber por una razon extraña", 255, 200, 0)
					return
				end
				local old_value = math.ceil(source:getData('need.thirsty')) or 0
				if (old_value == 100 ) then
					return
				end
				if old_value+valor > 100 then
					valor = 100
				else
					valor = old_value + valor
				end
				source:setData('need.thirsty', valor)
				source:setAnimation("VENDING", "VEND_Drink2_P", -1, true, false, false)
				setTimer(function(p)
					setPedAnimation(p)
				end, 2000, 1, source)

				setPlayerItem(source, name, getPlayerItem(source, name)-1)
			elseif tipo == "hambre" then
				if pAccount:getData("Estomago") == "No" then
					source:outputChat("* No puedes comer por una razon extraña", 255, 200, 0)
					return
				end
				local old_value = math.ceil(source:getData('need.hungry')) or 0
				if (old_value == 100 ) then
					return
				end
				if old_value+valor > 100 then
					valor = 100
				else
					valor = old_value + valor
				end
				source:setData('need.hungry', valor)
				source:setAnimation("FOOD", "EAT_Chicken", -1, true, false, false)
				setTimer(function(p)
					setPedAnimation(p)
				end, 2000, 1, source)

				setPlayerItem(source, name, getPlayerItem(source, name)-1)
			end
			if name == "Caja de Cigarros" then
				if getPlayerItem(source, "Encendedor") >= 1 then
					source:setData("TextInfo", {"> Saca un cigarro y lo enciende", 255, 0, 216})
					setTimer(function(p)
						p:setData("TextInfo", {"", 255, 0, 216})
					end, 3000, 1, source)
					source:setAnimation("GANGS", "drnkbr_prtl", 1, false,false)
					setPlayerItem(source, name, getPlayerItem(source, name)-1)
					setPlayerItem(source, "Encendedor", getPlayerItem(source, "Encendedor")-1)
				else
					exports['[LS]Notificaciones']:setTextNoti(source,"Para fumar 1 cigarro debes tener un encendedor en tu inventario", 150, 50, 50, true)
				end
			end
			if name == "Bidon de Gasolina" then
				local veh = getPlayerNearbyVehicle(source)
				if veh then
					local gas = getElementData(veh, "Fuel")
					if gas <= 90 then
						source:setData("TextInfo", {"> Usa su bidon de gasolina y abre el tanque del vehículo para llenarlo", 255, 0, 216})
						setTimer(function(p)
							p:setData("TextInfo", {"", 255, 0, 216})
						end, 2000, 1, source)
						source:setAnimation("COP_AMBIENT", "Copbrowse_loop", -1,true, false, false)
						setElementData(veh, "Fuel", 100)
						setTimer(function(p, veh)
							setPedAnimation(p)
						end, 2000, 1, source, veh)
						setPlayerItem(source, name, getPlayerItem(source, name)-1)
					else
						exports['[LS]Notificaciones']:setTextNoti(source,"Este vehiculo ya tiene la gasolina llena", 150, 50, 50, true)
					end
				end
			elseif name == "Caja de Herramientas" then
				local vehF = getPlayerNearbyVehicle(source)
				if vehF then
					local health = getElementHealth(vehF)
					if health < 900 then
						local rx, ry, rz = getElementRotation(vehF)
						source:setData("TextInfo", {"> Usa su bidon de gasolina y abre el tanque del vehículo para llenarlo", 255, 0, 216})
						setTimer(function(p) p:setData("TextInfo", {"", 255, 0, 216}) end, 2000, 1, source)
						source:setAnimation("COP_AMBIENT", "Copbrowse_loop", -1,true, false, false)
						fixVehicle(vehF)
						setElementRotation(vehF, 0, ry, rz)
						setTimer(function(p, vehF) setPedAnimation(p) end, 2000, 1, source, vehF) 
						setPlayerItem(source, name, getPlayerItem(source, name)-1)
					else
						exports['[LS]Notificaciones']:setTextNoti(source,"Este vehiculo ya tiene toda la vida", 150, 50, 50, true)
					end
				end
			elseif name == "Ganzuas" then
				local vehG = getPlayerNearbyVehicle(source)
				if vehG then
					local locked = vehG:isLocked()
					if locked == true then
						source:setAnimation('BD_FIRE', 'wash_up', -1, true, false, false)
						vehG:setLocked(false)
						setTimer(function(p, vehF) setPedAnimation(p) end, 10000, 1, source, vehF) 
						setPlayerItem(source, name, getPlayerItem(source, name)-1)
					else
						exports['[LS]Notificaciones']:setTextNoti(source,"Este vehiculo ya esta abierto", 150, 50, 50, true)
					end
				end
			elseif name == "Medicamentos" then
				local health = source:getHealth()
				if health <= 40 then
					source:setHealth(health + 10)
					exports['[LS]Notificaciones']:setTextNoti(source, "Acabas de consumir Medicamentos", 150, 50, 50, true)
				else
					exports['[LS]Notificaciones']:setTextNoti(source, "No puedes consumir mas medicamentos (+40% Vida)", 150, 50, 50, true)
				end
			end
			triggerClientEvent(source, 'Open:Inventory', source, getPlayerItems(source),'refresh')
		end
	end
	)

local armasValidas = {
	["Colt 45"] = true,
	["Silenced"] = true,
	["Deagle"] = true,
	["Shotgun"] = true,
	["Combat Shotgun"] = true,
	["Uzi"] = true,
	["MP5"] = true,
    ["Tec-9"] = true,
    ["AK-47"] = true,
    ["M4"] = true,
    ["Rifle"] = true,
    ["Sniper"] = true,
}

addEvent( 'TiraItem:Inventory', true)
addEventHandler( 'TiraItem:Inventory', root,
	function(name, valor)
		if armasValidas[name] == true then
			if tonumber(valor) <= 0 then
				takeWeapon(source, getWeaponIDFromName(name), 99999)
				triggerClientEvent(source, 'Open:Inventory', source, getPlayerItems(source), 'refresh')
				print(AccountName(source)..", "..name..", "..valor)
				return
			end
			local posicion1 = Vector3(source:getPosition())
			local x, y, z = posicion1.x, posicion1.y, posicion1.z
			exports["[POPLife]Weapons"]:createWeaponGround(getWeaponIDFromName(name), valor, x, y, z, source:getInterior(), source:getDimension())
			takeWeapon(source, getWeaponIDFromName(name), 99999)
			triggerClientEvent(source, 'Open:Inventory', source, getPlayerItems(source),'refresh')
		end
		if tonumber(valor) <= getPlayerItem(source, name) then
			setPlayerItem(source, name, getPlayerItem(source, name)-1)
			triggerClientEvent(source, 'Open:Inventory', source, getPlayerItems(source),'refresh')
		end
	end
)

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

Objetos = { 
	['hambre'] = {
		["Pizzeta"] = 30,
		["Pizza Chica"] = 20,
		["Pizza Grande"] = 70,
		["Hamburguesa"] = 15,
		["Hamburguesa Chica"] = 10,
		["Hamburguesa Grande"] = 25,
		["Pata de Pollo"] = 10,
		["Hamb. de Pollo"] = 15,
		["Pollo Asado"] = 30,
		["Galleta"] = 10,
	},
	--
	['bebida'] = {
		["Cerveza"] = 10,
		["Agua"] = 20,
		["Lata de Spray"] = 30,
	}
}
--{"Caja de Cigarros", 50},
--{"Encendedor", 25},
--

function table.find(t, item)
	for tipo,comida in pairs(t) do
		for index,value in pairs(comida) do
			if (index == item) then
				return tipo,value
			end
		end
	end
	return false
end

local items = { 
	{"Telefono"},
	{"Agenda"},
	{"Camara"},
	{"Bidon Vacio"},
	{'Bidon de Gasolina'},
	{'Caja de Herramientas'},
	{"Lata de Spray"},
	{"Pizzeta"},
	{"Pizza Chica"},
	{"Pizza Grande"},
	{"Ganzuas"},
	--
	{"Pata de Pollo"},
	{"Hamb. de Pollo"},
	{"Pollo Asado"},
	--
	{"Cerveza"},
	{"Agua"},
	{"Caja de Cigarros"},
	{"Encendedor"},
	--
	{"Hamburguesa"},
	{"Hamburguesa Chica"},
	{"Hamburguesa Grande"}
}

function isItemExist(itemName)
	for _,v in pairs(items) do
		if (v[1]:lower()) == (itemName:lower()) then
			return v[1]
		end
	end
	return false
end