loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')


local car = {}

local care = {}

local pick = Pickup(-69.2841796875, -1548.8046875, 2.6171875,3, 1239, 0)

addEventHandler("onResourceStart", resourceRoot, function()

	local x,y,z = -80.986328125, -1554.744140625, 2.6171875

	Blip( x, y, z, 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

	Pickup( x, y, z, 3, 1210, 0)

	MarkersBasurero = Marker( x, y, z-1, "cylinder", 1.5, 100, 100, 100, 0)

end)

addEventHandler("onPickupHit",pick,function(source)
	bindKey(source,"F", "down",crearveh)
end)

addEventHandler("onPickupLeave",pick,function(source)
	unbindKey(source,"F", "down",crearveh)
end)

function crearveh(source)
	if source:getData("Roleplay:trabajo") == "Basurero" then
		if care[source] == nil then
			care[source] = true
			local x,y,z = getElementPosition(source)
			car[source] = createVehicle(408,x+5,y-2,z)
			car[source]:setRotation(0,0,137)
			car[source]:setPlateText("Basurero")
			car[source]:setData('Locked', 'Cerrado')
			car[source]:setData("VehiculoPublico", "Basurero")
			car[source]:setData('Motor','apagado')
			car[source]:setData('Fuel',100)
			car[source]:setLocked(true)
			car[source]:setEngineState (false)
			car[source]:setFrozen(true)
		else
			source:outputChat("[ERROR] Ya tienes un camión Respawneado",255, 100, 100, true)
		end
	else
		source:outputChat("[ERROR] NO tienes Este trabajo",255, 100, 100, true)
	end
end


addEvent('destroybass',true)
addEventHandler('destroybass',root,function()
	if isElement(car[source]) then
		care[source] = nil
		car[source]:destroy()
	end
end)

addEvent("vehBasurero",true)
addEventHandler("vehBasurero",root,function()
	for i,source in ipairs(Element.getAllByType("player")) do
		if care[source] == true then
			care[source] = nil
		end
	end
end)

addCommandHandler("trabajar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:isWithinMarker(MarkersBasurero) then
				if player:getData("Roleplay:trabajo") == "Basurero" then
					player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
				else
					player:setData("Roleplay:trabajo", "Basurero")
					player:triggerEvent("iniciarRutaBasurero", player, "LS")
					player:outputChat("¡Bienvenido al trabajo de #ffff00Basurero#ffffff!", 255, 255, 255, true)
				end
			end
		end
	end
end)

addCommandHandler("infobasurero", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:isWithinMarker(MarkersBasurero) then
				player:outputChat("¡Bienvenidos al trabajo de #ffff00Basurero#ffffff!", 255, 255, 255, true)
				player:outputChat("Súbete a un camión y sigue la ruta de tu GPS, ¡Cuiado con ensuciarte!. ", 255, 255, 255, true)
				player:outputChat("Usa sabiamente lo que encuentres entre la basura chico.", 255, 255, 255, true)
			end
		end
	end
end)

addCommandHandler("renunciar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:isWithinMarker(MarkersBasurero) then
				if player:getData("Roleplay:trabajo") == "Basurero" then
						player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
						player:setData("Roleplay:trabajo", "")
						player:triggerEvent("failedMissionBas", player)
				else								
						player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
						player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)
				end
			end
		end
	end
end)

addEvent("giveMoneyBasurero", true)
function giveMoneyBasurero()
	local exp = source:getData("Basurero:Nivel") or 1
	local totalMoney = math.ceil(math.random(80,100)*exp)
	source:giveMoney(tonumber(totalMoney))
	source:outputChat("#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." dólares #ffffffpor la ruta.", 255, 255, 255, true)
end
addEventHandler("giveMoneyBasurero", root, giveMoneyBasurero)

local Levels = {
{1000, 1},
{2000, 2},
{3000, 3},
{4000, 4},
}

function setNivel()
	local nivel = tonumber(source:getData("Basurero:Nivel")) or 1
	local actualExp = source:getData("Basurero:Exp") or 0
	if nivel == #Levels then
		exports['Notificaciones']:setTextNoti(source, '¡Estas en tu nivel maximo #ff0000visio#ffffff!', 0,255,0, true)
	elseif nivel < #Levels then
		local nuevaExp = 100
		if actualExp + nuevaExp >= Levels[nivel][1] then
			source:setData("Basurero:Nivel",nivel+1)
			source:setData("Basurero:Exp",Levels[nivel][1]-(actualExp + nuevaExp))
			source:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFy subiste al #00FF00nivel "..(nivel+1).." #FFFFFFpor trabajar!", 255, 255, 255, true)
		elseif actualExp + nuevaExp < Levels[nivel][1] then
			source:setData("Basurero:Exp", actualExp+nuevaExp)
			source:outputChat("¡Recibiste: #dd80ff +100 de exp #FFFFFFpor trabajar", 255, 255, 255, true)
		end
	end
end
addEvent("giveBasureroExp",true)
addEventHandler("giveBasureroExp", root,setNivel)