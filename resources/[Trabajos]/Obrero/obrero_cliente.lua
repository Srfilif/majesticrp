
addEvent("play_shop_sound1",true) 
addEventHandler("play_shop_sound1",getLocalPlayer(), 
function () 
local sound = playSound("pala.mp3") 
setSoundVolume(sound, 2.5) 
end) 

function destroyMarkersJardinero()

	for i=1, #MarkerMissionJardinero do

		if isElement(MarcadoresRuta[i]) then

			destroyElement(MarcadoresRuta[i])

			MarcadoresRuta[i] = nil

		end

		if isElement(BlipsRuta[i]) then

			destroyElement(BlipsRuta[i])

			BlipsRuta[i] = nil

		end

		if isElement(PedsRuta[i]) then

			destroyElement(PedsRuta[i])

			PedsRuta[i] = nil

		end

	end

	for i=1, #MarkerMissionJardinero2 do

		if isElement(MarcadoresRuta[i]) then

			destroyElement(MarcadoresRuta[i])

			MarcadoresRuta[i] = nil

		end

		if isElement(BlipsRuta[i]) then

			destroyElement(BlipsRuta[i])

			BlipsRuta[i] = nil

		end

		if isElement(PedsRuta[i]) then

			destroyElement(PedsRuta[i])

			PedsRuta[i] = nil

		end

	end

end



--

addEventHandler("onClientRender", getRootElement(), function()

	--

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(getJobsJardinero()) do

		local playerX, playerY, playerZ = v[1], v[2], v[3]

		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

		if sx and sy then

			local cx, cy, cz = getCameraMatrix()

			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)

			if distance < 20 then

				dxDrawBorderedText3 ( v[4], sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 

			end

		end

	end

end)



function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end