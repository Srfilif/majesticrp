local colSphere1 = createColSphere(-334.5283203125, 1048.3662109375, 19.7421875-0.5, 1.4)

function abrirVehiculosMedico(source)
	local accName = getAccountName (getPlayerAccount(source)) 
	if not isElementWithinColShape(source, colSphere1) then
		outputChatBox("#FEFEFE[#FF7800Sistema#FEFEFE] Estas muy lejos del garaje medico para abrirlo!", source, 255, 0, 0, true)
		return
	end
	if getElementData(source, "Roleplay:faccion") ~= "Medico" then
		outputChatBox("#FEFEFE[#FF7800Sistema#FEFEFE] No tienes permitido interactuar con esto!", source, 255, 0, 0, true)
		return
	end
	triggerClientEvent(source, "PoPLife:abrirVehiculosMedico", source)
end
addCommandHandler("garajem", abrirVehiculosMedico)

local tablaSpawn = {
	{-335.1689453125, 1055.8056640625, 19.735029220581, 0, 0, 90},

}

tablaAutosMedico = { }
function sacarAutoMedico(id)
	local tabla = math.random(#tablaSpawn)
    local x, y, z = tablaSpawn[tabla][1], tablaSpawn[tabla][2], tablaSpawn[tabla][3]
    local rx, ry, rz = tablaSpawn[tabla][4], tablaSpawn[tabla][5], tablaSpawn[tabla][6]
	if (isElement(tablaAutosMedico[ source ])) then
		print("Vehiculo medico antiguo destruido")
		destroyElement(tablaAutosMedico[ source ])
	end
		tablaAutosMedico[ source ] = createVehicle(id, x, y, z, rx, ry, rz)
		setElementData(tablaAutosMedico[ source ], "Fuel", 100)
		setVehicleColor(tablaAutosMedico[ source ], 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255)
		outputChatBox("#FEFEFE[#FF7800Sistema#FEFEFE] Sacaste la patrulla "..getVehicleNameFromID(id).." Con la placa POP - "..getVehiclePlateText(tablaAutosMedico[ source ]).."", source, 0, 255, 0, true)
	end
addEvent("POPLife:sacarAutoMedico", true)
addEventHandler("POPLife:sacarAutoMedico", root, sacarAutoMedico)

addEventHandler("onPlayerQuit", root,
	function()
		if isElement(tablaAutosMedico[ source ]) then
			print("Vehiculo medico antiguo destruido en base a salida del creador")
			destroyElement(tablaAutosMedico[ source ])
		end
	end
)