loadstring(exports.MySQL:getMyCode())()
import('*'):init('MySQL')

local tabla = {}

addEventHandler("onResourceStart", resourceRoot, function()
	for i, v in pairs(pickups_infos) do
		tabla[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 255, 255, 255, 0)
		tabla[i]:setInterior(v.int)
		tabla[i]:setDimension(v.dim)
	end
end)

addCommandHandler("licencias", function(p)
	if not notIsGuest(p) then
		if not p:isInVehicle() then
			for i, v in ipairs(tabla) do
				if p:isWithinMarker(v) then
					p:triggerEvent("setPanelLicencieros", p)
				end
			end
		end
	end
end)

-- mision
addEvent("startMisionsLicenses", true)
function startMisionsLicenses(t, money)
	if source:getMoney() >= tonumber(money) then
		if t == "Conducir" then
			if source:getData("Roleplay:Licencia_Conducir") == 1 then
				source:outputChat("* Ya tienes una licencia de conducir", 150, 50, 50, true)
			else
				source:setData("Roleplay:Mision", "Licencia")
				source:triggerEvent("IniciarRutaLicencia", source, "Conducir")
				source:outputChat("Tienes 20 segundos para subir a tu vehículo o pierdas la misión.", 150, 50, 50, true)
				source:triggerEvent("callCinematic", source, "Subete a un #FF0033Manana", 5000, "No")
				source:takeMoney( tonumber(money))
				
			end
		elseif t == "Navegar" then
			if source:getData("Roleplay:Licencia_Navegar") == 1 then
				source:outputChat("* Ya tienes una licencia de navegar", 150, 50, 50, true)
			else
				source:takeMoney( tonumber(money))
				source:outputChat("¡Felicidades! Licencia comprada.", 50, 150, 50, true)
				source:setData("Roleplay:Licencia_Navegar", source:getData("Roleplay:Licencia_Navegar") + 1)
				exports["[LS]Tiendas"]:setPlayerItem(source,"Licencia de Navegacion" , getPlayerItem(source, item)+1)
				exports["[LS]Tiendas"]:setPlayerItem(player, "Licencia de Navegacion (Clase A)", 1)
			end
		elseif t == "Piloto" then
			if source:getData("Roleplay:Licencia_Piloto") == 1 then
				source:outputChat("* Ya tienes una licencia de piloto", 150, 50, 50, true)
			else
				source:takeMoney( tonumber(money))
				source:outputChat("¡Felicidades! Licencia comprada.", 50, 150, 50, true)
				source:setData("Roleplay:Licencia_Piloto", source:getData("Roleplay:Licencia_Piloto") + 1)
			end
		elseif t == "Pesca" then
			if source:getData("Roleplay:Licencia_Pesca") == 1 then
				source:outputChat("* Ya tienes una licencia de pesca", 150, 50, 50, true)
			else
				source:takeMoney( tonumber(money))
				source:outputChat("¡Felicidades! Licencia comprada.", 50, 150, 50, true)
				source:setData("Roleplay:Licencia_Pesca", source:getData("Roleplay:Licencia_Pesca") + 1)
				exports["[LS]Tiendas"]:setPlayerItem(player, "Licencia de Pesca (Clase A)", 1)
				
			end
		end
	else
		source:outputChat("No tienes el dinero suficiente para comprar esta Licencia.", 150, 50, 50, true)
	end
end
addEventHandler("startMisionsLicenses", root, startMisionsLicenses)

function ObtenerLicencia()
	source:setData("Roleplay:Mision", "")
	source:setData("Roleplay:Licencia_Conducir", source:getData("Roleplay:Licencia_Conducir") + 1)
	if source:isInVehicle() then
		setTimer(function(source)
			if isElement(source) then
				source:removeFromVehicle(source:getOccupiedVehicle())
			end
		end, 1000, 1, source)
	end
	source:outputChat("* Acabas de obtener tu licencia de conducir.", 50, 150, 50, true)
	exports["[LS]Tiendas"]:setPlayerItem(source, "Licencia de Conducir (Clase A)", 1)
	
end
addEvent("ObtenerLicencia", true)
addEventHandler("ObtenerLicencia", root, ObtenerLicencia)

addEvent("remo", true)
addEventHandler("remo", root, function()
	source:removeFromVehicle(source:getOccupiedVehicle())
end)


function VerLic(player)
        local LicenciaN = exports["[LS]Tiendas"]:getPlayerItem(player, "Licencia de Navegacion") or 0
outputChatBox("#ffFFff",player,0,255,0,true)
outputChatBox("#f0b0e0=== TUS LICENCIAS ===",player,0,255,0,true)
outputChatBox("#ffFFff",player,0,255,0,true)
       if getElementData(player,"Roleplay:Licencia_Arma") ==1	then
	    outputChatBox("#f0b0e0-> #e0f0b0Libreta de armas (Clase A).",player,0,255,0,true)  
		exports["[LS]Tiendas"]:setPlayerItem(player, "Licencia de Armas (Clase A)", 1)
       elseif getElementData(player,"Roleplay:Licencia_Arma") ==2	then		
	   
	    outputChatBox("#f0b0e0-> #e0f0b0Libreta de armas (Clase B).",player,0,255,0,true) 
		exports["[LS]Tiendas"]:setPlayerItem(player, "Licencia de Armas (Clase B)", 1)
	   elseif getElementData(player,"Roleplay:Licencia_Arma") ==3	then	
	   
	    outputChatBox("#f0b0e0-> #e0f0b0Libreta de armas (Clase C).",player,0,255,0,true) 
		exports["[LS]Tiendas"]:setPlayerItem(player, "Licencia de Armas (Clase C)", 1)
	   
    end
	    if getElementData(player,"Roleplay:Licencia_Conducir") >=1	then
        outputChatBox("#f0b0e0-> #e0f0b0Libreta de conducir (Clase A).",player,0,255,0,true)
		exports["[LS]Tiendas"]:setPlayerItem(player, "Licencia de Conducir (Clase A)", 1)
    end
	    if getElementData(player,"Roleplay:Licencia_Navegar") >=1	then
        outputChatBox("#f0b0e0-> #e0f0b0Libreta de negevacion (Clase A).",player,0,255,0,true)
		exports["[LS]Tiendas"]:setPlayerItem(player, "Licencia de Navegacion (Clase A)", 1)
    end
	    if getElementData(player,"Roleplay:Licencia_Arma") >=1	then
        outputChatBox("#f0b0e0-> #e0f0b0Libreta de pesca (Clase A).",player,0,255,0,true)
		exports["[LS]Tiendas"]:setPlayerItem(player, "Licencia de Pesca (Clase A)", 1)
		
    end
end
addCommandHandler("verlicencias",VerLic)
local solicitudesPendientes = {}
local darTipoLic = {}
function darLicencia(commandSource, command, tipo, jugador)
    -- Verificar si se proporciona el tipo y el jugador
    if not tipo or not jugador then
        outputChatBox("#f0b0e0[LICENCIAS] #ff3232/darlicencia #ffFFff<tipo> <jugador>", commandSource, 0, 255, 0,true)
		outputChatBox("#f0b0e0[LICENCIAS] #ff3232Tipos disponibles #ffFFffarmas,conducir,navegar,pesca", commandSource, 0, 255, 0,true)
        return
    end

    -- Obtener el jugador objetivo
    local targetPlayer = getPlayerFromName(jugador)
    if not targetPlayer then
        outputChatBox("#f0b0e0[LICENCIAS] #ff3232El jugador no está en línea o no existe.", commandSource, 255, 0, 0,true)
        return
    end
	  if targetPlayer == commandSource then
        outputChatBox("#f0b0e0[LICENCIAS] #ff3232No puedes otorgarte licencia a ti mismo.", commandSource, 255, 0, 0, true)
        return
    end

       -- Crear una solicitud de visualización de licencia para el jugador objetivo
    solicitudesPendientes[targetPlayer] = commandSource -- Almacenar el jugador solicitante
    darTipoLic[targetPlayer] = tipo 
    outputChatBox("#f0b0e0[LICENCIAS] #ffFFffHas enviado una solicitud para ver la licencia a #ffd700"..getPlayerName(targetPlayer), commandSource, 0, 255, 0, true)
    outputChatBox("#f0b0e0[LICENCIAS] #ffFFffHas recibido una solicitud para ver la licencia de #ffd700"..getPlayerName(commandSource), targetPlayer, 0, 255, 0, true)
    outputChatBox("#f0b0e0[LICENCIAS] #ffFFffPara aceptar, escribe #00ff00/aceptarlicencia#ffFFff, o #ff0000/rechazarlicencia #ffFFffpara rechazarla.", targetPlayer, 0, 255, 0, true)
    
    -- Establecer un temporizador para cancelar la solicitud si no se acepta o rechaza
    setTimer(function()
        if solicitudesPendientes[targetPlayer] == commandSource then
            solicitudesPendientes[targetPlayer] = nil -- Eliminar la solicitud si no se ha respondido a tiempo
            
			outputChatBox("#f0b0e0[LICENCIAS] #ffFFffLa solicitud de visualización de licencia ha expirado para #ffd700"..getPlayerName(targetPlayer), commandSource, 255, 0, 0, true)
            outputChatBox("#f0b0e0[LICENCIAS] #ff3232La solicitud de visualización de licencia ha expirado.", targetPlayer, 255, 0, 0, true)
        end
    end, 15000, 1) -- 15000 milisegundos (15 segundos)

end

addCommandHandler("darlicencia", darLicencia)

function aceptarLicencia(player)
    local solicitante = solicitudesPendientes[player]
	
    if solicitante then
	local NSoli = getPlayerName(solicitante)
        outputChatBox("#f0b0e0[LICENCIAS] #ffFFffHas aceptado ver la licencia de #ffd700"..NSoli..".", player, 0, 255, 0, true)
		outputChatBox("#f0b0e0[LICENCIAS] #ffFFffEl jugador #ffd700"..NSoli.."#ffFFff Tiene una #e0f0b0Libreta de "..darTipoLic[player]..".", player, 0, 255, 0, true)
        outputChatBox("#f0b0e0[LICENCIAS] #ffFFffLe muestras a #ffd700"..getPlayerName(player).." tu #e0f0b0Libreta de "..darTipoLic[player]..".", solicitante, 0, 255, 0, true)
        solicitudesPendientes[player] = nil -- Eliminar la solicitud después de ser aceptada
    end
end
addCommandHandler("aceptarlicencia", aceptarLicencia)

function rechazarLicencia(player)
    local solicitante = solicitudesPendientes[player]
    if solicitante then
        outputChatBox("#f0b0e0[LICENCIAS] #ffFFffHas rechazado la solicitud para ver tu licencia.", player, 255, 0, 0, true)
        outputChatBox("#f0b0e0[LICENCIAS] #ffFFffEl jugador #"..getPlayerName(player).." ha rechazado ver tu licencia.", solicitante, 255, 0, 0, true)
        solicitudesPendientes[player] = nil -- Eliminar la solicitud después de ser rechazada
    end
end
addCommandHandler("rechazarlicencia", rechazarLicencia)