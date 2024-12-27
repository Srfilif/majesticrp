	loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local MarkersPizzero = {}
local pick = Pickup(2110.8359375, -1787.658203125, 13.560846328735,3, 1239, 0)
local pick2 = Pickup(2117.2470703125, -1787.611328125, 13.560846328735,3,1239,0)
local mope = {}
local moto = {}



addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in ipairs(getJobsPizzero()) do
		--
		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )
		--
		Pickup(v[1], v[2], v[3], 3, 1210, 0)
		MarkersPizzero[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)
		MarkersPizzero[i]:setInterior(v.int)
		MarkersPizzero[i]:setDimension(v.dim)
		MarkersPizzero[i]:setData("MarkerJob", "Pizzero")
	end
end)

addEventHandler("onPickupHit",pick,function(source)
	bindKey(source,"F", "down",crearveh)
end)

addEventHandler("onPickupLeave",pick,function(source)
	unbindKey(source,"F", "down",crearveh)
end)

addEventHandler("onPickupHit",pick2,function(source)
	bindKey(source,"F", "down",destroy)
end)

addEventHandler("onPickupLeave",pick2,function(source)
	unbindKey(source,"F", "down",destroy)
end)


function crearveh(source)
	if source:getData("Roleplay:trabajo") == "Pizzero" then
		if mope[source] == nil then
			mope[source] = true
			local x,y,z = getElementPosition(source)
			moto[source] = createVehicle(448,x,y+3,z)
			moto[source]:setPlateText("Pizzero")
			moto[source]:setData('Locked', 'Cerrado')
			moto[source]:setData('Motor','apagado')
			moto[source]:setData("VehiculoPublico", "Pizzero")
			moto[source]:setData('Fuel',100)
			moto[source]:setLocked(true)
			moto[source]:setEngineState(false)
		else
			source:outputChat("[ERROR] Ya tienes una Moto Respawneada",255, 100, 100, true)
		end
	else
		source:outputChat("[ERROR] NO tienes Este trabajo",255, 100, 100, true)
	end
end

function destroy(source)
	if mope[source] == true then
		if source:isInVehicle() then
			if isElement(moto[source]) then
				mope[source] = nil
				moto[source]:destroy()
			end
		else
			source:outputChat("[ERROR] Tienes que estar encima de tu vehiculo",255, 100, 100, true)
		end
	else
		source:outputChat("[ERROR] No tienes una moto por eliminar",255, 100, 100, true)
	end
end
addEvent('destroypizz',true)
addEventHandler('destroypizz',root,function()
	if isElement(moto[source]) then
		mope[source] = nil
		moto[source]:destroy()
	end
end)


addEvent("vehPizzero",true)
addEventHandler("vehPizzero",root,function()
	for i,source in ipairs(Element.getAllByType("player")) do
		if mope[source] == true then
			mope[source] = nil
		end
	end
end)

--
addCommandHandler("trabajar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:getData("Roleplay:trabajo") == "" then
				for i, marker in ipairs(MarkersPizzero) do
					if player:isWithinMarker(marker) then
						local job = marker:getData("MarkerJob")
						if job == "Pizzero" then
							if player:getData("Roleplay:trabajo") == "Pizzero" then
								player:outputChat("¡Ya estas trabajando aquí!", 150, 50, 50, true)
							else
								player:setData("Roleplay:trabajo", "Pizzero")
								--
								player:triggerEvent("IniciarPizzero", player)
								player:setData("PizzeroPedidos", false)
								--
								player:outputChat("¡Bienvenido al trabajo de #ffff00pizzero#ffffff!", 255, 255, 255, true)
							end
						end
					end
				end
			end
		end
	end
end)
--
addCommandHandler("infopizzero", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			for i, v in ipairs(MarkersPizzero) do
				if player:isWithinMarker(v) then
					local job = v:getData("MarkerJob")
					if job == "Pizzero" then
						player:outputChat("¡Bienvenidos al trabajo de #ffff00Pizzero#ffffff!", 255, 255, 255, true)
						player:outputChat("Súbete a una pizzaboy y conduce hacia atrás de The Well Stacked Pizza Co. ", 255, 255, 255, true)
						player:outputChat("Y usa el comando /obtenerpedidos para comenzar a repartir.", 255, 255, 255, true)
						player:outputChat("¡Conduce bien o te regañarán!", 255, 255, 255, true)
					end
				end
			end
		end
	end
end)
--
addCommandHandler("renunciar", function(player, cmd)
	if not notIsGuest(player) then
		if not player:isInVehicle() then
			if player:getData("Roleplay:trabajo") ~="" then
				for i, v in ipairs(MarkersPizzero) do
					if player:isWithinMarker(v) then
						local job = v:getData("MarkerJob")
						if job == "Pizzero" then
							if player:getData("Roleplay:trabajo") == "Pizzero" then
								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)
								player:setData("Roleplay:trabajo", "")
								player:setData("PizzeroPedidos", false)
								player:triggerEvent("failedMission", player)
								triggerEvent("destroypizz",player)
							else
								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
								player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)
							end
						end
					end
				end
			end
		end
	end
end)
--

addEventHandler("onPlayerLogin",root,function(player)
	player:setData("Roleplay:trabajo","")
end)

addCommandHandler("t",function(player,cmd)

player:setData("Roleplay:trabajo","")
end)

addEvent("giveMoneyPizzero", true)
function giveMoneyPizzero()
	local propinarandom = math.random(1,6)
	local exp = source:getData("Pizzero:Nivel") or 1
	local totalMoney = math.ceil(math.random(30,40)*exp/2)
	local propina = math.random(5,15)
	--
	if propinarandom == 4 then
		text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." dólares #ffffff + #004500$"..convertNumber(propina).." #FFFFFF de propina por la entrega."
		source:giveMoney(tonumber(totalMoney + propina))
	elseif propinarandom == 5 then
		text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." dólares #ffffff + #004500$"..convertNumber(propina).." #FFFFFF de propina por la entrega."
		source:giveMoney(tonumber(totalMoney + propina))
	else
		text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." dólares #ffffffpor la entrega."
		source:giveMoney(tonumber(totalMoney))
	end
	source:outputChat(text, 255, 255, 255, true)
end
addEventHandler("giveMoneyPizzero", root, giveMoneyPizzero)


addEvent("FailedMissionPizzero", true)
function FailedMissionPizzero(placa)
	source:setData("PizzeroPedidos", false)
end
addEventHandler("FailedMissionPizzero", root, FailedMissionPizzero)


local Levels = {
{2000, 1},
{3000, 2},
{4000, 3},
{5000, 4},
}

function setNivel()
	local nivel = tonumber(source:getData("Pizzero:Nivel")) or 1
	local actualExp = source:getData("Pizzero:Exp") or 0
	if nivel == #Levels then
		exports['Notificaciones']:setTextNoti(source, '¡Estas en tu nivel maximo #ff0000visio#ffffff!', 0,255,0, true)
	elseif nivel < #Levels then
		local nuevaExp = 100
		if actualExp + nuevaExp >= Levels[nivel][1] then
			source:setData("Pizzero:Nivel",nivel+1)
			source:setData("Pizzero:Exp",Levels[nivel][1]-(actualExp + nuevaExp))
			source:outputChat("¡Recibiste: #dd80ff +"..nuevaExp.." de exp #FFFFFFy subiste al #00FF00nivel "..(nivel+1).." #FFFFFFpor trabajar!", 255, 255, 255, true)
		elseif actualExp + nuevaExp < Levels[nivel][1] then
			source:setData("Pizzero:Exp", actualExp+nuevaExp)
			source:outputChat("¡Recibiste: #dd80ff +100 de exp #FFFFFFpor trabajar", 255, 255, 255, true)
		end
	end
end
addEvent("givePizzeroExp",true)
addEventHandler("givePizzeroExp", root,setNivel)