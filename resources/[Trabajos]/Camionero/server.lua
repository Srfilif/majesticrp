loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')

local pick = Pickup( 2756.1435546875, -2517.81640625, 13.639174461365,3, 1239, 0)

local care = {}

local car = {}

addEventHandler("onResourceStart", resourceRoot, function()

	local x,y,z =  2755.8935546875, -2515.345703125, 13.639777183533

	Blip( x, y, z, 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

	Pickup( x, y, z, 3, 1210, 0)

	MarkersCamionero = Marker( x, y, z-1, "cylinder", 1.5, 100, 100, 100, 0)

end)

addEventHandler("onPickupHit",pick,function(source)
	bindKey(source,"F", "down",verpanel)
end)

addEventHandler("onPickupLeave",pick,function(source)
	unbindKey(source,"F", "down",verpanel)
end)

local cars = {

{499},
{609},
--{498},
--{573},
--{455},
--{414},
--{456},

}

function verpanel(player,cmd)
	if player:getData("Roleplay:trabajo") == "Camionero" then
		triggerClientEvent(player,"panelcamio",player)
	end
end
-- Tabla para almacenar vehículos por propietario


function crearveh(player)
    if source:getData("Roleplay:trabajo") == "Camionero" then
       -- if car[source] == nil then
            car[source] = true
            local x, y, z = 2764.462890625, -2508.7177734375, 13.627556800842
            local cars = cars[math.random(1, #cars)]
            car[source] = createVehicle(cars[1], x, y, z)
            car[source]:setRotation(0, 0, 358)
            car[source]:setPlateText("Camionero")
            car[source]:setData('Locked', 'Cerrado')
            car[source]:setData('Motor', 'apagado')
            car[source]:setData('ID', "Camionero "..math.random(1,1000))

            car[source]:setData('Fuel', 100)
            car[source]:setLocked(true)
			local accname = getAccountName(getPlayerAccount(source)) 
            car[source]:setData("Owner", accname)
            car[source]:setFrozen(true)
           -- car[source]:setData("VehiculoPublico", "Camionero")
            source:outputChat("[INFO] Tu camión ha sido creado y está bloqueado.", 100, 255, 100, true)
       -- else
            source:outputChat("[ERROR] Ya tienes un camión Respawneado", 255, 100, 100, true)
        --end
    else
        source:outputChat("[ERROR] NO tienes este trabajo", 255, 100, 100, true)
    end
end
addEvent("respawnveh", true)
addEventHandler("respawnveh", root, crearveh)




addEvent("trans",true)
addEventHandler("trans",root,function(alpha)
	local veh = getPedOccupiedVehicle (source)
	setElementAlpha(veh,alpha)
end)

addEvent('destroycamm',true)
addEventHandler('destroycamm',root,function()
	if isElement(car[source]) then
		care[source] = nil
		car[source]:destroy()
	end
end)

addEvent("vehCamionero",true)
addEventHandler("vehCamionero",root,function()
	for i,source in ipairs(Element.getAllByType("player")) do
		if care[source] == true then
			care[source] = nil
		end
	end
end)


local posiciones_c = {

	pos_camion = {
		{2771.994140625, -2518.84765625, 13.64148235321,0, 0, 356.72326660156},
		{2771.994140625+4, -2518.84765625, 13.64148235321,0, 0, 356.72326660156},
		{2771.994140625+8, -2518.84765625, 13.64148235321,0, 0, 356.72326660156},
		{2771.994140625, -2518.84765625-3, 13.64148235321,0, 0, 356.72326660156},
		{2771.994140625+4, -2518.84765625-3, 13.64148235321,0, 0, 356.72326660156},
		{2771.994140625+8, -2518.84765625-3, 13.64148235321,0, 0, 356.72326660156},
	}

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


addCommandHandler("trabajar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:isWithinMarker(MarkersCamionero) then
				if player:getData("Roleplay:trabajo") == "Camionero" then
					player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
				else
					player:setData("Roleplay:trabajo", "Camionero")
					player:outputChat("¡Bienvenido al trabajo de #ffff00Camionero#ffffff!", 255, 255, 255, true)
				end
			end
		end
	end
end)

addCommandHandler("infocamionero", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:isWithinMarker(MarkersCamionero) then
				player:outputChat("¡Bienvenidos al trabajo de #ffff00Camionero#ffffff!", 255, 255, 255, true)
				player:outputChat("Elije la ruta segun tu nivel entre mas entregas realizes mas rutas tendras", 255, 255, 255, true)
				player:outputChat("Recarga tu camion entregalo y gana dinero", 255, 255, 255, true)
			end
		end
	end
end)

addCommandHandler("renunciar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:isWithinMarker(MarkersCamionero) then
				if player:getData("Roleplay:trabajo") == "Camionero" then
					player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
					player:setData("Roleplay:trabajo", "")
					triggerClientEvent(player,"failedMissionCam", player, player)
				else								
					player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
					player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)
				end
			end
		end
	end
end)


addEvent("giveMoneyCamionero", true)
function giveMoneyCamionero(cash)
	local exp = source:getData("Camionero:Nivel") or 1
	source:giveMoney(tonumber(cash))
	source:outputChat("#FFFFFFAcabas de ganar: #004500$"..convertNumber(cash).." dólares #ffffffpor la entrega.", 255, 255, 255, true)
end
addEventHandler("giveMoneyCamionero", root, giveMoneyCamionero)

local Levels = {
{5000, 1},
{10000, 2},
{30000, 3},
{50000, 4},
}

function setNivel()
	local nivel = tonumber(source:getData("Camionero:Nivel")) or 1
	local actualExp = source:getData("Camionero:Exp") or 0
	if nivel == #Levels then
		exports['Notificaciones']:setTextNoti(source, '¡Estas en tu nivel maximo!', 0,255,0, true)
	elseif nivel < #Levels then
		local nuevaExp = 100
		if actualExp + nuevaExp >= Levels[nivel][1] then
			source:setData("Camionero:Nivel",nivel+1)
			source:setData("Camionero:Exp",Levels[nivel][1]-(actualExp + nuevaExp))
			source:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFy subiste al #00FF00nivel "..(nivel+1).." #FFFFFFpor trabajar!", 255, 255, 255, true)
		elseif actualExp + nuevaExp < Levels[nivel][1] then
			source:setData("Camionero:Exp", actualExp+nuevaExp)
			source:outputChat("¡Recibiste: #dd80ff +100 de exp #FFFFFFpor trabajar", 255, 255, 255, true)
		end
	end
end
addEvent("giveCamioneroExp",true)
addEventHandler("giveCamioneroExp", root,setNivel)

