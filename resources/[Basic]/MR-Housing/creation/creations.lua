----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 07 Nov 2014
-- Resource: GTIhousing/creation.slua
-- Version: 1.0
----------------------------------------->>

-- Create House
---------------->>

local house_acl = {
	["Andres_Angel"] = true,
	["Amado_Camarillo"] = true,


}

function abrirCreacionCasas(source)
	if not house_acl[source:getAccount():getName()] then
		return
	end
	source:triggerEvent("abrirPanelCrearCasas", source)
end
addCommandHandler("createh", abrirCreacionCasas)

addEvent("GTIhousing.createHouse", true)
addEventHandler("GTIhousing.createHouse", root, function(address, location, garage, int_id, cost)
	createHouse(client, address, location, garage, int_id, cost)
end)