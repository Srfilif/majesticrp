local sx_, sy_ = guiGetScreenSize()

local sx, sy = sx_/1360, sy_/768



local ValoresTrabajo = {}

local MarcadoresRuta = {}

local BlipsRuta = {}

local tableN = {}

local TimerK = {}

function startRutaBasurero(ruta)
	if localPlayer:getData("Roleplay:trabajo") == "Basurero" then
		if ruta == 1 then
			ValoresTrabajo[localPlayer][1] = tonumber(#MarkerMissionBasurero)
			ValoresTrabajo[localPlayer][4] = tonumber(ruta)
			for i=1, #MarkerMissionBasurero do
				if i >= ValoresTrabajo[localPlayer][2] and i <= ValoresTrabajo[localPlayer][2] then
					local x, y, z = MarkerMissionBasurero[i][1], MarkerMissionBasurero[i][2], MarkerMissionBasurero[i][3]
					local x2, y2, z2 = MarkerMissionBasurero[i][4], MarkerMissionBasurero[i][5], MarkerMissionBasurero[i][6]
					MarcadoresRuta[i] = Marker(x, y, z - 1, "checkpoint", 3, 255, 255, 0, 100)
					BlipsRuta[i] = createBlipAttachedTo(MarcadoresRuta[i], 0, 2, 50, 150, 50, 255)

					linea3d(x, y, z,localPlayer)

					if i <= 13 then
						setMarkerTarget(MarcadoresRuta[i], x2, y2, z2)
						setMarkerIcon ( MarcadoresRuta[i], "checkpoint" )
					else
						setMarkerIcon ( MarcadoresRuta[i], "finish" )
					end
					addEventHandler("onClientMarkerHit", MarcadoresRuta[i], onBasureroHitMarker)
				end
			end
		end
	end
end

function linea3d(x, y, z,player)
	xx,yy,zz = x, y, z
	removeEventHandler("onClientRender", root, createLine)
	addEventHandler("onClientRender", root, createLine)   
end
function createLine ( )               
	x2, y2, z2 = getElementPosition ( localPlayer )               
	dxDrawLine3D ( xx,yy,zz, x2, y2, z2, tocolor ( 0, 255, 0, 230 ), 2) 
end


function onBasureroHitMarker( hitElement )
	if isElement(hitElement) and hitElement:getType() == "player" and hitElement == localPlayer then
		if hitElement:isInVehicle() then
			if hitElement:getData("Roleplay:trabajo") == "Basurero" and ValoresTrabajo[hitElement][3] == true then
				local veh = hitElement:getOccupiedVehicle()
				if veh:getModel() == 408 and veh:getData("VehiculoPublico") == "Basurero" then
					if ValoresTrabajo[hitElement][1] == ValoresTrabajo[hitElement][2] then
						destroyMarkersBasurero()
						triggerServerEvent("destroybass",hitElement)
						outputChatBox("Si deseas trabajar, vuelve a respawnear otro vehiculo.", 50, 150, 50, true)
						removeEventHandler("onClientRender", root, createLine)
						triggerServerEvent( "giveMoneyBasurero", hitElement )
						triggerServerEvent( "giveBasureroExp", hitElement )
						--
						ValoresTrabajo[hitElement] = nil;
						TimerK[hitElement] = nil;
						tableN[hitElement] = nil;
					else
						if ValoresTrabajo[hitElement][1] >= 1 then
							veh:setFrozen(true)
							fadeCamera(false)
							setTimer(function(veh, hitElement)
								if isElement(veh) then
									veh:setFrozen(false)
									fadeCamera(true)							
								end
							end, 2000, 1, veh, hitElement)
						end
						ValoresTrabajo[hitElement][2] = ValoresTrabajo[hitElement][2] + 1
						setTimer(startRutaBasurero, 50, 1,ValoresTrabajo[hitElement][4])
						destroyMarkerRut(hitElement, ValoresTrabajo[hitElement][4])
					end
				end
			end
		end
	end
end

function destroyMarkerRut(player, rut)
	if rut == 1 then
		for i=1, #MarkerMissionBasurero do
			if i <= ValoresTrabajo[player][2] then
				if isElement(MarcadoresRuta[i]) then
					destroyElement(MarcadoresRuta[i])
					MarcadoresRuta[i] = nil
				end
				if isElement(BlipsRuta[i]) then
					destroyElement(BlipsRuta[i])
					BlipsRuta[i] = nil
				end
			end
		end
	end
end

addEventHandler("onClientVehicleExit",root,function(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		if seat == 0 then
			if source:getModel() == 408 and source:getData("VehiculoPublico") == "Basurero" then
				if thePlayer:getData("Roleplay:trabajo") == "Basurero" then
					if ValoresTrabajo[thePlayer] then
						if ValoresTrabajo[thePlayer][3] == true then
							outputChatBox("Tienes 30 segundos para subir al vehículo o se cancelara la misión.", 150, 50, 50, true)
		        			failedMissionBasurero("LS", thePlayer, source, 30)
		        		end
		        	end
		        end
			end
		end
	end
end)

addEventHandler("onClientVehicleEnter",root,function(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		if seat == 0 then
			if source:getModel() == 408 and source:getData("VehiculoPublico") == "Basurero" then
				if thePlayer:getData("Roleplay:trabajo") == "Basurero" then
					if tableN[thePlayer] == true then
		        		if isTimer(TimerK[thePlayer]) then
		        			killTimer(TimerK[thePlayer])
							TimerK[thePlayer] = nil;
							tableN[thePlayer] = nil;
		        			outputChatBox("¡Perfecto sigue con la misión!", 50, 150, 50, true)
						end
					end
					if ValoresTrabajo[thePlayer] then else
						local random = thePlayer:getData("Basurero:Nivel") or 1
						ValoresTrabajo[thePlayer] = {nil, 1, true, random}
						startRutaBasurero(random)
						outputChatBox("Conduce por los #FFFF00marcadores #ffffffintenta no ir tan rápido",100,255,100,true)
					end
				end
			end
		end
	end
end)

addEvent("failedMissionBas", true)
function failedMissionBas()
	destroyMarkersBasurero()
	TimerK[localPlayer] = nil;
	tableN[localPlayer] = nil;
	removeEventHandler("onClientRender", root, createLine)
end
addEventHandler("failedMissionBas", getRootElement(), failedMissionBas)

function failedMissionBasurero(tip, thePlayer, vehiculo, timer)
	if tip == "LS" then
		tableN[thePlayer] = true
		TimerK[thePlayer] = setTimer(function(p, veh)
			if isElement(p) and isElement(veh) then
				destroyMarkersBasurero()
				ValoresTrabajo[p] = {nil, 1, false, 1}
				if veh and veh ~= nil then
					veh:destroy()
					removeEventHandler("onClientRender", root, createLine)
				end
				TimerK[p] = nil;
				tableN[p] = nil;
			end
		end, timer*1000, 1, thePlayer, vehiculo)
	end
end

function destroyMarkersBasurero()
	for i=1, #MarkerMissionBasurero do
		if isElement(MarcadoresRuta[i]) then
			destroyElement(MarcadoresRuta[i])
			MarcadoresRuta[i] = nil
		end
		if isElement(BlipsRuta[i]) then
			destroyElement(BlipsRuta[i])
			BlipsRuta[i] = nil
		end
		removeEventHandler("onClientRender", root, createLine)
	end
end

addEventHandler("onClientRender", getRootElement(), function()
	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )
	local playerX, playerY, playerZ = -80.986328125, -1554.744140625, 2.6171875
	local x,y,z = -69.287109375, -1548.5634765625, 2.6171875
	local sx1,sy1 = getScreenFromWorldPosition(x,y,z + 0.5)
	local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)
	if sx and sy then
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)
		if distance < 20 then
			dxDrawBorderedText3 ("/trabajar | /renunciar | /infobasurero\n#FFFFFF* Basurero", sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 
		end
	end
	if sy1 and sx1 then
		local cx, cy, cz = getCameraMatrix()
		local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, x,y,z + 0.5)
		if distance < 20 then
			dxDrawBorderedText3 ("Preciona #FF9600F #FFFFFFpara respawnear\nun Camion", sx1, sy1, sx1, sy1 , tocolor (255, 255, 255, 255 ),1, "default-bold","center", "center" ) 
		end
	end
end)

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)
end