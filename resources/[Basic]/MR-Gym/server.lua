local colSphere = createColSphere(-228.9677734375, 1052.376953125, 19.75354385376, 20)

function accionarGym(source)
	if not isElementWithinColShape(source, colSphere) then
		outputChatBox("* Estas muy lejos de la aseguradora", source, 255, 0, 0, true)
		return
	end
	triggerClientEvent(source, "POPLife:accionarGym", source)
end
addCommandHandler("estilo", accionarGym)

function colocarEstilo(estilo)
	setPedFightingStyle(client, tonumber(estilo))
	outputChatBox("* Has cambiado tu estilo de pelea", client, 255, 200, 0, false)
end
addEvent("POPLife:cambiarEstilo", true)
addEventHandler("POPLife:cambiarEstilo", root, colocarEstilo)