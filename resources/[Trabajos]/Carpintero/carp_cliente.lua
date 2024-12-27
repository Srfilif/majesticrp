local sx_, sy_ = guiGetScreenSize()

local sx, sy = sx_/1360, sy_/768



local ValoresTrabajo = {}

local PosicionAuto = {}

local MarcadoresRuta = {}

local BlipsRuta = {}

local PedsRuta = {}

local TimerK = {}

local tableN = {}


addEventHandler("onClientRender", getRootElement(), function()

	--

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(getJobsCarpintero()) do

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

--

addEventHandler("onClientRender", getRootElement(), function()

	--

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(getJobsCarpintero()) do

		local playerX, playerY, playerZ = 2404.2509765625, -1316.1318359375, 25.273431777954

		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

		if sx and sy then

			local cx, cy, cz = getCameraMatrix()

			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)

			if distance < 20 then

				dxDrawBorderedText3 ( "#ffFFffUsa #ebde34/madera #ffFFffo pulsa #ebde34H #ffFFffPara recoger #fa5c23madera", sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 

			end

		end

	end

end)
--

function dxDrawBorderedText3( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )

	dxDrawText(text:gsub('#%x%x%x%x%x%x', ''), (x) + 1, (y) + 1, (w) + 1, (h) + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, true)

end


addEventHandler("onClientRender", getRootElement(), function()

	--

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(getJobsCarpintero()) do

		local playerX, playerY, playerZ = 2400.6186523438, -1305.9498291016, 26.375537872314 -1

		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

		if sx and sy then

			local cx, cy, cz = getCameraMatrix()

			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)

			if distance < 20 then

				dxDrawBorderedText3 ( "#ffFFffUsa #ebde34/construir #ffFFffo pulsa #ebde34H #ffFFffPara construir un #00ff00mueble", sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 

			end

		end

	end

end)



addEventHandler("onClientRender", getRootElement(), function()

	--

	local playerX2, playerY2, playerZ2 = getElementPosition ( localPlayer )

	for k, v in pairs(getJobsCarpintero()) do

		local playerX, playerY, playerZ = 2392.732421875, -1305.4384765625, 25.542459487915

		local sx, sy = getScreenFromWorldPosition(playerX, playerY, playerZ + 0.5)

		if sx and sy then

			local cx, cy, cz = getCameraMatrix()

			local distance = getDistanceBetweenPoints3D(playerX2, playerY2, playerZ2, playerX, playerY, playerZ + 0.5)

			if distance < 20 then

				dxDrawBorderedText3 ( "#ffFFffUsa #ebde34/vender #ffFFffo pulsa #ebde34H #ffFFffPara vender un #00ff00mueble", sx, sy, sx, sy , tocolor (0, 255, 0, 255 ),1, "default-bold","center", "center" ) 

			end

		end

	end

end)


addEventHandler("onClientResourceStart", resourceRoot, 
     function() 

engineImportTXD (engineLoadTXD("gun_dildo1.txd"), 321)
	engineReplaceModel(engineLoadDFF("gun_dildo1.dff", 321), 321)
     end 
) 