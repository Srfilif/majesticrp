-- Cambiamos el trabajo a busetero
loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local MarkersBusetero = {}

addEventHandler("onResourceStart", resourceRoot, function()
    for i, v in ipairs(getJobsJardinero()) do
        Blip(v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement())
        Pickup(v[1], v[2], v[3], 3, 1210, 0)
        MarkersBusetero[i] = Marker(v[1], v[2], v[3] - 1, "cylinder", 1.5, 100, 100, 100, 0)
        MarkersBusetero[i]:setInterior(v.int)
        MarkersBusetero[i]:setDimension(v.dim)
        MarkersBusetero[i]:setData("MarkerJob", "Busetero")
    end
end)

addCommandHandler("trabajar", function(player, cmd)
    if not player:isInVehicle() then
        for i, marker in ipairs(MarkersBusetero) do
            if player:isWithinMarker(marker) then
                local mjob = marker:getData("MarkerJob")
                if mjob == "Busetero" then
                    if player:getData("Roleplay:trabajo") == "Busetero" then
                        removeElementData(player, "objeto")
                        removeElementData(player, "silla")
                        player:outputChat("¡Ya estás trabajando aquí!", 150, 50, 50, true)
                    else
                        if player:getData("Roleplay:trabajo") == "" then
                            removeElementData(player, "objeto")
                            removeElementData(player, "silla")
                            player:setData("Roleplay:trabajo", "Busetero")
                            player:outputChat("¡Bienvenido al trabajo de #ffff00Busetero#ffffff!", 255, 255, 255, true)
                        else
                            player:outputChat("#ff3d3dNo puedes trabajar aquí. Ya tienes otro trabajo.", 255, 255, 255, true)
                        end
                    end
                end
            end
        end
    end
end)

addCommandHandler("infobusetero", function(player, cmd)
    if not notIsGuest(player) then
        if not player:isInVehicle() then
            for i, v in ipairs(MarkersBusetero) do
                if player:isWithinMarker(v) then
                    local job = v:getData("MarkerJob")
                    if job == "Busetero" then
                        player:outputChat("¡Bienvenido al trabajo de #ffff00Busetero#ffffff!", 255, 255, 255, true)
                        player:outputChat("#ffFFff", 255, 255, 255, true)
                        player:outputChat("Tu trabajo es conducir el autobús por la ciudad.", 255, 255, 255, true)
                        player:outputChat("Para empezar a trabajar usa #00ff00/trabajar #ffFFffy para dejar de trabajar #ff0000/dejartrabajar", 255, 255, 255, true)
                    end
                end
            end
        end
    end
end)

-- Aquí puedes continuar con el código específico para el trabajo de busetero.
-- Asegúrate de definir las funciones y eventos necesarios para este trabajo.
-- Puedes seguir el patrón del código anterior para agregar funcionalidad.





addCommandHandler("renunciar", function(player, cmd)
    if not player:isInVehicle() then
        for i, marker in ipairs(MarkersBusetero) do
            if player:isWithinMarker(marker) then
                local job = marker:getData("MarkerJob")
                if job == "Busetero" then
                    if player:getData("Roleplay:trabajo") == "" then
                        player:outputChat("¡No tienes trabajo, consigue uno!", 150, 50, 50, true)
                    else
                        if player:getData("Roleplay:trabajo") == "Busetero" then
                            removeElementData(player, "objeto")
                            removeElementData(player, "silla")
                            player:outputChat("¡Acabas de renunciar como Busetero!", 50, 150, 50, true)
                            player:setData("Roleplay:trabajo", "")
                        else
                            removeElementData(player, "objeto")
                            removeElementData(player, "silla")
                            player:outputChat("¡No has trabajado en este lugar, no puedes renunciar aquí!", 150, 50, 50, true)
                            player:outputChat("Tu trabajo actual es de: #ffff00"..player:getData("Roleplay:trabajo"), 255, 255, 255, true)
                        end
                    end
                end
            end
        end
    end
end)


addEvent("giveMoneyJardinero", true)

function giveMoneyJardinero()

	local propinarandom = math.random(1,8)

	local exp = source:getData("Roleplay:ExpJobJardinero") or 1

	local totalMoney = math.ceil(math.random(150,200)*exp)

	--

	local malasuerte = math.random(1,6)

	text = "#FFFFFFAcabas de ganar: #004500$"..convertNumber(totalMoney).." dólares #ffffff por cosechar."

	source:giveMoney(tonumber(totalMoney))

	source:outputChat(text, 255, 255, 255, true)

end

addEventHandler("giveMoneyJardinero", root, giveMoneyJardinero)


-- Definir el evento para iniciar el trabajo de busetero
function iniciarTrabajoBusetero(player)
  outputChatBox("Ejecutado",player,255,255,255,true)
    -- Aquí deberías poner el código para iniciar el trabajo de busetero
end


-- Función que se llama cuando un jugador se sube a un vehículo
function comprobarTrabajoAlSubirseAVehiculo(player)
    if getElementType(source) == "vehicle" then
        local vehicleModel = getElementModel(source)
        
        -- Comprobar si el vehículo es un "Coach"
        if vehicleModel == 437 then  -- Cambia 437 por el modelo del "Coach" en tu servidor
            -- Comprobar si el jugador tiene el trabajo de "busetero"
            local job = player:getData("Roleplay:trabajo")
            if job == "Busetero" then
                -- Ejecutar el evento para iniciar el trabajo de busetero
                triggerEvent("iniciarTrabajoBusetero", player)
            end
		else

			outputChatBox("saaa11a",source)
        end
		
	else

		outputChatBox("saaaa",source)
    end
end

-- Agregar un manejador de evento para el evento de inicio de trabajo de busetero
addEvent("iniciarTrabajoBusetero", true)
addEventHandler("iniciarTrabajoBusetero", root, iniciarTrabajoBusetero)

-- Agregar un manejador de evento para el evento de subirse a un vehículo
addEventHandler("onPlayerVehicleEnter", root, comprobarTrabajoAlSubirseAVehiculo)
