loadstring(exports.MySQL:getMyCode())()
import('*'):init('[LS]Tiendas')
local db = exports["[LS]Tiendas"]:getDatabase() -- Obtener la conexión centralizada

function agenda_open( source )
	if not notIsGuest( source ) then
		if getPlayerItem("Agenda") == "Si" then
			local texto = source:getData("Roleplay:AgendaTexto") or ""
			source:triggerEvent("abrir_window", source, texto)
		else
			source:outputChat("* No tienes una agenda.", 150, 0, 0, ture)
		end
	end
end
addCommandHandler("agenda", agenda_open)

addEvent("enviar_element", true)
addEventHandler("enviar_element", root, function( text )
	local account = source:getAccount()
	if account then
		source:setData("Roleplay:AgendaTexto", text)
		account:setData("Roleplay:AgendaTexto", text)
		
		source:outputChat("* Acabas de guardar lo que escribiste en tu agenda..", 0, 150, 0, true)
	end
end)

local noKick = {
	["Frank_Orion"] = true,
}

function kickAFK(player)
	if noKick[AccountName(player)] == true then
		return
	end
	player:kick("Consola", "Demasiado Tiempo AFK")
end
addEvent("kickAFK", true)
addEventHandler("kickAFK", root, kickAFK)