loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')



local MarkersCarpintero = {}

local hola = createPed(309,2395.6748046875, -1304.1376953125, 25.623565673828)
setPedRotation(hola,135)

addEventHandler("onResourceStart", resourceRoot, function()

	for i, v in ipairs(getJobsCarpintero()) do

		--

		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

		--

		Pickup(v[1], v[2], v[3], 3, 1210, 0)

		MarkersCarpintero[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)

		MarkersCarpintero[i]:setInterior(v.int)

		MarkersCarpintero[i]:setDimension(v.dim)

		MarkersCarpintero[i]:setData("MarkerJob", "Carpintero")

	end

end)

local Pickup = Pickup( 2404.55859375, -1316.384765625, 25.2601146698, 3, 1463, 0)
setElementInterior(Pickup, 0)
setElementDimension(Pickup, 0)

local Marcador = Marker(2404.55859375, -1316.384765625, 25.2601146698 - 1, "cylinder", 1.7, 100, 100, 100, 0)
setElementInterior(Marcador, 0)
setElementDimension(Marcador, 0)

local vender = Marker(2392.953125, -1306.2529296875, 25.545051574707, "cylinder", 2, 100, 100, 100, 255)
setElementInterior(vender, 0)
setElementDimension(vender, 0)
local stateWindow = false
local boat
local gruz
local stateJob = false
local markerGruz
local markerSkad
local text = "Comezar"
local zp = 0
local gruzHand = false
local objeto = {}
local playerData = {} -- Tabla para almacenar los datos específicos de cada jugador.

-- Función para recoger madera
function recogerMadera(player)
    if not player:isWithinMarker(Marcador) then
        return
    end

    local job = player:getData("Roleplay:trabajo")
    if job ~= "Carpintero" then
        outputChatBox("#ff3d3d[Carpintero] ¡Tú no trabajas aquí!", player, 255, 0, 0, true)
        return
    end

    local data = playerData[player] or { objeto = 0, gruz = nil }
    if data.objeto >= 1 then
        outputChatBox("#ffff3d[Carpintero]#ff3d3d Ya tienes una pila de madera en tus manos.", player, 255, 0, 0, true)
        return
    end
    toggleControl(player, "jump", false)  -- Deshabilita el salto
    toggleControl(player, "fire", false)  -- Deshabilita el golpeo
    -- Animación para recoger y luego cargar madera
    setPedAnimation(player, "CARRY", "liftup", 1400, false, true, true, false)
    setTimer(function()
        if isElement(player) then
            setPedAnimation(player, "CARRY", "crry_prtial", 0, true, true, true, true)
        end
    end, 1400, 1)

    -- Crear el objeto de madera y adjuntarlo al jugador
    local x, y, z = getElementPosition(player)
    local gruz = createObject(1463, x, y, z)
    attachElements(gruz, player, 0, 0.4, 0.5)
    setObjectScale(gruz, 0.5)
    setElementCollisionsEnabled(gruz, false)


    -- Guardar datos específicos del jugador
    data.objeto = 1
    data.gruz = gruz
    playerData[player] = data

    outputChatBox("#ffff3d[Carpintero]#ffffff Has recogido una pila de #ffff3dMadera#ffffff. Ve a la mesa para elaborar algo.", player, 150, 50, 50, true)
end

-- Vincular clic derecho para recoger madera
addEventHandler("onResourceStart", resourceRoot, function()
    for _, player in ipairs(Element.getAllByType("player")) do
        bindKey(player, "mouse2", "down", function()
            if not player:isInVehicle() then
                recogerMadera(player)
            end
        end)
    end
end)

-- Vincular clic derecho para nuevos jugadores que entren después del inicio
addEventHandler("onPlayerJoin", root, function()
    bindKey(source, "mouse2", "down", function()
        if not source:isInVehicle() then
            recogerMadera(source)
        end
    end)
end)

-- Mostrar mensaje al entrar en el marcador
addEventHandler("onMarkerHit", Marcador, function(hitElement)
    if isElement(hitElement) and getElementType(hitElement) == "player" then
        outputChatBox("#ffff3d[Carpintero]#ffffff Haz clic derecho para recoger madera.", hitElement, 255, 255, 0, true)
    end
end)


local sillas = {
{1720},
{1805},
{1811},
{2096},
{2079},
{2120},
{2124},
{1739},

}
local circlearea = createColCuboid(2394.98046875, -1309.857421875, 25.581119537354 - 3, 12, 7, 10)

function ColShapeHit(thePlayer, matchingDimension)
    setElementData(thePlayer, "Carpintero-Area", 1)
end
addEventHandler("onColShapeHit", circlearea, ColShapeHit)

function jailZoneLeave(thePlayer)
    if getElementType(thePlayer) == "player" then
        setElementData(thePlayer, "Carpintero-Area", 0)
    end
end
addEventHandler("onColShapeLeave", circlearea, jailZoneLeave)

function ConstruirObjeto(player, cmd, numero)
    local data = playerData[player] or { objeto = 0, mueble = "None" }
    local inArea = player:getData("Carpintero-Area") or 0
    local trabajo = player:getData("Roleplay:trabajo")
    local pedSlot = getPedWeaponSlot(player)

    numero = tonumber(numero)

    if not numero then
        player:outputChat("#ffff3d[Carpintero]#ff3d3d Para empezar a construir usa: #FC8230/construir [1-5]", 255, 255, 255, true)
        return
    end

    if trabajo ~= "Carpintero" then
        player:outputChat("#ffff3d[Carpintero]#ff3d3d No tienes el trabajo de Carpintero para elaborar un mueble.", 150, 50, 50, true)
        return
    end

    if inArea ~= 1 then
        player:outputChat("#ffff3d[Carpintero]#ff3d3d No estás en el lugar de trabajo para poder elaborar un mueble.", 150, 50, 50, true)
        return
    end

    if pedSlot ~= 10 then
        player:outputChat("#ffff3d[Carpintero]#ff3d3d No tienes un #fa5c23Martillo#ff3d3d, necesitas uno para elaborar algo.", 150, 50, 50, true)
        return
    end

    if data.objeto < 1 then
        player:outputChat("#ffff3d[Carpintero]#ff3d3d No tienes madera para fabricar.", 150, 50, 50, true)
        return
    end

    local muebles = {
        [1] = { nombre = "Mesa", modelo = 1720 },
        [2] = { nombre = "Silla", modelo = 1805 },
        [3] = { nombre = "Cama", modelo = 1811 },
        [4] = { nombre = "Armario", modelo = 2096 }
    }

    local mueble = muebles[numero]
    if not mueble then
        player:outputChat("#ffff3d[Carpintero]#ff3d3d Número inválido. Por favor usa: #FC8230/construir [1-4]", 150, 50, 50, true)
        return
    end

    -- Iniciar fabricación del mueble
	if isElement(data.gruz) then destroyElement(data.gruz) end

    setElementFrozen(player, true)
    setPedAnimation(player, "COLT45", "sawnoff_reload", -1, true, false, false, false)

    player:outputChat("#ffff3d[Carpintero]#ffFFff Has empezado a elaborar un/a #00ff00" .. mueble.nombre .. "#ffFFff. Espera #ffff3d10 #ffFFffsegundos para terminar.", 150, 50, 50, true)

    setTimer(function()
        if not isElement(player) then return end
        setElementFrozen(player, false)
        setPedAnimation(player)

		local x, y, z = player:getPosition()
        local gruz = createObject(mueble.modelo, x, y, z)
        attachElements(gruz, player, 0, 0.4, 0.05)
        setObjectScale(gruz, 1)
        setElementCollisionsEnabled(gruz, false)

        setPedAnimation(player, "CARRY", "crry_prtial", 0, true, true, true, true)

        -- Actualizar datos del jugador
        data.objeto = 0
        data.objetoElement = nil
		data.muebleElement = gruz
        data.mueble = mueble.nombre
        playerData[player] = data

        player:outputChat("#ffff3d[Carpintero]#ffFFff Has terminado de fabricar un/a #00ff00" .. mueble.nombre .. "#ffFFff.", 150, 50, 50, true)
    end, 10000, 1)
end

addCommandHandler("construir", ConstruirObjeto)

-- Limpiar datos del jugador al salir
addEventHandler("onPlayerQuit", root, function()
    local data = playerData[source]
    if data and data.objetoElement then
        destroyElement(data.objetoElement)
    end
    playerData[source] = nil
end)


--vender
-- Función para vender muebles
function venderMueble(player)
    if not player:isWithinMarker(vender) then
        return
    end

    local job = player:getData("Roleplay:trabajo")
    if job ~= "Carpintero" then
        outputChatBox("#ff3d3d[Carpintero] ¡Tú no trabajas aquí!", player, 255, 0, 0, true)
        return
    end

    local data = playerData[player] or { objeto = 0, objetoElement = nil, muebleElement = nil, mueble = "None" }

    if data.mueble == "None" then
        outputChatBox("#ffff3d[Carpintero]#ff3d3d No tienes muebles para vender.", player, 255, 0, 0, true)
        return
    end

    local rewards = {
        Mesa = { min = 1000, max = 2500 },
        Silla = { min = 100, max = 500 },
        Cama = { min = 1500, max = 3500 },
        Armario = { min = 2000, max = 6000 }
    }

    local reward = rewards[data.mueble]
    if not reward then
        outputChatBox("#ff3d3d[Carpintero] Ha ocurrido un error con el mueble que intentas vender.", player, 255, 0, 0, true)
        return
    end

    -- Calcular recompensa
    local money = math.random(reward.min, reward.max)
    givePlayerMoney(player, money)
    outputChatBox("#ffff3d[Carpintero]#ffffff Has vendido un/a #00ff00" .. data.mueble .. "#ffffff y ganado #00ff00$" .. money, player, 255, 255, 255, true)

    -- Limpiar datos del jugador
	if isElement(data.objetoElement) then
        destroyElement(data.objetoElement)
    end
    if isElement(data.muebleElement) then
        destroyElement(data.muebleElement)
    end

    playerData[player] = { objeto = 0, objetoElement = nil, muebleElement = nil, mueble = "None" }
    toggleControl(player, "jump", true)  -- Deshabilita el salto
    toggleControl(player, "fire", true)  -- Deshabilita el golpeo
end
-- Vincular clic izquierdo para vender muebles
addEventHandler("onResourceStart", resourceRoot, function()
    for _, player in ipairs(Element.getAllByType("player")) do
        bindKey(player, "mouse1", "down", function()
            if not player:isInVehicle() then
                venderMueble(player)
            end
        end)
    end
end)


addCommandHandler("trabajar", function(player, cmd)

		if not player:isInVehicle() then
				for i, marker in ipairs(MarkersCarpintero) do
					if player:isWithinMarker(marker) then

						local mjob = marker:getData("MarkerJob")

						if mjob == "Carpintero" then
-- Verificar si el jugador ya tiene el trabajo de "Carpintero"
  if player:getData("Roleplay:trabajo") == "Carpintero" then
    removeElementData(player, "objeto")
    removeElementData(player, "silla")
    player:outputChat("¡Ya estás trabajando aquí!", 150, 50, 50, true)
else
    if player:getData("Roleplay:trabajo") == "" then
        removeElementData(player, "objeto")
        removeElementData(player, "silla")
        player:setData("Roleplay:trabajo", "Carpintero")
        player:outputChat("¡Bienvenido al trabajo de #ffff00Carpintero#ffffff!", 255, 255, 255, true)
    else
        player:outputChat("#ff3d3dNo puedes trabajar aquí. Ya tienes otro trabajo.", 255, 255, 255, true)
    end
	end







	
	
								

							--	player:setData("Roleplay:trabajo", "")
                 
					
					--			player:outputChat("¡Bienvenido al trabajo de #ffff00Carpintero#ffffff!", 255, 255, 255, true)
                        --        player:outputChat("#ffFFffRecoge una pila de madera y ve a la mesa para elaborar el item", 255, 255, 255, true)
								--player:outputChat("Tienes 20 segundos para subir a tu vehículo o pierdas la misión.", 150, 50, 50, true)

						

						

					end

				end

			end

								
	--	player:setData("Roleplay:trabajo", "")

		--end
		

	end

end)







	addCommandHandler("trabajo", function(player, cmd)
    local currentJob = player:getData("Roleplay:trabajo")
    								player:setData("Roleplay:trabajo", "")
    if currentJob and currentJob ~= "" then
        player:outputChat("Tu trabajo actual es: " .. currentJob, 255, 255, 255, true)
    else
        player:outputChat("No tienes trabajo actualmente.", 255, 255, 255, true)
    end
end)	


addCommandHandler("infocarpintero", function(player, cmd)



		if not player:isInVehicle() then

			for i, v in ipairs(MarkersCarpintero) do

				if player:isWithinMarker(v) then

					local job = v:getData("MarkerJob")

 					if job == "Carpintero" then

						player:outputChat("¡Bienvenidos al trabajo de #ffff00Carpintero#ffffff!", 255, 255, 255, true)
						player:outputChat("#ffFFff", 255, 255, 255, true)
						player:outputChat("Para empezar este trabajo recoger una pila de madera,luego ve a las mesas para elaborar algo y luego vende el objeto para ganar algo de dinero", 255, 255, 255, true)


				  						
			

				end

			end

		end
	end

end)



addCommandHandler("renunciar", function(player, cmd)

		if not player:isInVehicle() then

		--	if player:getData("Roleplay:trabajo") ~="" then

				for i, v in ipairs(MarkersCarpintero) do

					if player:isWithinMarker(v) then

						local job = v:getData("MarkerJob")

						if job == "Carpintero" then
							if player:getData("Roleplay:trabajo") == "" then
								player:outputChat("¡No tienes trabajo, Consigue uno VAGO!!", 150, 50, 50, true)
							
							else
							if player:getData("Roleplay:trabajo") == "Carpintero" then
								removeElementData(player,"objeto")
								removeElementData(player,"silla")

								player:outputChat("¡Acabas de renunciar!", 50, 150, 50, true)

								player:setData("Roleplay:trabajo", "")

							else
								removeElementData(player,"objeto")
								removeElementData(player,"silla")
								player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)

								player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)
                          end
							
                          
end
						

					end

				end

			end

		--end

	end

end)





