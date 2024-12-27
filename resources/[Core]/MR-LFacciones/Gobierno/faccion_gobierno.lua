addCommandHandler("lidergobierno", function(player, cmd, who)
	if not notIsGuest( player ) then
		if permisos[getACLFromPlayer(player)] == true then
			local thePlayer = getPlayerFromPartialName(who)
			if (thePlayer) then
				if thePlayer:getData("Roleplay:faccion") ~="" then
					player:outputChat(_getPlayerNameR(thePlayer).." se encuentra en una facción debe dejar su facción para que le puedas dar el lider de gobierno.", 150, 50, 50, true)
				else
					local s = query("SELECT * From `Facciones` where Faccion = ? and Lider=?", 'Gobierno', 'Si')
					if ( type( s ) == "table" and #s == 0 ) or not s then
						player:outputChat("* Le acabas de entregar el lider a #FFFFFF".._getPlayerNameR(thePlayer).."", 50, 100, 50, true)
						--
						thePlayer:outputChat("* Acabas de ser entregado el Lider de la facción de Gobierno", 50, 150, 50, true)
						--
						insert("insert into `Facciones` VALUES (?,?,?,?,?,?,?)", 'Gobierno', AccountName(thePlayer), 'Juez Supremo', '0', 'Si', '', 'No')
						--
						player:setData("Roleplay:faccion", "Gobierno")
						player:setData("Roleplay:faccion_lider", "Si")
						player:setData("Roleplay:faccion_rango", "Juez Supremo")
						player:setData("Roleplay:faccion_sueldo", 0)
						player:setData("Roleplay:faccion_division", "")
						player:setData("Roleplay:faccion_division_lider", "No")
					else
						player:outputChat("* Ya se encuentra un lider en mando: #FF0033"..s[1]["Nombre"], 115, 115, 115, true)
					end
				end
			else
				player:outputChat("Syntax: /lidergobierno [ID]", 255, 255, 255, true)
			end
		end
	end
end)