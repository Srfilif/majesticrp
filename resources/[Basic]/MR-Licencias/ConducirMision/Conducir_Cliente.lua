local ValoresTrabajo = {}
local PosicionAuto = {}
local MarcadoresRuta = {}
local BlipsRuta = {}

local RutaConducir1 = {
[1]={2064.416015625, -1912.3388671875, 13.204036712646, 1171.5179443359, -1740.4997558594, 13.411440849304},
[2]={2083.951171875, -1909.5947265625, 13.039238929749, 1172.8159179688, -1834.8896484375, 13.405555725098},
[3]={2083.7294921875, -1828.6865234375, 13.037769317627, 1287.8439941406, -1854.8884277344, 13.3828125},
[4]={2064.431640625, -1809.568359375, 13.032064437866, 1407.3887939453, -1874.8806152344, 13.3828125},
[5]={1976.5986328125, -1810.05859375, 13.032787322998, 1550.9327392578, -1874.7060546875, 13.3828125},
[6]={1963.98828125, -1765.32421875, 13.035923957825, 1669.7264404297, -1872.8951416016, 13.3828125},
[7]={1943.6640625, -1739.197265625, 13.035768508911, 1691.5083007813, -1749.9709472656, 13.391266822815},
[8]={1944.3115234375, -1624.3798828125, 13.031071662903, 1804.9528808594, -1734.9898681641, 13.390607833862},
[9]={1905.162109375, -1609.7373046875, 13.034226417542, 1925.0284423828, -1754.5627441406, 13.3828125},
[10]={1819.076171875, -1636.90234375, 13.034253120422, 2070.1467285156, -1754.607421875, 13.393966674805},
[11]={1818.9140625, -1716.115234375, 13.03554725647, 2083.8391113281, -1628.2180175781, 13.3828125},
[12]={1818.75, -1794.48046875, 13.036359786987, 2183.5725097656, -1642.0362548828, 15.13805103302},
[13]={1818.7685546875, -1921.060546875, 13.033825874329, 2214.6547851563, -1398.8734130859, 23.820301055908},
[14]={1868.1923828125, -1934.61328125, 13.035779953003, 2127.1345214844, -1381.8659667969, 23.835897445679},
[15]={1944.4091796875, -1934.2646484375, 13.032531738281, 2072.7497558594, -1358.3022460938, 23.828157424927},
[16]={2044.998046875, -1934.0986328125, 12.99766254425, 2073.2590332031, -1234.6392822266, 23.808801651001},
[17]={2053.892578125, -1913.619140625, 13.202722549438},
}

--[[for i, v in ipairs(RutaConducir1) do
	local x, y, z = RutaConducir1[i][1], RutaConducir1[i][2], RutaConducir1[i][3]
	local x2, y2, z2 = RutaConducir1[i][4], RutaConducir1[i][5], RutaConducir1[i][6]
	mark = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
	createBlipAttachedTo(mark, 0, 2, 200, 200, 0, 255)
	if i <= 37 then
		setMarkerTarget(mark, x2, y2, z2)
		setMarkerIcon ( mark, "arrow" )
	else
		setMarkerIcon ( mark, "finish" )
	end
end]]

function startMision(tip, ruta)
	if localPlayer:getData("Roleplay:Mision") == "Licencia" then
		if tip == "Conducir" then
			if ruta == 1 then
				ValoresTrabajo[localPlayer][1] = tonumber(#RutaConducir1)
				--
				for i=1, #RutaConducir1 do
					if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
						local x, y, z = RutaConducir1[i][1], RutaConducir1[i][2], RutaConducir1[i][3]
						local x2, y2, z2 = RutaConducir1[i][4], RutaConducir1[i][5], RutaConducir1[i][6]
						MarcadoresRuta[i] = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
						BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 200, 200, 0, 255)
						--
						if i <= 37 then
							setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
							setMarkerIcon ( MarcadoresRuta[i], "arrow" )
						else
							setMarkerIcon ( MarcadoresRuta[i], "finish" )
						end
						--
						addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onMarkerRutHit)
					end
				end
			end
		end
	end
end

function onMarkerRutHit( hitElement )
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:isInVehicle() then
			if hitElement:getData("Roleplay:Mision") == "Licencia" and ValoresTrabajo[hitElement][3] == true then
				local veh = hitElement:getOccupiedVehicle()
				local seat = hitElement:getOccupiedVehicleSeat()
				if veh:getModel() == 410 and seat == 0 then
					if ValoresTrabajo[hitElement][1] ==ValoresTrabajo[hitElement][2] then
						local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
						veh:setPosition(x, y, z)
						veh:setRotation(x2, y2, z2)
						veh:setLocked(true)
						veh:setFrozen(true)
						veh:setEngineState(false)
						setTimer(function(hit)
							ValoresTrabajo[hit] = nil
						end, 1000, 1, hitElement)
						triggerServerEvent("ObtenerLicencia", hitElement)
						table.remove(PosicionAuto, 1)
						hitElement:setControlState("enter_exit", true)
						setTimer(function(hitElement)
							if isElement(hitElement) then
								hitElement:setControlState("enter_exit", false)
							end
						end, 1000, 1, hitElement)
					else
						ValoresTrabajo[hitElement][2] = ValoresTrabajo[hitElement][2] + 1
						setTimer(startMision, 50, 1, "Conducir", 1)
					end
					for i=1, #RutaConducir1 do
						if i <= ValoresTrabajo[hitElement][2] then
							if isElement(MarcadoresRuta[i]) then
								destroyElement(MarcadoresRuta[i])
							end
								if isElement(BlipsRuta[i]) then
								destroyElement(BlipsRuta[i])
							end
						end
					end
				end
			end
		end
	end
end

addEvent("IniciarRutaLicencia", true)
function IniciarRutaLicencia(tip)
	if tip == "Conducir" then
		for i=1, #RutaConducir1 do
			if isElement(MarcadoresRuta[i]) then
				destroyElement(MarcadoresRuta[i])
			end
			if isElement(BlipsRuta[i]) then
				destroyElement(BlipsRuta[i])
			end
		end
		ValoresTrabajo[localPlayer] = {nil, 1, true}
		startMision("Conducir", 1)
		failedMision("Conducir", localPlayer, nil, 20)
	end
end
addEventHandler("IniciarRutaLicencia", root, IniciarRutaLicencia)

local TableFailed = {}
local TimerK = {}
local tableN = {}

addEventHandler("onClientPlayerQuit", getRootElement(), function()
	source:setData("Roleplay:Mision", "")
	for i=1, #RutaConducir1 do
		if isElement(MarcadoresRuta[i]) then
			destroyElement(MarcadoresRuta[i])
		end
		if isElement(BlipsRuta[i]) then
			destroyElement(BlipsRuta[i])
		end
	end
	ValoresTrabajo[source] = {nil, 1, false}
	--
	TableFailed[source] = nil;
	TimerK[source] = nil;
	tableN[source] = nil;
	--
	table.remove(PosicionAuto, 1)
end)

addEventHandler("onClientVehicleExit", getRootElement(),
	function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 410 then
        			if thePlayer:getData("Roleplay:Mision") == "Licencia" and ValoresTrabajo[thePlayer][3] == true then
        				outputChatBox("Tienes 30 segundos para subir al vehículo o se cancelara la misión.", 150, 50, 50, true)
        				failedMision("Conducir", thePlayer, source, 30)
        			end
        		end
        	end
        end
	end
)

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer() then
        	if seat == 0 then
        		if source:getModel() == 410 then
        			if thePlayer:getData("Roleplay:Mision") == "Licencia" and ValoresTrabajo[thePlayer][3] == true then
        				if tableN[thePlayer] == true then
        					if isTimer(TimerK[thePlayer]) then
        						killTimer(TimerK[thePlayer])
								TimerK[thePlayer] = nil;
								tableN[thePlayer] = nil;
        						outputChatBox("¡Perfecto sigue con la misión!", 50, 150, 50, true)
        					end
        				end
        				if not TableFailed[thePlayer] then
        					TableFailed[thePlayer] = not TableFailed[thePlayer]
	        				local x, y, z = getElementPosition(thePlayer)
	        				local x2, y2, z2 = getElementRotation(thePlayer)
	        				table.insert(PosicionAuto, {x, y, z, x2, y2, z2})
	        				triggerEvent("callCinematic", localPlayer, "Conduce por los #FFFF00marcadores #ffffffintenta no ir tan rapido ni chocarte", 20000, "No")
	        			end
        			end
        		end
        	end
        end
    end
)

function failedMision(tip, thePlayer, vehiculo, timer)
	if tip == "Conducir" then
		tableN[thePlayer] = true
		TimerK[thePlayer] = setTimer(function(p, veh)
			if isElement(p) and isElement(veh) then
				p:setData("Roleplay:Mision", "")
				for i=1, #RutaConducir1 do
					if isElement(MarcadoresRuta[i]) then
						destroyElement(MarcadoresRuta[i])
					end
					if isElement(BlipsRuta[i]) then
						destroyElement(BlipsRuta[i])
					end
				end
				ValoresTrabajo[p] = {nil, 1, false}
				if veh and veh ~= nil then
					local x, y, z, x2, y2, z2 = unpack(PosicionAuto[1])
					veh:setPosition(x, y, z)
					veh:setRotation(x2, y2, z2)
					veh:setLocked(true)
					veh:setFrozen(true)
					veh:setEngineState(false)
				end
				--
				TableFailed[p] = nil;
				TimerK[p] = nil;
				tableN[p] = nil;
				--
				table.remove(PosicionAuto, 1)
			end
		end, timer*1000, 1, thePlayer, vehiculo)
	end
end