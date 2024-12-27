local asientos = {
    [0] = 1,
    [1] = 0,
    [2] = 3,
    [3] = 2
}

local sobrenombres = {
    [0] = "conductor",
    [1] = "copiloto",
    [2] = "trasero izquierdo",
    [3] = "trasero derecho"
}

local congelacion = {}

function cambiarasientoc(player)
    local asiento = getPedOccupiedVehicleSeat(player)
    local asientopuesto = asientos[asiento]
	
    if asientopuesto ~= nil then
		local vehicle = getPedOccupiedVehicle(player)
		local ocupado = getVehicleOccupant(vehicle, asientopuesto)
		
		local tipodeveh = getVehicleType(vehicle)
		if tipodeveh == "Helicopter" or tipodeveh == "Plane" then
			outputChatBox("No puedes cambiar de asiento en una aeronave!", player, 255, 0, 0)
			return
		end
		
		local asientosmax = getVehicleMaxPassengers(vehicle) + 1
		if asientosmax == 1 then
			outputChatBox("Este vehículo solo tiene un asiento disponible.", player, 255, 0, 0)
			return
		end
		
        if ocupado and isElement(ocupado) then
			outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00¡El asiento del ".. sobrenombres[asientopuesto] .." está ocupado!" , player, 255, 0, 0, true)
		return
		end
		
		local tiempo = getTickCount()
        local ultimouso = congelacion[player] or 0
        local tiempoantes = math.max(0, (ultimouso + 5000) - tiempo)

        if tiempoantes > 0 then
            outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00Debes esperar " .. math.ceil(tiempoantes / 5000) .. " segundos para cambiar de asiento.", player, 255, 0, 0, true)
            return
        end
        warpPedIntoVehicle(player, vehicle, asientopuesto)
        outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFFFFFTe cambiaste al asiento del ".. sobrenombres[asientopuesto], player, 0, 255, 0, true)
		outputChatBox(getPlayerName(player).." se cambió al asiento del ".. sobrenombres[asientopuesto], vehicle, 0, 255, 0)
		congelacion[player] = tiempo
	else
		outputChatBox("#FFFFFF[#01B90EAsiento#FFFFFF] #FFCD00Necesitas estar arriba de un vehiculo.", player, 255, 0, 0, true)
    end
end
addCommandHandler("cambiarasiento", cambiarasientoc)
