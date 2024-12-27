loadstring(exports.MySQL:getMyCode())()

import('*'):init('MySQL')



local MarkersJardinero = {}



addEventHandler("onResourceStart", resourceRoot, function()

	for i, v in ipairs(getJobsJardinero()) do

		--

		Blip( v[1], v[2], v[3], 56, 2, 255, 0, 0, 255, 0, 200, getRootElement() )

		--

		Pickup(v[1], v[2], v[3], 3, 1210, 0)

		MarkersJardinero[i] = Marker(v[1], v[2], v[3]-1, "cylinder", 1.5, 100, 100, 100, 0)

		MarkersJardinero[i]:setInterior(v.int)

		MarkersJardinero[i]:setDimension(v.dim)

		MarkersJardinero[i]:setData("MarkerJob", "Jardinero")

	end

end)



addCommandHandler("trabajar", function(player, cmd)

	if not player:isInVehicle() then
		for i, marker in ipairs(MarkersJardinero) do
			if player:isWithinMarker(marker) then

				local mjob = marker:getData("MarkerJob")

				if mjob == "Jardinero" then
-- Verificar si el jugador ya tiene el trabajo de "Carpintero"
if player:getData("Roleplay:trabajo") == "Jardinero" then
removeElementData(player, "objeto")
removeElementData(player, "silla")
player:outputChat("¡Ya estás trabajando aquí!", 150, 50, 50, true)
else
if player:getData("Roleplay:trabajo") == "" then
removeElementData(player, "objeto")
removeElementData(player, "silla")
player:setData("Roleplay:trabajo", "Jardinero")
player:outputChat("¡Bienvenido al trabajo de #ffff00Jardinero#ffffff!", 255, 255, 255, true)
else
player:outputChat("#ff3d3dNo puedes trabajar aquí. Ya tienes otro trabajo.", 255, 255, 255, true)
end
end
			end

		end

	end

						



end

end)


addCommandHandler("infojardinero", function(player, cmd)

	if not notIsGuest(player) then

		if not player:isInVehicle() then

			for i, v in ipairs(MarkersJardinero) do

				if player:isWithinMarker(v) then

					local job = v:getData("MarkerJob")

					if job == "Jardinero" then

						player:outputChat("¡Bienvenidos al trabajo de #ffff00Jardinero#ffffff!", 255, 255, 255, true)
						player:outputChat("Subete a un tractor y comienza a cosechar semillas", 255, 255, 255, true)
						player:outputChat("y Ten cuidado con las cosas ilegales", 255, 255, 255, true)

					end

				end

			end

		end
	end

end)



addCommandHandler("renunciar", function(player, cmd)

	if not player:isInVehicle() then

		--	if player:getData("Roleplay:trabajo") ~="" then
	
				for i, v in ipairs(MarkersJardinero) do
	
					if player:isWithinMarker(v) then
	
						local job = v:getData("MarkerJob")
	
						if job == "Jardinero" then
							if player:getData("Roleplay:trabajo") == "" then
								player:outputChat("¡No tienes trabajo, Consigue uno VAGO!!", 150, 50, 50, true)
							
							else
							if player:getData("Roleplay:trabajo") == "Jardinero" then
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

addEvent("drogas",true)
function drogas()
	local suerte = math.random(1,10)
	local exp = source:getData("Roleplay:ExpJobJardinero") or 1
	local mate = source:getData("semilla") or 0
	local mat = math.ceil(math.random(1,6))
	local mati = mate + mat
	print(mat)
	if suerte == 2 then
		text = "#FFFFFFAcabas de Encontrar: #FF0000"..convertNumber(mat).." semillas #ffffff al cosechar."
		source:setData("semilla",mati)
	else 
		text = ""
	end
end
addEventHandler("drogas", root, drogas)



addEvent("giveJardineroExp", true)

function giveJardineroExp()
	local suerte = math.random(1,7)
	local exp = source:getData("Roleplay:ExpJobJardinero") or 1
	local exp1 = math.random(1,2)
	local exp2 = exp1 + exp
	if (exp2 <= 20) then
	if suerte == 2 then
		text = "Acabas de obtener #E511E8"..exp1.." #ffffffexperiencia por trabajar."
		source:setData("Roleplay:ExpJobJardinero",exp2)
	else
		text = ""
	end
	source:outputChat(text, 255, 255, 255, true)
	else
	source:outputChat("Has llegado a #E511E8 20 #ffffffde experiencia que es el maximo", 255, 255, 255, true)
	end

end

addEventHandler("giveJardineroExp", root, giveJardineroExp)

